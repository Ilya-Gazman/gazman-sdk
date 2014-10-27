// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.life_cycle
{
	import com.gazman.life_cycle.utils.constractor.$new;
	import com.gazman.life_cycle.utils.reflection.Reflection;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedSuperclassName;
	
	internal class Factory
	{
		public static const instance:Factory = new Factory();
		
		private var singleTonHash:Dictionary = new Dictionary();
		private var singleTonExpector:Dictionary = new Dictionary();
		private const TRUE:Object = new Object();
		private const FALSE:Object = new Object();
		private var classMap:Dictionary = new Dictionary(); 
		
		public function Factory() 
		{
			super();
		}
		
		/**
		 * 
		 */
		public function registerClass(topLevelClass:Class, toWhatEnd:Class = null):void{
			if(toWhatEnd == null){
				toWhatEnd = Object;
			}
			var reflection:Reflection = new Reflection(topLevelClass);
			var supeCasses:Vector.<Class> = reflection.getSuperClasses();
			for(var i:int = 0; i < supeCasses.length && supeCasses[i] != toWhatEnd; i++){
				classMap[supeCasses[i]] = topLevelClass;
			}
		}
		
		private function getSuperClass(claz:Class):Class{
			var qualifiedSuperclassName:String = getQualifiedSuperclassName(claz);
			var returnValue:Class = getDefinitionByName(qualifiedSuperclassName) as Class;
			return returnValue;
		}
		
		
		/**
		 * @param classToReturn the class to create or retrive
		 * @param family used for Multiton pattern to have more than one Singleton from same type in the system
		 * @return instance of @classToReturn 
		 * @see http://en.wikipedia.org/wiki/Multiton_pattern
		 */
		public function inject(classToReturn:Class, family:String = null, params:Array = null):*{
			var classToUse:Class = classMap[classToReturn];
			if (classToUse == null) {
				classToUse = classToReturn;
			}
			
			var returnValue:*;
			if (isSingleTon(classToReturn)) {
				returnValue = getSingleTon(classToUse, family, params);
			}
			else {
				returnValue = $new(classToUse, params);
				if(returnValue is IInjectable){
					IInjectable(returnValue).injectionHandler();
				}
			}
			
			return returnValue;
		}
		
		private function getSingleTon(classToreturn:Class, key:String, params:Array):*{
			var singleTon:ISingleTon;
			if(key){
				var map:Object = singleTonHash[classToreturn];
				if(!map){
					map = new Object();
					singleTonHash[classToreturn] = map;
				}
				singleTon = map[key];
				if(!singleTon){
					singleTon = $new(classToreturn, params);
					map[key] = singleTon;
					if(singleTon is IInjectable){
						IInjectable(singleTon).injectionHandler();
					}
				}
			}
			else{
				singleTon = singleTonHash[classToreturn];
				if (!singleTon) {
					singleTon = $new(classToreturn, params);
					singleTonHash[classToreturn] = singleTon;
					if(singleTon is IInjectable){
						IInjectable(singleTon).injectionHandler();
					}
				}
			}
			return singleTon;
		}
		
		/**
		 * return if instance of class a can be cast to instant of class b
		 */
		internal function isSingleTon(claz:Class):Boolean{
			var object:Object = singleTonExpector[claz];
			if(object != null){
				return object == TRUE;
			}
			var returnValue:Boolean = false;
			var reflection:Reflection = new Reflection(claz);
			
			var intarfaces:Vector.<Class> = reflection.getInterfaces();
			for(var i:int = 0; i < intarfaces.length; i++){
				if(intarfaces[i] == ISingleTon){
					returnValue = true;
					break;
				}
			}
			
			singleTonExpector[claz] = returnValue ? TRUE : FALSE;
			
			return returnValue;
		}
	}
}