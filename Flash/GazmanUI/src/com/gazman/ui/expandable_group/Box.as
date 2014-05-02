// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.expandable_group
{
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	internal class Box extends Quad
	{
		private static const SIZE:int = 30;
		
		private var draging:Boolean = false;

		protected var container:ExpandableGroup;
		
		public function Box(container:ExpandableGroup)
		{
			super(SIZE, SIZE, 0);
			alpha = 0.5;
			this.container = container;
			if(stage){
				init();
			}
			else{
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		private function onAddToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			init();
		}
		
		private function init():void
		{
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(TouchEvent.TOUCH, onThisTouch);
		}
		
		private function onThisTouch(event:TouchEvent):void
		{
			Mouse.cursor = event.interactsWith(this) ? MouseCursor.HAND : MouseCursor.AUTO;
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this);
			if(touches.length == 0){
				if(draging){
					var touch:Touch = event.getTouch(stage);
					if(touch){
						handleTouch(event.getTouch(stage), false);
					}
				}
			}
			else{
				for(var i:int = 0; i < touches.length; i++){
					handleTouch(touches[i], true);
				}
			}
		}
		
		private function handleTouch(touch:Touch, allowBegan:Boolean):void
		{
			switch(touch.phase){
				case TouchPhase.MOVED:
					onDrag(touch.globalX - touch.previousGlobalX, touch.globalY - touch.previousGlobalY);
					break;
				case TouchPhase.ENDED:
					draging = false;
					onDragFinished();
					break;
				case TouchPhase.BEGAN:
					if(allowBegan){
						draging = true;
						onDragStarted();
					}
					break;
			}
		}
		
		protected function onDragStarted():void
		{
			container.dragStarted();
		}
		
		protected function onDragFinished():void
		{
			container.dragFinished();
		}
		
		protected function onDrag(deltaX:Number, deltaY:Number):void
		{
			x += deltaX;
			y += deltaY;
			container.updateSizeAndPositionsByBoxes(deltaX, deltaY);
		}
	}
}