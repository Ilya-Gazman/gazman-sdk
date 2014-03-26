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
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.RenderSupport;
	import starling.display.DisplayObject;
	import starling.utils.VertexData;
	
	/**
	 * Used when you need an empty object just to listen for touch events or take space.
	 * When created its width and hegiht is set to 1
	 */
	public class SpaceContainer extends DisplayObject
	{
		/** The raw vertex data of the quad. */
		protected var vertexData:VertexData;
		
		/** Helper objects. */
		private static var helperPoint:Point = new Point();
		private static var helperMatrix:Matrix = new Matrix();
		
		public function SpaceContainer()
		{
			vertexData = new VertexData(4, true);
//			vertexData.setPosition(0.0, 0.0, 0.0); default
			vertexData.setPosition(1, 1, 0.0);
			vertexData.setPosition(2, 0.0, 1);
			vertexData.setPosition(3, 1, 1);
//			vertexData.setUniformColor(Color.BLACK); default
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			
		}
		
		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
		{
			if (resultRect == null) {
				resultRect = new Rectangle();
			}
			
			if (targetSpace == this) // optimization
			{
				vertexData.getPosition(3, helperPoint);
				resultRect.setTo(0.0, 0.0, helperPoint.x, helperPoint.y);
			}
			else if (targetSpace == parent && rotation == 0.0) // optimization
			{
				var scaleX:Number = this.scaleX;
				var scaleY:Number = this.scaleY;
				vertexData.getPosition(3, helperPoint);
				resultRect.setTo(
					x - pivotX * scaleX,
					y - pivotY * scaleY,
					helperPoint.x * scaleX, 
					helperPoint.y * scaleY);
				if (scaleX < 0.0) { 
					resultRect.width  *= -1; resultRect.x -= resultRect.width;  
				}
				if (scaleY < 0.0) { 
					resultRect.height *= -1; resultRect.y -= resultRect.height; 
				}
			}
			else
			{
				getTransformationMatrix(targetSpace, helperMatrix);
				vertexData.getBounds(helperMatrix, 0.0, 4, resultRect);
			}
			
			return resultRect;
		}
		
		
	}
}