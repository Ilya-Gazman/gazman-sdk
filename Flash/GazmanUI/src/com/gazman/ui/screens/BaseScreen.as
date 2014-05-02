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
	import com.gazman.ui.group.Group;
	import com.gazman.ui.screens.model.ScreenModel;
	
	import starling.errors.AbstractClassError;
	
	public class BaseScreen extends Group
	{
		/**
		 * When fifo mode is set, the screen will be aded to the head of the queue. 
		 * If fifo mode is off, the screen will be pushed to the tail.
		 */
		protected var fifoMode:Boolean = true;
		private var screenModel:ScreenModel = inject(ScreenModel, family);
		
		
		public function resumeHandler():void{
			
		}
		
		public function pauseHandler():void{
			
		}
		
		/**
		 * Remove the screen from screens stack
		 */
		protected final function close():void{
			screenModel.removeScreen(this);
		}
		
		/**
		 * Add the screen to screens stack
		 */
		protected final function open():void{
			screenModel.puch(this, fifoMode);
		}

		protected function get family():String
		{
			throw new AbstractClassError();
		}

	}
}