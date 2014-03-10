// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.list
{
	import com.gazman.components.list.view.ListScreenView;
	import com.gazman.components.menu.view.signals.list.IListSelectedSignal;
	import com.gazman.ui.screens.ScreenConnector;
	import com.gazman.ui.screens.ScreenView;
	
	public class ListConnector extends ScreenConnector implements IListSelectedSignal
	{
		public function listSelectedSignal():void
		{
			activateScreen();
		}
		
		override protected function createScreenView():ScreenView
		{
			return new ListScreenView();
		}
		
	}
}