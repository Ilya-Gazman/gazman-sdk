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
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	internal class ListViewPort extends Sprite
	{
		//Bottom-Left***********Bottom-Right
		//************        **************
		//************ Middle **************
		//************        **************
		//Top-Left*****************Top-Right
		
		// cells[y][x]
		
		public var nextIndex:int = -1;
		public var cells:Array;
		
		private var startingIndex:int = -1;
		private var isIteratingOverColumns:Boolean = false;
		private var isDraging:Boolean = false;
		
		public var layout:ListLayoutData;
		public var structure:ListStructureData;
		
		private var cellsCollection:Array = new Array();
		
		public function initilize():void{
			cells = new Array();
			var cellsCollection:Array = new Array();
			removeChildren();
			var i:int;
			var cell:ItemRenderer;
			for(i = 0; i < layout.rowsCount + layout.bufferSize; i++){
				for(var j:int = 0; j < layout.columnsCount + layout.bufferSize; j++){
					var array:Array = cells[i];
					if(!array){
						array = new Array();
						cells[i] = array;
					}
					
					if(this.cellsCollection.length > 0){
						cell = this.cellsCollection.pop();
						cell.updateData(null);
					}
					else{
						cell = structure.itemRendererFactory();
					}
					cell.x = j * layout.cellWidth;
					cell.y = i * layout.cellHeight;
					addChild(cell);
					array.push(cell);
					cellsCollection.push(cell);
				}
			}
			for(i = 0; i < this.cellsCollection.length; i++){
				cell = this.cellsCollection[i];
				cellsCollection.push(cell);
			}
			this.cellsCollection = cellsCollection;
		}
		
		public function iterateOverColumn(index:int):void{
			startingIndex = index;
			nextIndex = -1;
			isIteratingOverColumns = true;
		}
		
		public function iterateOverRow(index:int):void{
			startingIndex = index;
			nextIndex = -1;
			isIteratingOverColumns = false;
		}
		
		public function next():ItemRenderer{
			if(startingIndex == -1){
				throw new Error("Must call iterateOverColumns() or iterateOverRows() before using next()");
			}
			nextIndex++;
			if(!isIteratingOverColumns){
				if(!cells[startingIndex] || nextIndex == cells[startingIndex].length){
					finishIteration();
					return null;
				}
				return cells[startingIndex][nextIndex];				
			}
			else{
				if(nextIndex == cells.length){
					finishIteration();
					return null;
				}
				return cells[nextIndex][startingIndex];
			}
		}
		
		private function finishIteration():void
		{
			startingIndex = -1;
			nextIndex = -1;
		}
		
		public function bottomLeftCell():DisplayObject
		{
			return cells[0][0];
		}
		
		public function bottomRightCell():DisplayObject
		{
			return cells[0][cells[0].length - 1];
		}
		
		public function topLeftCell():DisplayObject
		{
			return cells[cells.length - 1][0];
		}
		
		public function moveColumnRightToLeft():void
		{
			for(var i:int = 0; i < cells.length; i++){
				var leftCell:DisplayObject = cells[i][0];
				var rightCell:DisplayObject = cells[i][cells[i].length - 1];
				rightCell.x = leftCell.x - rightCell.width - layout.horizontalGap;
				
				for(var j:int = cells[i].length - 1; j > 0; j--){
					cells[i][j] = cells[i][j - 1];
				}
				cells[i][0] = rightCell;
			}
		}
		
		public function moveColumnLeftToRight():void
		{
			for(var i:int = 0; i < cells.length; i++){
				var leftCell:DisplayObject = cells[i][0];
				var rightCell:DisplayObject = cells[i][cells[i].length - 1];
				leftCell.x = rightCell.x + rightCell.width + layout.horizontalGap;
				
				for(var j:int = 0; j < cells[i].length - 1; j++){
					cells[i][j] = cells[i][j + 1];
				}
				cells[i][cells[i].length - 1] = leftCell;
			}
		}
		
		public function moveRowBottomToTop():void
		{
			for(var i:int = 0; i < cells[0].length; i++){
				var bottomCell:DisplayObject = cells[0][i];
				var topCell:DisplayObject = cells[cells.length - 1][i];
				bottomCell.y = topCell.y + topCell.height + layout.verticalGap;
				
				for(var j:int = 0; j < cells.length - 1; j++){
					cells[j][i] = cells[j + 1][i];
				}
				cells[cells.length - 1][i] = bottomCell;
			}
		}
		
		public function moveRowTopToBottom():void
		{
			for(var i:int = 0; i < cells[0].length; i++){
				var bottomCell:DisplayObject = cells[0][i];
				var topCell:DisplayObject = cells[cells.length - 1][i];
				topCell.y = bottomCell.y - bottomCell.height - layout.verticalGap;
				
				for(var j:int = cells.length - 2; j >= 0; j--){
					cells[j + 1][i] = cells[j][i];
				}
				cells[0][i] = topCell;
			}
		}
		
//		private function printCells():void{
//			for(var k:int = 0; k < 2; k++){
//				trace("**********************************************************");
//			}
//			
//			for(var i:int = 0; i < cells.length; i++){
//				var cellsData:String = "";
//				for(var j:int = 0; j < cells[i].length; j++){
//					cellsData += cells[i][j] + "\t";
//				}
//				trace(cellsData);
//			}
//		}
	}
}