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
	import com.gazman.life_cycle.Registrator;
	import com.gazman.ui.screens.signals.root_created.RootCraetedSignal;
	
	public class MenuRegistrator extends Registrator
	{
		override protected function initSignalsHandler():void
		{
			registerSignal(RootCraetedSignal, MenuScreenView);
		}
		
	}
}