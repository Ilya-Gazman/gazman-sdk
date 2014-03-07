// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.layout
{
	import com.gazman.components.layout.view.LayoutScreenView;
	import com.gazman.components.menu.view.signals.layout.ILayoutSelectedSignal;
	import com.gazman.ui.screens.ScreenConnector;
	import com.gazman.ui.screens.ScreenView;
	
	public class LayoutConnector extends ScreenConnector implements ILayoutSelectedSignal
	{
		override protected function createScreenView():ScreenView
		{
			return new LayoutScreenView();
		}
		
		public function layoutSelectedSignal():void
		{
			activateScreen();
		}
		
	}
}