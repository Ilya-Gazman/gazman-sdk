package com.gazman.ui.screens.signals.root_created
{
	import com.gazman.life_cycle.Signal;
	
	public class RootCraetedSignal extends Signal implements IRootCratedSignal
	{
		public function rootCratedHandler():void
		{
			dispatch(arguments);
		}
	}
}