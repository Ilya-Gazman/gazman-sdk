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
	import com.gazman.life_cycle.Registrator;
	import com.gazman.ui.screens.signals.StarlingReadySignal;
	
	public class ScreensRegistrator extends Registrator
	{
		override protected function initClassesHandler():void
		{
			// TODO Auto Generated method stub
			super.initClassesHandler();
		}
		
		override protected function initRegistratorsHandler():void
		{
			// TODO Auto Generated method stub
			super.initRegistratorsHandler();
		}
		
		override protected function initSignalsHandler():void
		{
			registerSignal(StarlingReadySignal, ScreensManager);
		}
		
	}
}