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
	

	public class ListLayoutData
	{
		/**
		 * Default value
		 */
		public static const NONE:int = -1;
		
		// [Bottom Left]_________[Bottom Right]
		// ____________________________________
		// _____________        _______________
		// _____________ Center _______________
		// ____________________________________
		// [Top Left]_______________[Top Right]
		
		private var _width:Number = NONE;
		private var _height:Number = NONE;
		
		/**
		 * typicalItem is used to calculate cellWidth and cellHeight if those are not set
		 */
		public var typicalItem:ItemRenderer;
		
		private var _cellWidth:Number = NONE;
		private var _cellHeight:Number = NONE;
		
		private var _columnsCount:int = NONE;
		private var _rowsCount:int = NONE;
		
		internal var updateDefaults:Boolean = false;
		internal var defaultWidth:Number = NONE;
		internal var defaultHeight:Number = NONE;
		internal var defaultColumnsCount:int = NONE;
		
		/**
		 * The size of the buffer
		 */
		public var bufferSize:int = 1;
		
		public var horizontalGap:Number = 5;
		public var verticalGap:Number = 5;
		
		/**
		 * The amount of display rows, if not set will be calculate by height / cellHeight
		 */
		public function get rowsCount():int
		{
			if(_rowsCount != NONE){
				return _rowsCount;
			}
			if(_height != NONE){
				return (_height / cellHeight);
			}
			if(!updateDefaults && defaultHeight != NONE){
				return (defaultHeight / cellHeight);
			}
			return NONE;
		}

		public function set rowsCount(value:int):void
		{
			_rowsCount = value;
		}

		/**
		 * The amount of display columnsCount, if not set will be calculate by width / cellWidth
		 */
		public function get columnsCount():int
		{
			if(_columnsCount != NONE){
				return _columnsCount;
			}
			if(_width != NONE){
				return (_width / cellWidth);
			}
			if(!updateDefaults && defaultWidth != NONE){
				return (defaultWidth / cellWidth);
			}
			if(!updateDefaults && defaultColumnsCount != NONE){
				return defaultColumnsCount;
			}
			return NONE; 
		}

		public function set columnsCount(value:int):void
		{
			_columnsCount = value;
		}

		/**
		 * The height of each cell
		 */
		public function get cellHeight():Number
		{
			if(_cellHeight != NONE){
				return _cellHeight + verticalGap;
			}
			if(typicalItem){
				return typicalItem.height + verticalGap;
			}
			return NONE;
		}

		public function set cellHeight(value:Number):void
		{
			_cellHeight = value;
		}

		/**
		 * The width of each cell
		 */
		public function get cellWidth():Number
		{
			if(_cellHeight != NONE){
				return _cellWidth + horizontalGap;
			}
			if(typicalItem){
				return typicalItem.width + horizontalGap;
			}
			return NONE;
		}

		public function set cellWidth(value:Number):void
		{
			_cellWidth = value;
		}

		/**
		 * Set fixed height
		 */
		public function get height():Number
		{
			if(_height != NONE){
				return _height;
			}
			
			if(rowsCount != NONE){
				return rowsCount * cellHeight;
			}
			
			if(!updateDefaults &&defaultHeight != NONE){
				return defaultHeight;
			}
			
			throw new Error("Height is not set");
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		/**
		 * Set fixed width
		 */
		public function get width():Number
		{
			if(_width != NONE){
				return _width;
			}
			
			if(columnsCount != NONE){
				return columnsCount * cellWidth;
			}
			
			if(!updateDefaults &&defaultWidth != NONE){
				return defaultWidth;
			}
			
			throw new Error("Width is not set");
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		/**
		 * Shortcut to set both horizontal and vertical gapes
		 */
		public function set gap(value:Number):void{
			horizontalGap = value;
			verticalGap = value;
		}
	}
}