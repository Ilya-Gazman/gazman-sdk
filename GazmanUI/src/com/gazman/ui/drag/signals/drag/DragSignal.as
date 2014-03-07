// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.drag.signals.drag
{
	import com.gazman.life_cycle.Signal;
	
	public class DragSignal extends Signal implements IDragSignal
	{
		public function dragHandler(deltaX:Number, deltaY:Number):void
		{
			dispatch(arguments);
		}
	}
}