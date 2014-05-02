package com.gazman.components
{
	import com.gazman.components.screens.ScreensContainer;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.utils.SpaceContainer;
	
	public class RootView extends Group
	{
		private var background:SpaceContainer;
		private var screensContainer:ScreensContainer;
		
		override protected function initilize():void
		{
			screensContainer = inject(ScreensContainer);
			background = inject(SpaceContainer);
			background.width = stage.stageWidth;
			background.width = stage.stageHeight;
			addChild(background);
			addChild(screensContainer);
		}
	}
}