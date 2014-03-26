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
	import com.gazman.ui.drag.signals.drag.DragSignal;
	import com.gazman.ui.drag.signals.drag_begin.DragBeginSignal;
	import com.gazman.ui.drag.signals.drag_finish.DragFinishSignal;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	internal class DragHandler
	{
		
		public const dragBeginSignal:DragBeginSignal = new DragBeginSignal();
		public const dragFinishSignal:DragFinishSignal = new DragFinishSignal();
		public const dragSignal:DragSignal = new DragSignal();
		
		private var isDraging:Boolean;

		protected var target:DisplayObject;
		private var haveMoved:Boolean;

		/**
		 * 
		 * @param target the DisplayObject to listend for drag events
		 * 
		 */
		public function DragHandler(target:DisplayObject)
		{
			this.target = target;
			registerEvents();
		}
		
		protected function registerEvents():void
		{
			target.addEventListener(TouchEvent.TOUCH, onTouch);
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
		}
		
		private function onStageTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(target.stage);
			if(!touch){
				return;
			}
			switch(touch.phase){
				case TouchPhase.ENDED:
					if(isDraging && haveMoved){
						isDraging = false;
						haveMoved = false;
						dragFinishSignal.dragFinishHandler();
					}
					break;
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(target);
			if(!touch){
				return;
			}
			switch(touch.phase){
				case TouchPhase.BEGAN:
					if(isDraging && !haveMoved){
						return;
					}
					isDraging = true;
					dragBeginSignal.dragBeginHandler();
					break;
				case TouchPhase.MOVED:
					if (touch && isDraging)
					{
						haveMoved = true;
						var localPos:Point = touch.getLocation(target);
						var deltaX:Number = touch.globalX - touch.previousGlobalX;
						var deltaY:Number = touch.globalY - touch.previousGlobalY;
						dragSignal.dragHandler(deltaX, deltaY);
					}
					break;
			}
		}
	}
}