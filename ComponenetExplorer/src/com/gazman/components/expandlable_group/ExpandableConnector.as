// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.expandlable_group
{
	import com.gazman.components.expandlable_group.view.ExpandableScreenView;
	import com.gazman.components.menu.view.signals.expandable_group.IExpandableSelectedSignal;
	import com.gazman.ui.screens.ScreenConnector;
	import com.gazman.ui.screens.ScreenView;
	
	public class ExpandableConnector extends ScreenConnector implements IExpandableSelectedSignal
	{
		override protected function createScreenView():ScreenView
		{
			return new ExpandableScreenView();
		}
		
		public function expandableSelectedHandler():void
		{
			activateScreen();
		}
		
	}
}