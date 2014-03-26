// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================
package com.gazman.life_cycle.utils.reflection
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedSuperclassName;

	public class Reflection
	{
		private var claz:Class;
		private var _xml:XML;
		
		public function Reflection(claz:Class)
		{
			this.claz = claz;
		}
		
		/**
		 * Faster than calling getSuperClasses() 
		 */
		public function getSuperClass():Class{
			var qualifiedSuperclassName:String = getQualifiedSuperclassName(claz);
			return getDefinitionByName(qualifiedSuperclassName) as Class;
		}
		
		public function getSuperClasses():Vector.<Class>{
			var list:XMLList = xml.factory.extendsClass.@type;
			var data:Vector.<Class> = new Vector.<Class>();
			for each (var xmlItem:XML in list) 
			{
				data.push(getDefinitionByName((xmlItem.toString())) as Class);
			}
			return data;
		}
		
		public function getPublicMethodes():Vector.<Method>{
			var list:XMLList = xml.factory.method;
			var data:Vector.<Method> = new Vector.<Method>();
			for each (var xmlItem:XML in list) 
			{
				data.push(new Method(xmlItem));
			}
			return data;
		}
		
		public function getInterfaces():Vector.<Class>{
			var list:XMLList = xml.factory.implementsInterface.@type;
			var data:Vector.<Class> = new Vector.<Class>();
			for each (var xmlItem:XML in list) 
			{
				data.push(getDefinitionByName((xmlItem.toString())) as Class);
			}
			return data;
		}
		
		private function get xml():XML
		{
			if(!_xml){
				_xml = describeType(claz);
			}
			return _xml;
		}
	}
}