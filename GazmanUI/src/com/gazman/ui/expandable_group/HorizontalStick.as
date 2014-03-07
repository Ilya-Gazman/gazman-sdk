// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.expandable_group
{
	
	internal class HorizontalStick extends Box
	{
		public function HorizontalStick(container:ExpandableGroup)
		{
			super(container);
			color = 654321;
		}
		
		override protected function onDrag(deltaX:Number, deltaY:Number):void
		{
			x += deltaX;
			container.updateSizeAndPositionsBySticks();
		}
	}
}