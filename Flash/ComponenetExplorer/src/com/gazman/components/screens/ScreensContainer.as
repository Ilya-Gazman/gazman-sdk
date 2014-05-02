package com.gazman.components.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.screens.BaseScreen;
	import com.gazman.ui.screens.BaseScreensContainer;
	
	public class ScreensContainer extends BaseScreensContainer
	{
		public static const FAMILY:String = "Screens";
		private var containerLayout:ContainerLayout;
		
		override protected function initilize():void
		{
			super.initilize();
			containerLayout = inject(ContainerLayout);
			containerLayout.center();
		}
		
		override public function activeScreenChangeHandler(activeScreen:BaseScreen):void
		{
			super.activeScreenChangeHandler(activeScreen);
			containerLayout.applyLayoutOn(this, parent);
		}
		
		override protected function get family():String
		{
			return FAMILY;
		}
		
	}
}