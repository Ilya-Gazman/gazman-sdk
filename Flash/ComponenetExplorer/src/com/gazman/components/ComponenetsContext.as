// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components
{
	import com.gazman.components.expandlable_group.ExpandableRegistrator;
	import com.gazman.components.layout.LayoutRegistrator;
	import com.gazman.components.list.ListRegistrator;
	import com.gazman.components.menu.MenuRegistrator;
	import com.gazman.life_cycle.Context;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.UIRegistrator;
	
	public class ComponenetsContext extends Context
	{
		override protected function initClassesHandler():void
		{
			super.initClassesHandler();
		}
		
		override protected function initRegistratorsHandler():void
		{
			addRegistrator(inject(UIRegistrator));
			addRegistrator(inject(LayoutRegistrator));
			addRegistrator(inject(ListRegistrator));
			addRegistrator(inject(MenuRegistrator));
			addRegistrator(inject(ExpandableRegistrator));
		}
		
		override protected function initSignalsHandler():void
		{
			super.initSignalsHandler();
		}
		
	}
}