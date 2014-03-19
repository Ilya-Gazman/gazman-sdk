package com.gazman.ui.screens.model.signals
{
	import com.gazman.ui.screens.BaseScreen;

	public interface IActiveScreenChangedSignal
	{
		function activeScreenChangeHandler(activeScreen:BaseScreen):void;
	}
}