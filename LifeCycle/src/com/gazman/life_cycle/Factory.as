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
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedSuperclassName;
	
	internal class Factory
	{
		public static const instance:Factory = new Factory();
		
		private var singleTonHash:Dictionary = new Dictionary();
		private var classMap:Dictionary = new Dictionary(); 
		
		public function registerClass(topLevelClass:Class):void{
			var superClass:Class = getSuperClass(topLevelClass);
			do{
				classMap[superClass] = topLevelClass;
			}while(superClass != null && superClass != SingleTon && superClass != Injector);
		}
		
		private function getSuperClass(claz:Class):Class{
			var qualifiedSuperclassName:String = getQualifiedSuperclassName(claz);
			var returnValue:Class = getDefinitionByName(qualifiedSuperclassName) as Class;
			return returnValue;
		}
		
		
		public function inject(classToReturn:Class):*{
			var classToUse:Class = classMap[classToReturn];
			var returnValue:*;
			if (classToUse == null) {
				classToUse = classToReturn;
			}
			
			if (isInstance(classToReturn, SingleTon)) {
				returnValue = getSingleTon(classToUse);
			}
			else {
				returnValue = new classToUse();
				if (returnValue is Injector) {
					returnValue.startInjection();
				}
			}
			
			return returnValue;
		}
		
		private function getSingleTon(classToreturn:Class):*{
			var singleTon:SingleTon = singleTonHash[classToreturn];
			if (singleTon == null) {
				singleTon = new classToreturn();
				singleTonHash[classToreturn] = singleTon;
				if (singleTon is Injector) {
					singleTon.startInjection();
				}
			}
			return singleTon;
		}
		
		/**
		 * return if instance of class a can be cast to instant of class b
		 */
		private function isInstance(a:Class, b:Class):Boolean{
			if (int(!a) | int(!b)) {
				return false;
			}
			// Please ignore this worning. instanceof is necessary here.
			return (a == b || a.prototype instanceof b);
		}
	}
}