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
	public class AbstractRegistrator
	{
		public function AbstractRegistrator() 
		{
			super();
		}
		
		/**
		 * This is the place for addRegistrator calls
		 */
		protected function initRegistratorsHandler():void{}
		
		/**
		 * This is the place for registerClass calls
		 */
		protected function initClassesHandler():void{}
		
		/**
		 * This is the place for registerSignal calls
		 */
		protected function initSignalsHandler():void{}
	}
}