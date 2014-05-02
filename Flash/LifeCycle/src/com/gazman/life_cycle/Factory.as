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
		private var classMap:Dictionary = new Dictionary(); 
		
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
				}
			}
			else{
				singleTon = singleTonHash[classToreturn];
				if (!singleTon) {
					singleTon = $new(classToreturn, params);
					singleTonHash[classToreturn] = singleTon;
				}
			}
			return singleTon;
		}
		
		/**
		 * return if instance of class a can be cast to instant of class b
		 */
		internal static function isSingleTon(claz:Class):Boolean{
			var reflection:Reflection = new Reflection(claz);
			
			var intarfaces:Vector.<Class> = reflection.getInterfaces();
			for(var i:int = 0; i < intarfaces.length; i++){
				if(intarfaces[i] == ISingleTon){
					return true;
				}
			}
			
			return false;
		}
	}
}