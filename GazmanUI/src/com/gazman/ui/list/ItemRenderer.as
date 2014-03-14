// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.list
{
	import starling.display.Sprite;
	
	/**
	 * The base view for List cells
	 */
	public class ItemRenderer extends Sprite
	{
		internal var _index:int;

		protected var data:Object;
		
		
		public function ItemRenderer(){
			visible = false;
		}
		
		/**
		 * This method is fired when list data is invalidated or updated 
		 */
		public function updateData(data:Object):void{
			this.data = data;
			visible = data != null;
			touchable = data != null;
		}
		
		/**
		 * The index of the cell in the list
		 */
		public final function get index():int{
			return _index;
		}
	}
}