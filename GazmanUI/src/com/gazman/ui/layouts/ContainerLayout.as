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
	 * Layouting one component as he were inside the other
	 */
	public class ContainerLayout extends Layout
	{
		public var top:Number;
		public var bottom:Number;
		public var left:Number;
		public var right:Number;
		/**
		 * By setting horizontalCenter left and right will be ignored 
		 */		
		public var horizontalCenter:Number;
		/**
		 * By setting verticalCenter top and bottom will be ignored 
		 */		
		public var verticalCenter:Number;
		
		/**
		 * A shortcut to set horizontalCenter and verticalCenter
		 */
		public function center(horizontalCenter:Number = 0, verticalCenter:Number = 0):void{
			this.horizontalCenter = horizontalCenter;
			this.verticalCenter = verticalCenter;
		}
		
		/**
		 * Apply the layout on target relatively to relativeTo 
		 * @param target the target to layout
		 * @param relativeTo default target.parent
		 * 
		 */		
		override public function applyLayoutOn(target:DisplayObject, relativeTo:DisplayObject = null):void{
			if(!relativeTo){
				relativeTo = target.parent;
			}
			
			var x:Number = 0;
			var y:Number = 0;
			if(relativeTo != target.parent){
				x = relativeTo.x;
				y = relativeTo.y;
			}
			
			var targetHeight:Number = target.height;
			var targetWidth:Number = target.width;
			var relativeToHeight:Number = relativeTo.height;
			var relativeToWidth:Number = relativeTo.width;
			
			if(!isNaN(verticalCenter)){
				target.y = relativeTo.y + (relativeToHeight - targetHeight) / 2;
			}
			else if(!isNaN(top)){
				target.y = top + y;
				if(!isNaN(bottom)){
					target.height = relativeToHeight - top - bottom;
				}
			}
			else if(!isNaN(bottom)){
				target.y = y + relativeToHeight - bottom - targetHeight;
			}
			
			if(!isNaN(horizontalCenter)){
				target.x = x + (relativeToWidth - targetWidth) / 2;
			}
			else if (!isNaN(left)){
				target.x = x + left;
				if (!isNaN(right)){
					target.width = relativeToWidth - left - right;
				}
			}
			else if(!isNaN(right)){
				target.x = x + relativeToWidth - targetWidth - right;
			}
		}
		
		override public function clear():void
		{
			top = CLEAR_VALUE;
			bottom = CLEAR_VALUE;
			left = CLEAR_VALUE;
			right = CLEAR_VALUE;
			horizontalCenter = CLEAR_VALUE;
			verticalCenter = CLEAR_VALUE;
		}
		
	}
}