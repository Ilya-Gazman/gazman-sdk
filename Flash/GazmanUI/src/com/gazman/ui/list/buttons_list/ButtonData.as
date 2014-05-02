// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.list.buttons_list
{
	public class ButtonData
	{
		public var callBack:Function;
		public var lable:String;
		
		public function ButtonData(lable:String, callBack:Function)
		{
			this.lable = lable;
			this.callBack = callBack;
		}
		
		public function toString():String{
			return lable;
		}
	}
}