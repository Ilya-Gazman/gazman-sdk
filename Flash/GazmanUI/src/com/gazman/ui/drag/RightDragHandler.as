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
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	internal class RightDragHandler extends DragHandler
	{
		private var isDraging:Boolean;
		private var clipingRect:Rectangle = new Rectangle();
		private var point:Point = new Point();
		
		/**
		 * Stage.mouseLock need to be true
		 */
		public function RightDragHandler(target:DisplayObject)
		{
			super(target);
		}
		
		override protected function registerEvents():void{
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onMouseDown);
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onMouseUp);
			Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			isDraging = false;
			dragFinishSignal.dragFinishHandler();
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			if (!isContainList(event)){
				return;
			}
			isDraging = true;
			dragBeginSignal.dragBeginHandler();
		}
		
		private var previuseX:Number = NaN;
		private var previuseY:Number = NaN;
		
		private function onMove(event:MouseEvent):void
		{
			if (isContainList(event) && isDraging){
				dragSignal.dragHandler(event.stageX - previuseX, event.stageY - previuseY);
			}

			previuseX = event.stageX;
			previuseY = event.stageY;
		}
		
		private function isContainList(event:MouseEvent):Boolean
		{
			var clipingRect:Rectangle = target.getBounds(target, this.clipingRect);
			if(!clipingRect){
				return false;
			}
			point.x = event.stageX;
			point.y = event.stageY;
			target.globalToLocal(point, point);
			
			return clipingRect.containsPoint(point)
		}
	}
}