// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.menu
{
	import com.gazman.components.menu.view.MenuScreenView;
	import com.gazman.ui.screens.ScreenConnector;
	import com.gazman.ui.screens.ScreenView;
	import com.gazman.ui.screens.signals.IStarlingIsReady;
	
	import starling.display.Sprite;
	
	public class MenuConnector extends ScreenConnector implements IStarlingIsReady
	{
		override protected function createScreenView():ScreenView
		{
			return new MenuScreenView();
		}
		
		public function startlingReadyHandler(baseView:Sprite):void
		{
			activateScreen();
		}
		
	}
}