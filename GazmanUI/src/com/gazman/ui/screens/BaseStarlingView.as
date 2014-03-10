// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.screens.signals.StarlingReadySignal;
	import com.gazman.ui.utils.setInitListener;
	
	import starling.display.Sprite;
	
	/**
	 * The root view of starling
	 */
	public class BaseStarlingView extends Sprite
	{
		public function BaseStarlingView()
		{
			setInitListener(this, initilize);
		}
		
		private function initilize():void
		{
			(inject(StarlingReadySignal) as StarlingReadySignal).startlingReadyHandler(this);
		}
	}
}