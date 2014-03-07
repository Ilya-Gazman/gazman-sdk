// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.life_cycle
{
	/**
	 * The heart of the main initialization process.
	 */
	public class Injector
	{
		internal function startInjection():void{
			injectionHandler();
		}
		
		/**
		 * Will be called at time tof the main injection process
		 */
		protected function injectionHandler():void{}
		
		/**
		 * Can be used to register to signal as not part of the main registration/maping process that done in the Registrators. Use this method if your class
		 * have different life cycle than the application life cycle.
		 * 
		 * @param signalClass The signal class to map
		 * @param handler listener
		 */		
		protected function registerToSignal(signalClass:Class, handler:Function):void{
			var signal:Signal = inject(signalClass);
			signal.addListener(handler);
		}
	}
}