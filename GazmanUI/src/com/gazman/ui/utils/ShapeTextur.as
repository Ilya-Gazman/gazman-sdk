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
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.textures.Texture;
	import starling.utils.Color;

	/**
	 * A helper class to create textures from shapes. 
	 * It's recomand to avoid creating textures in from shapes, so this class may be deprecated in the future. 
	 */
	public class ShapeTextur
	{
		private static var textures:Object = new Object();
		
		public static function roundRectangle(id:String, width:Number = 80, height:Number = 20, radius:Number = 5, color:int = Color.GRAY):Texture{
			
			id = id + width + "|" + height + "|" + radius + "|" + color;
			
			if(textures[id]){
				return textures[id];
			}
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawRoundRectComplex(0, 0, width, height, radius, radius, radius, radius);
			shape.graphics.endFill();
			
			var bmpData:BitmapData = new BitmapData(width, height, true, color);
			bmpData.draw(shape);
			
			var texture:Texture = Texture.fromBitmapData(bmpData);
			textures[id] = texture;
			
			return texture;
		}
		
		public static function circle(id:String, radius:Number = 30, color:int = 0x0):Texture{
			
			id = id + radius + "|" + color;
			
			if(textures[id]){
				return textures[id];
			}
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(radius, radius, radius);
			shape.graphics.endFill();
			
			var bmpData:BitmapData = new BitmapData(shape.width, shape.height, true, color);
			bmpData.draw(shape);
			
			var texture:Texture = Texture.fromBitmapData(bmpData);
			textures[id] = texture;
			
			return texture;
		}
	}
}