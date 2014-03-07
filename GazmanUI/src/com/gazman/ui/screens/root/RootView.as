// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.screens.root
{
	import com.gazman.ui.screens.BaseStarlingView;
	import com.gazman.ui.utils.setInitListener;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	/**
	 * Base Flash Application view, to simplify starling initialization process. Don't forget to add this meta data:
	 * <p>[SWF(width="960",height="640",frameRate="60",backgroundColor="#4a4137")]</p>
	 */
	public class RootView extends Sprite
	{
		public function RootView()
		{
			setInitListener(this, initilize);
		}
		
		private function initilize():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var starlingInstance:Starling = new Starling(BaseStarlingView, this.stage);
			starlingInstance.start();
		}
	}
}