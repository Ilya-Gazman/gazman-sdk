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
	 * Registrator is the entry point to your component world, it is maping all the components that you need in order for your own component to run. 
	 * Usuly placed at the root of your package.
	 */
	public class Registrator extends AbstractRegistrator
	{
		internal function initRegistrators():void{
			initRegistratorsHandler();
		}
		
		internal function initClasses():void{
			initClassesHandler();
		}
		
		internal function initSignals():void{
			initSignalsHandler();
		}
		
		/**
		 * Signals are SingelTone, it allows you to make maping even befor the class or the signal is created.  
		 * @param signalClass The signal class to map
		 * @param handlerClass The class that will listen to the signal
		 * 
		 */		
		protected function registerSignal(signalClass:Class, handlerClass:Class):void{
			var hadnler:Object = Factory.instance.inject(handlerClass);
			var signal:Signal = Factory.instance.inject(signalClass);
			signal.addListener(hadnler);
		}
		
		/**
		 * Point of registretion for class injection. If class was not registred it will be created at the first time it is injected.
		 * Lets asume you want to override your class A that you created few month ago, and you do not want to manipulate the code. Simply registerClass B that is 
		 * extending class A, and in all the places where A been injected, B will be injected instead. This method replace all the class tree, so if in the future
		 * you will registerClass C that extends class B, for all the injections of the classes B and A class C will be returned. 
		 *  
		 * @param claz The top leafe of the class family to register
		 * 
		 */		
		protected function registerClass(claz:Class):void{
			Factory.instance.registerClass(claz);
		}
		
		/**
		 * Adding the registrator to the main registration process. Note that order is very important. Add the registrators that you wish to override first. 
		 * @param registrator
		 * 
		 */		
		protected function addRegistrator(registrator:Registrator):void{
			PrimeRegistrator.instace.addRegistrator(registrator);
		}
	}
}