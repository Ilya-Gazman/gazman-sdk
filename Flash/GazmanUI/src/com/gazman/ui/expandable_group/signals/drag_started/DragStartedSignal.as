package com.gazman.ui.expandable_group.signals.drag_started
{
	import com.gazman.life_cycle.Signal;
	
	public class DragStartedSignal extends Signal implements IDragStartedSignal
	{
		public function dragStartedHandler():void
		{
			dispatch(arguments);
		}
	}
}