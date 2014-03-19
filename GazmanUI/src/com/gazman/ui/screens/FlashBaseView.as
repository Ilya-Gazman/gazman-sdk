package com.gazman.ui.screens
{
	import com.gazman.life_cycle.Context;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.screens.signals.root_created.RootCraetedSignal;
	
	import flash.display.Sprite;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * Handle Starling and LifeCycle initilization.<br><br>
	 * Dont forget to add:<br>
	 * [SWF(width="960",height="640",frameRate="60",backgroundColor="#ffffff")] 
	 */
	public class FlashBaseView extends Sprite
	{
		/**
		 * Initialize Starling and LifeCycle
		 * @param lifeCycleContext your application context
		 * @param RootView A subclass of a Starling display object. It will be created as soon as initialization is finished and will become the first child of the Starling stage.
		 * 
		 */
		protected function initialize(lifeCycleContext:Context, RootView:Class):void{
			lifeCycleContext.initialize();
			var starlingInstance:Starling = new Starling(RootView, stage);
			starlingInstance.addEventListener(Event.ROOT_CREATED, rootCreatedHandler);
			starlingInstance.start();
		}
		
		private function rootCreatedHandler():void
		{
			// fire RootCraetedSignal
			inject(RootCraetedSignal).rootCratedHandler();
		}
	}
}