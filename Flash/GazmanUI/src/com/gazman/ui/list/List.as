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
	import com.gazman.ui.drag.IDragable;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.utils.SpaceContainer;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	public class List extends Group implements IDragable
	{
		//Bottom-Left***********Bottom-Right
		//************        **************
		//************ Middle **************
		//************        **************
		//Top-Left*****************Top-Right
		
		public var layout:ListLayoutData = new ListLayoutData();
		public var structure:ListStructureData = new ListStructureData();
		
		private var viewPort:ListViewPort = new ListViewPort();
		private var cellLocal:Point = new Point();
		private var cellGlobal:Point = new Point();
		private var bottomLeftIndex:int = 0;
		private var background:SpaceContainer = new SpaceContainer();
		
		override protected function initilize():void
		{
			initLayoutDefaults();
			addChild(background);
			addChild(viewPort);
			viewPort.layout = layout;
			viewPort.structure = structure;
			invalidate();
			background.width = viewPort.width;
			background.height = viewPort.height;
		}
		
		private function validate():void
		{
			if(layout.columnsCount == ListLayoutData.NONE){
				throw new Error("List.layout.columnsCount wasn't set. You must set both column layout columnsCount and rowsCount");
			}
			if(layout.rowsCount == ListLayoutData.NONE){
				throw new Error("List.layout.rowsCount wasn't set. You must set both column layout columnsCount and rowsCount");
			}
			if(layout.cellWidth == ListLayoutData.NONE){
				throw new Error("List.layout.cellWidth wasn't set. You must set cellWidth and cellHeight or tipicalItem");
			}
			if(layout.cellHeight == ListLayoutData.NONE){
				throw new Error("List.layout.cellHeight wasn't set. You must set cellWidth and cellHeight or tipicalItem");
			}
			if(structure.columnsCount == ListLayoutData.NONE && structure.rowsCount == ListLayoutData.NONE){
				throw new Error("List.structure.columnCount and rowsCound wasn't set you must set atlist one of them");
			}
		}
		
		private function initLayoutDefaults():void
		{
			layout.updateDefaults = true;
			if(layout.columnsCount == ListLayoutData.NONE){
				if(layout.rowsCount == ListLayoutData.NONE){
					layout.defaultColumnsCount = 1;
					layout.updateDefaults = false;
					setDifaultVerticalLayout();
				}
				else{
					setDifaultHorizontalLayout();	
				}
			}
			else if(layout.rowsCount == ListLayoutData.NONE){
				layout.updateDefaults = false;
				setDifaultVerticalLayout();
			}
			layout.updateDefaults = false;
		}
		
		/**
		 * Recreate all views and perform full data update
		 */
		public function invalidate():void{
			validate();
			bottomLeftIndex = 0;
			initLayoutDefaults();
			structure.layoutRowsCount = layout.rowsCount;
			structure.layoutColumnsCount = layout.columnsCount;
			viewPort.x = 0;
			viewPort.y = 0;
			viewPort.initilize();
			invalidateData();
		}
		
		/**
		 * Perform full data update
		 */
		public function invalidateData():void
		{
			for(var i:int = 0; i < structure.rowsCount; i++){
				updateRowData(i);
			}
		}
		
		public function getItemIndexAtPosition(point:Point):int{
			var child:DisplayObject = viewPort.bottomLeftCell();
			pointBuffer1.x = child.x;
			pointBuffer1.y = child.y;
			viewPort.localToGlobal(pointBuffer1, pointBuffer2);
			
			
			var deltaX:int = point.x - pointBuffer2.x;
			var deltaY:int = point.y - pointBuffer2.y;
			
//			point.x -= pointBuffer2.x;
//			point.y -= pointBuffer2.y;
//			var index:int = point.x / layout.cellWidth;
//			index += int(point.y / layout.cellHeight) * structure.columnsCount;
			
			var yIndex:int = int(deltaY / layout.cellHeight);
			var xIndex:int = int(deltaX / layout.cellWidth);
			
			if(viewPort.cells[yIndex] == null){
				return -1;
			}
			var item:ItemRenderer = viewPort.cells[yIndex][xIndex];
			if(!item){
				return -1;
			}
			
			return item.index; 
		}
		
		/**
		 * Change the position of view port inside the list 
		 * @param deltaX incriss the x postion of view port by deltaX
		 * @param deltaY incriss the y postion of view port by deltaY
		 */		
		public function updateViewPort(deltaX:Number, deltaY:Number):void{
			deltaX = deltaX != 0 ? validateHorizontalDrag(deltaX) : 0;
			deltaY = deltaY != 0 ? validateVerticalDrag(deltaY) : 0;
			viewPort.x += deltaX;
			viewPort.y += deltaY;
			dragComplete(deltaX, deltaY);
		}
		
		/**
		 * Update sinfle cell, without updating the intire list
		 * @param index cell index in dataProvider
		 * @param data the data
		 */		
		public function update(index:int, data:Object):void{
			structure.dataProvider[index] = data;
			index -= bottomLeftIndex;
			
			var xIndex:int = int(index / structure.columnsCount);
			if(viewPort.cells[xIndex] != null){
				var item:ItemRenderer = viewPort.cells[xIndex][index % structure.columnsCount];
				if(item){
					item.updateData(data);
				}
			}
		}
		
		internal function gridChangedHandler():void
		{
			invalidate();
		}
		
		private function setDifaultHorizontalLayout():void
		{
			layout.defaultWidth = (structure.dataProvider.length / layout.rowsCount + layout.bufferSize) * layout.cellWidth;
		}
		
		private function setDifaultVerticalLayout():void
		{
			layout.defaultHeight = (structure.dataProvider.length / layout.columnsCount + layout.bufferSize) * layout.cellHeight;
		}
		
		private var clipRectBuffer:Rectangle = new Rectangle();
		private var pointBuffer1:Point = new Point();
		private var pointBuffer2:Point = new Point();
		
		private function invalidateClipRectangle():void
		{
			pointBuffer1.x = 0;
			pointBuffer1.y = 0;
			localToGlobal(pointBuffer1, pointBuffer2);
			clipRectBuffer.x = pointBuffer2.x;
			clipRectBuffer.y = pointBuffer2.y;
			
			pointBuffer1.x = layout.columnsCount * layout.cellWidth;
			pointBuffer1.y = layout.rowsCount * layout.cellHeight;
			localToGlobal(pointBuffer1, pointBuffer2);
			
			clipRectBuffer.width = pointBuffer2.x - clipRectBuffer.x;
			clipRectBuffer.height = pointBuffer2.y - clipRectBuffer.y;
		}
		
		public override function render(support:RenderSupport, parentAlpha:Number):void{
			invalidateClipRectangle();
			support.finishQuadBatch()
			Starling.context.setScissorRectangle(clipRectBuffer);
			super.render(support,alpha);
			support.finishQuadBatch()
			Starling.context.setScissorRectangle(null);
		}
		
		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle{
			if(!resultRect){
				resultRect = new Rectangle();
			}
			invalidateClipRectangle();
			
			pointBuffer1.x = 0;
			pointBuffer1.y = 0;
			localToGlobal(pointBuffer1, pointBuffer2);
			
			var minX:Number = pointBuffer2.x, maxX:Number = pointBuffer2.x + clipRectBuffer.width;
			var minY:Number = pointBuffer2.y, maxY:Number = pointBuffer2.y + clipRectBuffer.height;
			
//			minX = minX < resultRect.x ? minX : resultRect.x;
			maxX = maxX > resultRect.right ? maxX : resultRect.right;
//			minY = minY < resultRect.y ? minY : resultRect.y;
			maxY = maxY > resultRect.bottom ? maxY : resultRect.bottom;
			
			resultRect.setTo(minX, minY, maxX - minX, maxY - minY);
			
			return resultRect;
		}
		
		override public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject{
			localToGlobal(localPoint, pointBuffer1);
			if (clipRectBuffer != null && !clipRectBuffer.containsPoint(pointBuffer1))
				return null;
			else
				return super.hitTest(localPoint, forTouch);
		}
		
		private function validateVerticalDrag(deltaY:Number):Number{
			var maxValue:Number;
			deltaY = Math.min(height, Math.abs(deltaY)) * deltaY / Math.abs(deltaY);
			
			if (isDragBottom(deltaY)){
				updateCellGlobals(viewPort.topLeftCell());
				
				maxValue = clipRectBuffer.y + clipRectBuffer.height - cellGlobal.y - 
					((structure.rowsCount - (layout.rowsCount + layout.bufferSize) - int(bottomLeftIndex / structure.rowsCount) + 2) * layout.cellHeight);
				return Math.max(maxValue, deltaY);
			}
			if (isDragTop(deltaY)){
				updateCellGlobals(viewPort.bottomLeftCell());
				
				maxValue = clipRectBuffer.y + int(bottomLeftIndex / structure.columnsCount) * layout.cellHeight - cellGlobal.y;
				return Math.min(maxValue, deltaY);
			}
			
			return 0;
		}
		
		private function validateHorizontalDrag(deltaX:Number):Number{
			var maxValue:Number;
			
			if (isDragRight(deltaX)){
				updateCellGlobals(viewPort.bottomLeftCell());
				maxValue = clipRectBuffer.x - cellGlobal.x + bottomLeftIndex % structure.columnsCount * layout.cellWidth;
				return Math.min(maxValue, deltaX);
			}
			if (isDragLeft(deltaX)){
				updateCellGlobals(viewPort.bottomRightCell());
				maxValue = clipRectBuffer.x + clipRectBuffer.width - cellGlobal.x - ((structure.columnsCount - (layout.rowsCount + layout.bufferSize) - bottomLeftIndex % structure.columnsCount) * layout.cellWidth);
				return Math.max(maxValue, deltaX);
			}
			
			return 0;
		}
		
		private function dragComplete(deltaX:Number, deltaY:Number):void{
			var viewBeenManipulated:Boolean;
			do{
				viewBeenManipulated = false;
				if (isDragRight(deltaX)){
					updateCellGlobals(viewPort.bottomRightCell());
					if(cellGlobal.x > clipRectBuffer.x + clipRectBuffer.width){
						viewPort.moveColumnRightToLeft();
						bottomLeftIndex--;
						updateColumnData(0);
						viewBeenManipulated = true;
					}
				}
				else if(isDragLeft(deltaX)){
					updateCellGlobals(viewPort.bottomLeftCell());
					if(cellGlobal.x + layout.cellWidth < clipRectBuffer.x){
						viewPort.moveColumnLeftToRight();
						bottomLeftIndex++;
						updateColumnData(layout.columnsCount);
						viewBeenManipulated = true;
					}
				}
				if(isDragBottom(deltaY)){
					updateCellGlobals(viewPort.bottomLeftCell());
					if(cellGlobal.y + layout.cellHeight < clipRectBuffer.y){
						viewPort.moveRowBottomToTop();
						bottomLeftIndex += structure.columnsCount;
						updateRowData(layout.rowsCount);
						viewBeenManipulated = true;
					}
				}
				else if (isDragTop(deltaY)){
					updateCellGlobals(viewPort.topLeftCell());
					if(cellGlobal.y > clipRectBuffer.y + clipRectBuffer.height){
						viewPort.moveRowTopToBottom();
						bottomLeftIndex -= structure.columnsCount;
						updateRowData(0);
						viewBeenManipulated = true;
					}
				}
			}while(viewBeenManipulated);
		}
		
		private function updateCellGlobals(cell:DisplayObject):void
		{
			cellLocal.x = cell.x;
			cellLocal.y = cell.y;
			cell.parent.localToGlobal(cellLocal, cellGlobal);
		}
		
		private function isDragRight(deltaX:Number):Boolean
		{
			return deltaX > 0;
		}
		
		private function isDragLeft(deltaX:Number):Boolean
		{
			return deltaX < 0;
		}
		
		private function isDragTop(deltaY:Number):Boolean
		{
			return deltaY > 0;
		}
		
		private function isDragBottom(deltaY:Number):Boolean
		{
			return deltaY < 0;
		}
		
		private function updateColumnData(i:int):void
		{
			viewPort.iterateOverColumn(i);
			var cell:ItemRenderer = viewPort.next() as ItemRenderer;
			while(cell != null){
				var dataIndex:int = i + structure.columnsCount * viewPort.nextIndex + bottomLeftIndex;
				if(dataIndex >= structure.dataProvider.length){
					break;
				}
				updateCell(cell, dataIndex);
				cell = viewPort.next();
			}
		}
		
		private function updateRowData(i:int):void
		{
			viewPort.iterateOverRow(i);
			
			var cell:ItemRenderer = viewPort.next();
			while(cell != null){
				var dataIndex:int = i * structure.columnsCount + viewPort.nextIndex + bottomLeftIndex;
				if(dataIndex >= structure.dataProvider.length){
					break;
				}
				updateCell(cell, dataIndex);
				cell = viewPort.next();
			}
		}		
		
		private function updateCell(cell:ItemRenderer, dataIndex:int):void
		{
			if(dataIndex >= 0){
				cell.updateData(structure.dataProvider[dataIndex]);
			}
			else{
				cell.updateData(null);
			}
			cell._index = dataIndex;
		}
	}
}