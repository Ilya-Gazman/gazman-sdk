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
	import com.gazman.ui.drag.signals.drag_begin.IDragBeginSignal;
	import com.gazman.ui.drag.signals.drag_finish.IDragFinishSignal;
	
	import starling.animation.Juggler;
	
	/**
	 * Draging DisplayObject with animation
	 */
	public class SmoothDragHandler extends SimpleDragHandler implements IDragFinishSignal, IDragBeginSignal
	{
		/**
		 * As bigger the power as longer it drags
		 */
		public var power:Number = 1.5;
		/**
		 * as bigger this value as faster it stops
		 */
		public var minemumPower:Number = 2; 
		
		private var deltaX:Number;
		private var deltaY:Number;
		private var animation:AnimationListener;
		
		/**
		 *  
		 * @param target IDragable DisplayObject
		 * @param useRightClick for desktop only, use the right mouse button to drag
		 * 
		 */
		public function SmoothDragHandler(target:IDragable, useRightClick:Boolean = false)
		{
			super(target, useRightClick);
			animation = new AnimationListener(target);
			dragHandlerInstance.dragFinishSignal.addListener(this);
			dragHandlerInstance.dragBeginSignal.addListener(this);
		}
		
		/**
		 * Drag duration
		 */
		public function get duration():Number
		{
			return animation.duration;
		}

		public function set duration(value:Number):void
		{
			animation.duration = value;
		}

		/**
		 * Drag jugler, if not set Starling defult is used
		 */
		public function get jugler():Juggler
		{
			return animation.jugler;
		}

		public function set jugler(value:Juggler):void
		{
			animation.jugler = value;
		}

		override public function dragHandler(deltaX:Number, deltaY:Number):void{
			super.dragHandler(deltaX, deltaY);
			if(!allowHorizontalDrag){
				deltaX = 0;
			}
			if(!allowVerticalDrag){
				deltaY = 0;
			}
			this.deltaX = deltaX;
			this.deltaY = deltaY;
		}
		
		public function dragFinishHandler():void
		{
			deltaX *= power;
			deltaY *= power;

			if(Math.abs(deltaX) < minemumPower){
				deltaX = 0;
			}
			if(Math.abs(deltaY) < minemumPower){
				deltaY = 0;
			}
			
			animation.start(deltaX, deltaY);
		}
		
		public function dragBeginHandler():void
		{
			animation.stop();
		}
		
	}
}