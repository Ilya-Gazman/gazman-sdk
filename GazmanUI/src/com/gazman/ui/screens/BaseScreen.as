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
	import com.gazman.life_cycle.SingleTon;
	import com.gazman.life_cycle.inject;
	
	import starling.events.Event;
	
	/**
	 * Manage the life cycle of ScreenView
	 */
	public class BaseScreen extends SingleTon
	{
		private var screenView:ScreenView;
		private var screensManager:ScreensManager;
		protected var removeChildOnPause:Boolean = true;
		
		override protected function injectionHandler():void{
			super.injectionHandler();
			screensManager = inject(ScreensManager);
			screenView = createScreenView();
			if(!screenView){
				throw new Error("Abstract methode createScreenView() is not implemented");
			}
			screenView.startInjection();
		}
		
		internal function create():void{
			// invokes the initilized
			if(screensManager.baseView == null){
				throw new Error("Make sure you register ScreensRegistraror");
			}
			screensManager.baseView.addChild(screenView);
			resume();
		}
		
		internal function pause():void{
			if(removeChildOnPause){
				screensManager.baseView.removeChild(screenView);
			}
			screenView.pause();
		}
		
		internal function resume():void{
			if(!screenView.parent){
				screensManager.baseView.addChild(screenView);
				screenView.addEventListener(Event.ADDED_TO_STAGE, onAddToStageFromResume);
			}
			else{
				screenView.resume();
			}
		}
		
		private function onAddToStageFromResume():void
		{
			screenView.removeEventListener(Event.ADDED_TO_STAGE, onAddToStageFromResume);
			screenView.resume();
		}
		
		internal function clean():void{
			pause();
			screenView.destroy();
		}
		
		/**
		 * An abstract method for creating ScreenView, It is recomand to create the screen using inject().
		 */
		protected function createScreenView():ScreenView{return null}
	}
}