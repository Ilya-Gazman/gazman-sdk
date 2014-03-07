// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.layout.view
{
	import com.gazman.ui.group.Group;
	
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class Box extends Group
	{
		private var latter:String;
		private var color:uint;
		
		private var backgroud:Quad;
		private var textField:TextField;

		private var size:Number;
		
		public function Box(latter:String, color:uint, size:Number)
		{
			super();
			this.size = size;
			this.color = color;
			this.latter = latter;
		}
		
		override protected function initilize():void
		{
			backgroud = new Quad(size,size,color);
			addChild(backgroud);
			textField = new TextField(size, size, latter);
			textField.color = Color.WHITE;
			textField.fontSize = size / 5;
			addChild(textField);
		}
	}
}