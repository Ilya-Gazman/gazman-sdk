package com.gazman.ui.screens.signals.container_ready
{
	import com.gazman.life_cycle.Signal;
	
	public class ContainerIsReadySignal extends Signal implements IContainerIsReadySignal
	{
		public function containerIsReadyHandler():void
		{
			dispatch(arguments);
		}
	}
}