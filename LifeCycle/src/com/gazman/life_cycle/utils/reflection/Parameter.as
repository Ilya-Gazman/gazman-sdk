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

	public class Parameter
	{
		private var _optional:Boolean;
		private var _type:Class;
		
		public function Parameter(xml:XML){
			_optional = xml.attribute("optional").toString() == "true";
			var clasName:String = xml.attribute("type");
			_type = getDefinitionByName(clasName) as Class;
		}

		public function get type():Class
		{
			return _type;
		}

		public function get optional():Boolean
		{
			return _optional;
		}

	}
}