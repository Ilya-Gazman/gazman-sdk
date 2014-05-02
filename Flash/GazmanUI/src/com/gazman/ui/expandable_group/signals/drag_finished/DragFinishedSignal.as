package com.gazman.ui.expandable_group.signals.drag_finished
{
	import com.gazman.life_cycle.Signal;
	
	public class DragFinishedSignal extends Signal implements IDragFinishedSignal
	{
		public function dragFinishedHandler():void
		{
			dispatch(arguments);
		}
	}
}