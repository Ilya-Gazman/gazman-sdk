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
			resetHandler();
		}
		
		/**
		 * Do not call manually. System call this method when data changed or invalidated 
		 */
		public final function updateData(data:Object):void{
			if(data != null){
				if(data != this.data){
					this.data = data;
					visible = true;
					touchable = true;
					dataChangeHandler(data);
				}
			}
			else{
				resetHandler();
				this.data = null;
			}
		}
		
		/**
		 * Called from constractor and when data changed to null. <br>The data will be changed to null only after this method finish excecuting.
		 */
		protected function resetHandler():void
		{
			visible = false;
			touchable = false;
		}
		
		/**
		 * Called when data changed to non null value
		 */
		protected function dataChangeHandler(data:Object):void
		{
			
		}
		
		/**
		 * The index of the cell in the list
		 */
		public final function get index():int{
			return _index;
		}
	}
}