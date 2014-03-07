// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.life_cycle.utils
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public function getInterfaces(value:*):Vector.<Class>
	{
		var xmlData:XML = describeType(value);
		var list:XMLList = xmlData.implementsInterface.@type;
		var data:Vector.<Class> = new Vector.<Class>();
		for each (var xml:XML in list) 
		{
			data.push(getDefinitionByName((xml.toString())) as Class);
		}
		
		return data;
	}
	
}