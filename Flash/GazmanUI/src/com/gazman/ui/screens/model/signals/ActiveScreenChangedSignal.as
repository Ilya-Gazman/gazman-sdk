package com.gazman.ui.screens.model.signals
{
	import com.gazman.life_cycle.Signal;
	import com.gazman.ui.screens.BaseScreen;
	
	public class ActiveScreenChangedSignal extends Signal implements IActiveScreenChangedSignal
	{
		public function activeScreenChangeHandler(activeScreen:BaseScreen):void
		{
			dispatch(arguments);
		}
	}
}