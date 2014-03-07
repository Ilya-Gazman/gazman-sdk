// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.screens
{
	import com.gazman.life_cycle.inject;

	/**
	 * It connect between starling DisplayObject to LifeCycle SingleTon, and allows you to perform mapping during the main initialization process
	 */
	public class ScreenConnector extends BaseScreen
	{
		private var screenManger:ScreensManager;
		
		override protected function injectionHandler():void{
			super.injectionHandler();
			screenManger = inject(ScreensManager);
		}
		
		/**
		 * add the screen to the head of the screens stack, and make it active
		 */
		protected function activateScreen():void{
			screenManger.pushScreen(this);
		}
		
		/**
		 * Remove the screen from screens stack
		 */
		protected function remove():void{
			screenManger.removeScreen(this);
		}
	}
}