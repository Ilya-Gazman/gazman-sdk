// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.list.view.balls
{
	import com.gazman.ui.list.ItemRenderer;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class BallRenderer extends ItemRenderer
	{
		private var textField:TextField;
		private var ball:Image;
		
		private static var idCounter:int = 1;
		public const id:int = idCounter++;
		public function toString():String{
			return id.toString() + "," + textField.text;
		}
		
		public function BallRenderer()
		{
			var circle:Texture = ShapeTextur.circle("ball", 30, Color.BLUE);
			textField = new TextField(circle.width, circle.height, "");
			textField.color = Color.WHITE;
			ball = new Image(circle);
			addChild(ball);
			addChild(textField);
		}
		
		override public function updateData(data:Object):void
		{
			super.updateData(data);
			if(data != null){
				textField.text = data.toString();
			}
		}
	}
}