// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.drag
{
	import com.gazman.ui.drag.signals.drag.IDragSignal;
	
	import starling.display.DisplayObject;
	
	/**
	 * Draging DisplayObject
	 */
	public class SimpleDragHandler implements IDragSignal
	{
		public var allowHorizontalDrag:Boolean = true;
		public var allowVerticalDrag:Boolean = true;
		
		protected var target:IDragable;
		protected var dragHandlerInstance:DragHandler;
		
		public function SimpleDragHandler(target:IDragable, useRightClick:Boolean = false)
		{
			this.target = target;
			if(useRightClick){
				dragHandlerInstance = new RightDragHandler(target as DisplayObject);
			}
			else{
				dragHandlerInstance = new DragHandler(target as DisplayObject);
			}
			dragHandlerInstance.dragSignal.addListener(this);
		}
		
		public function dragHandler(deltaX:Number, deltaY:Number):void
		{
			if(!allowHorizontalDrag){
				deltaX = 0;
			}
			if(!allowVerticalDrag){
				deltaY = 0;
			}
			target.updateViewPort(Math.round(deltaX), Math.round(deltaY));
		}
		
	}
}