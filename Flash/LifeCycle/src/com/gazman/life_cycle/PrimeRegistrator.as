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

	internal class PrimeRegistrator
	{
		public static const instace:PrimeRegistrator = new PrimeRegistrator();
		private var list:Vector.<Registrator> = new Vector.<Registrator>();
		
		public function excecute():void{
			var registrator:Registrator;
			var i:int;
			for(i = 0; i < list.length; i++){
				registrator = list[i];
				registrator.initClasses();
			}
			
			for(i = 0; i < list.length; i++){
				registrator = list[i];
				registrator.initSignals();
			}
		}
		
		public function addRegistrator(registrator:Registrator):void{
			list.push(registrator);
			registrator.initRegistrators();
		}
	}
}