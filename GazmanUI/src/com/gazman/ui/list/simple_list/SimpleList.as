// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.list.simple_list
{
	import com.gazman.ui.list.List;
	
	/**
	 * List of buttons
	 */
	public class SimpleList extends List
	{
		override protected function initilize():void
		{
			layout.columnsCount = 1;
			layout.typicalItem = new SimpleItemRenderer();
			structure.itemRenderer = SimpleItemRenderer;
			super.initilize();
		}
		
		
	}
}