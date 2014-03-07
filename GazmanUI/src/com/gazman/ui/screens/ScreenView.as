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
	import com.gazman.ui.group.Group;
	
	import starling.animation.Juggler;
	import starling.events.Event;
	
	/**
	 * The root view of your screens.
	 */
	public class ScreenView extends Group
	{
		private var juggler:Juggler;
		
		public function ScreenView()
		{
			juggler = new Juggler();
		}
		
		internal function resume():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			onResume();
		}
		
		internal function pause():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			onPause();
		}
		
		internal function destroy():void{
			juggler.purge();
			onDestroy();
		}
		
		internal function startInjection():void
		{
			injectionHandler();
		}
		
		/**
		 * At this point you should remove all the data used by screen view
		 */
		protected function onDestroy():void{}
		/**
		 * Called when the screen is getting to the top of the screens stack
		 */
		protected function onResume():void{}
		/**
		* Called when the screen is no longer on the top of the screens stack
		*/
		protected function onPause():void{}
		/**
		 * The main registration point for all your injections
		 */
		protected function injectionHandler():void{}
		
		private function onEnterFrame(event:Event, passedTime:Number):void
		{
			juggler.advanceTime(passedTime);
		}
	}
}