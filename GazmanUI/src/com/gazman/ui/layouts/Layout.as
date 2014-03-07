// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.layouts
{
	import starling.display.DisplayObject;

	public class Layout
	{
		public static const CLEAR_VALUE:Number = 0/0; // NaN - Not a number
		
		/**
		 * 
		 * @param target Whos layout is going to be edited
		 * @param relativeTo if not set the default is target.parent
		 */		
		public function applyLayoutOn(target:DisplayObject, relativeTo:DisplayObject = null):void{
			
		}
		
		/**
		 * Reset all the settings
		 */
		public function clear():void{
			
		}
	}
}