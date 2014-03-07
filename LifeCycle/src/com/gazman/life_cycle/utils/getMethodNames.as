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

	public function getMethodNames(value:*):Vector.<String>
	{
		var xmlData:XML = describeType(value);
		var list:XMLList = xmlData.factory.method.@name;
		var data:Vector.<String> = new Vector.<String>();
		for each (var xml:XML in list) 
		{
			data.push(xml.toString());
		}
		
		return data;
	}
}