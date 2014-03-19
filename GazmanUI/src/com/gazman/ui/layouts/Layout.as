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
		/**
		 * If set: Will round target [x, y, widht, height] properties, when layout is complete.<br>
		 * <b>True</b> by default
		 */		
		public var round:Boolean = true;
		public static const CLEAR_VALUE:Number = 0/0; // NaN - Not a number
		
		/**
		 * 
		 * @param target Whos layout is going to be edited
		 * @param relativeTo if not set the default is target.parent
		 */		
		public final function applyLayoutOn(target:DisplayObject, relativeTo:DisplayObject = null):void{
			applyLayoutHandler(target, relativeTo);
			if(round){
				target.x = Math.round(target.x);
				target.y = Math.round(target.y);
				target.width = Math.round(target.width);
				target.height = Math.round(target.height);
			}
		}
		
		protected function applyLayoutHandler(target:DisplayObject, relativeTo:DisplayObject = null):void
		{
		}
		
		/**
		 * Reset all the settings
		 */
		public function clear():void{
			
		}
	}
}