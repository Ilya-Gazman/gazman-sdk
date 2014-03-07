// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.screens.signals
{
	import com.gazman.life_cycle.Signal;
	
	import starling.display.Sprite;
	
	/**
	 * Starling initilization is complete and starling Stage is created.
	 */
	public class StarlingReadySignal extends Signal implements IStarlingIsReady
	{
		public function startlingReadyHandler(baseView:Sprite):void
		{
			dispatch(arguments);
		}
	}
}