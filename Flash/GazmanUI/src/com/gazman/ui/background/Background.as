// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.background
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.group.strict.StrictGroup;
	
	import starling.display.Quad;
	
	public class Background extends StrictGroup
	{
		protected var quad:Quad; 
		private var _color:uint;
		private var frame:Frame = inject(Frame);
		
		override protected function addChildrenHandler():void
		{
			quad = injectWithParams(Quad, [1,1,_color]);
			addChild(quad);
			addChild(frame);
		}
		
		override protected function initLayout():void
		{
			invalidate();
		}
		
		override protected function verifyDependencies():Boolean
		{
			return subscribeForInitilize(parent as Group);
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
			if(quad){
				quad.color = value;
			}
		}
		
		public function set frameSize(value:Number):void{
			frame.thikness = value;
		}
		
		/**
		 * By deafualt there is no frame, the size is 0. When you set frame size, frame is added with the size you requested.
		 */
		public function get frameSize():Number{
			return frame.thikness;
		}
		
		public function set frameColor(value:Number):void{
			frame.color = value;
		}
		
		/**
		 * By deafualt there is no frame. When you set frame color, frame is added, how ever to see it you must also set frameSize.
		 */
		public function get frameColor():Number{
			if(frame == null){
				return 0;
			}
			return frame.color;
		}
		
		/**
		 * Update the frame and background size
		 */
		public function invalidate():void
		{
			if(quad){
				quad.width = parent.width;
				quad.height = parent.height;
			}
			frame.width = parent.width;
			frame.height = parent.height;
		}		
	}
}