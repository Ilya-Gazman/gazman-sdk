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
	/**
	 * List model
	 */
	public class ListStructureData
	{
		/**
		 * the ItemRenderer class to render each cell of the list
		 */
		public var itemRenderer:Class = null;
		
		/**
		 * Data provider have only onde dimantion, in order to represent the list with 2 dimantions we need to know the numbers of the columns.
		 * <p>If not speciefied dataProvider.length / rowsCount will be used</p>
		 */
		public function get columnsCount():int
		{
			if(_columnsCount != ListLayoutData.NONE){
				return _columnsCount;
			}
			else{
				if(_rowsCount != ListLayoutData.NONE){
					return dataProvider.length / _rowsCount;
				}
			}
			return layoutColumnsCount;
		}

		public function set columnsCount(value:int):void
		{
			_columnsCount = value;
		}

		/**
		 * Data provider have only onde dimantion, in order to represent the list with 2 dimantions we need to know the numbers of the rows.
		 * <p>If not speciefied dataProvider.length / columnsCount will be used</p>
		 */
		public function get rowsCount():int
		{
			if(_rowsCount != ListLayoutData.NONE){
				return _rowsCount;
			}
			else{
				if(_columnsCount != ListLayoutData.NONE){
					return dataProvider.length / _columnsCount;
				}
			}
			return layoutRowsCount;
		}

		public function set rowsCount(value:int):void
		{
			_rowsCount = value;
		}

		/**
		 * <p>defualt is:</p>
			function createItemRenderer():ItemRenderer{
				return new itemRenderer();
			} 
		 */
		public var itemRendererFactory:Function = createItemRenderer;
		
		/**
		 * The data to initialize the cells
		 */
		public var dataProvider:Array = new Array();
		
		internal var layoutColumnsCount:int = ListLayoutData.NONE;
		internal var layoutRowsCount:int = ListLayoutData.NONE;
		
		private var _columnsCount:int = ListLayoutData.NONE;
		private var _rowsCount:int = ListLayoutData.NONE;
		
		private function createItemRenderer():ItemRenderer{
			if(itemRenderer == null){
				throw new Error("structure.itemRenderer is not set");
			}
			return new itemRenderer();
		}
	}
}