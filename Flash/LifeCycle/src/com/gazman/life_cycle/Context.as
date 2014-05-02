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
	import com.gazman.life_cycle.signals.BootstrapComplete;

	/**
	 * Context is the main registrator. You should only have one context in each project.
	 */
	public class Context extends Registrator
	{
		/**
		 * Starts the main initialize process of the project.
		 */
		public function initialize():void{
			PrimeRegistrator.instace.addRegistrator(this);
			PrimeRegistrator.instace.excecute();
			var bootsrapComplete:BootstrapComplete = Factory.instance.inject(BootstrapComplete);
			bootsrapComplete.bootstrapComplete();
		}
	}
}