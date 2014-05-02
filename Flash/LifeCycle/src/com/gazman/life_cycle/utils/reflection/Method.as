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
	import flash.utils.getDefinitionByName;

	public class Method
	{
		private var _name:String;
		private var _declaredBy:Class;
		private var _parameters:Vector.<Parameter> = new Vector.<Parameter>();
		private var _returnType:Class;
		
		public function Method(xml:XML){
			_name = xml.attribute("name");
			var clasName:String = xml.attribute("declaredBy");
			_declaredBy = getDefinitionByName(clasName) as Class;
			clasName = xml.attribute("returnType");
			if(clasName != "void"){
				_returnType = getDefinitionByName(clasName) as Class;
			}
			var list:XMLList = xml.parameter;
			for each (var xmlItem:XML in list){
				var parameter:Parameter = new Parameter(xmlItem);
				_parameters.push(parameter);
			}
		}
		
		public function get returnType():Class
		{
			return _returnType;
		}

		public function get parameters():Vector.<Parameter>
		{
			return _parameters;
		}

		public function get declaredBy():Class
		{
			return _declaredBy;
		}

		public function get name():String
		{
			return _name;
		}

	}
}