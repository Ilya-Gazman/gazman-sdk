// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * Listening to Staling or Flash addToStage event and call the init method.
	 * @param target starling or stage display object
	 * @param init callback to when the stage is available 
	 */	
	public function setInitListener(target:*, init:Function):void
	{
		if(target.stage){
			init();
		}
		else{
			if(target is starling.display.DisplayObject){
				var callback:Function = function():void{ 
					target.removeEventListener(starling.events.Event.ADDED_TO_STAGE, callback);
					init();
				};
				target.addEventListener(starling.events.Event.ADDED_TO_STAGE, callback); 
			}
			else if(target is flash.display.DisplayObject){
				var callback2:Function = function():void{ 
					target.removeEventListener(flash.events.Event.ADDED_TO_STAGE, callback);
					init();
				};
				target.addEventListener(flash.events.Event.ADDED_TO_STAGE, callback2); 
			}
		}
	}
}