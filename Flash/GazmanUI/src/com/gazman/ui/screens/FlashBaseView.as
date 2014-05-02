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
	import com.gazman.life_cycle.Context;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.screens.signals.root_created.RootCraetedSignal;
	import com.gazman.ui.screens.signals.stage_touch_ended.StageTouchEndedSignal;
	
	import flash.display.Sprite;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Handle Starling and LifeCycle initilization.<br><br>
	 * Dont forget to add:<br>
	 * [SWF(width="960",height="640",frameRate="60",backgroundColor="#ffffff")] 
	 */
	public class FlashBaseView extends Sprite
	{
		private var stageTouchEndedSignal:StageTouchEndedSignal;
		/**
		 * Initialize Starling and LifeCycle
		 * @param lifeCycleContext your application context
		 * @param RootView A subclass of a Starling display object. It will be created as soon as initialization is finished and will become the first child of the Starling stage.
		 * 
		 */
		protected function initialize(lifeCycleContext:Context, RootView:Class):void{
			lifeCycleContext.initialize();
			initInjections();
			var starlingInstance:Starling = new Starling(RootView, stage);
			starlingInstance.addEventListener(Event.ROOT_CREATED, rootCreatedHandler);
			starlingInstance.start();
		}
		
		private function initInjections():void
		{
			stageTouchEndedSignal = inject(StageTouchEndedSignal);
		}
		
		private function rootCreatedHandler():void
		{
			// fire RootCraetedSignal
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchHandler);
			inject(RootCraetedSignal).rootCratedHandler();
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			var toch:Touch = event.getTouch(Starling.current.stage, TouchPhase.ENDED);
			if(toch != null){
				stageTouchEndedSignal.stageTouchEndedHandler();
			}
		}
	}
}