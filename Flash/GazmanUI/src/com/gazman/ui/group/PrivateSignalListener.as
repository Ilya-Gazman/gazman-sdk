// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.group
{
	internal class PrivateSignalListener implements IInitilizeCompleteSignal
	{
		private var referance:Group;
		public function PrivateSignalListener(referance:Group){
			this.referance = referance;
		}
		
		public function initilizeCompleteHandler():void
		{
			referance.initilizeCompleteHandler();
		}
	}
}