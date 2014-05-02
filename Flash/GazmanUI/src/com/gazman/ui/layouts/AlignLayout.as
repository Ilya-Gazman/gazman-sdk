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
	
	/**
	 * Taking position of one component to set the postition of another component with small manipulations
	 */
	public class AlignLayout extends Layout
	{
		public var below:Number;
		public var above:Number;
		public var toLeft:Number;
		public var toRight:Number;
		
		/**
		 * Apply the layout on target relatively to relativeTo 
		 * @param target the target to layout
		 * @param relativeTo default target.parent
		 */		
		override protected function applyLayoutHandler(target:DisplayObject, relativeTo:DisplayObject):void{
			validate();
			
			if(!isNaN(above)){
				target.y = relativeTo.y - target.height - above;
			}
			else if(!isNaN(below)){
				target.y = relativeTo.y + relativeTo.height + below;
			}
			
			if(!isNaN(toRight)){
				target.x = relativeTo.x + relativeTo.width + toRight;
			}
			else if(!isNaN(toLeft)){
				target.x = relativeTo.x - target.width - toLeft;
			}
		}
		/**
		 * Reset all the settings
		 */
		override public function clear():void
		{
			below = CLEAR_VALUE;
			above = CLEAR_VALUE;
			toLeft = CLEAR_VALUE;
			toRight = CLEAR_VALUE;
		}
		
		private function validate():void
		{
			if(!isNaN(toRight) && !isNaN(toLeft)){
				throw new Error("Cannot set both toRight and toLeft");
			}
			
			if(!isNaN(below) && !isNaN(above)){
				throw new Error("Cannot set both above and below");
			}
		}
		
	}
}