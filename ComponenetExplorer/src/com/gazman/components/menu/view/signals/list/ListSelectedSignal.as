// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.menu.view.signals.list
{
	import com.gazman.life_cycle.Signal;
	
	public class ListSelectedSignal extends Signal implements IListSelectedSignal
	{
		public function listSelectedSignal():void
		{
			dispatch(arguments);
		}
	}
}