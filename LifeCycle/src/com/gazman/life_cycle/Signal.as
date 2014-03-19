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
	import com.gazman.life_cycle.utils.reflection.Method;
	import com.gazman.life_cycle.utils.reflection.Reflection;
	
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	

	/**
	 * Signals are used to communitacte between classes. Siganl must implement exctly one interface and call Signal.dispatch(arguments) on it's excecution.
	 */
	public class Signal implements ISingleTon
	{
		private var listeners:Array = new Array();
		private var methodeName:String;
		
		public function Signal(){
			var interfaces:Vector.<Class> = new Reflection(getDefinitionByName(getQualifiedClassName(this)) as Class).getInterfaces();
			if(interfaces.length != 2){
				throw new Error("Signal must have exactly two interface");
			}
			var signalInterface:Class = interfaces[1];
			
			var methods:Vector.<Method> = new Reflection(getDefinitionByName(getQualifiedClassName(signalInterface)) as Class).getPublicMethodes();
			if(methods.length != 1){
				throw new Error("Signal interface must have exactly one methode");
			}
			methodeName = methods[0].name;
		}
		
		/**
		 * Add listener object 
		 * @param listener Must implement the same Interface as the Signal or error will acure
		 */		
		public function addListener(listener:Object):void{
			listeners.push(listener);
		}
		
		/**
		 * Run over all the listeners to find and remove the listener object 
		 * @param listener
		 * 
		 */		
		public function removeListener(listener:Object):void{
			for(var i:int = 0; i < listeners.length; i++){
				if(listeners[i] == listener){
					listeners.splice(i, 1);
					break;
				}
			}
		}
		
		/**
		 * Should be called from the intarface methode. Will call all the listeners.
		 * @param _arguments arguments are used so when the signature of the method is changed, you will not have to modefy code.
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/arguments.html
		 * 
		 */		
		protected function dispatch(_arguments:Array):void{
			for each(var listener:Object in listeners){
				(listener[methodeName] as Function).apply(listener, _arguments);
			}
		}
		
		[Private]
		public function injectionHandler():void
		{
		}
		
	}
}