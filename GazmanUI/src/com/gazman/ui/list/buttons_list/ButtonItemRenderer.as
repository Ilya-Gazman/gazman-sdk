// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.list.buttons_list
{
	import com.gazman.ui.list.ItemRenderer;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class ButtonItemRenderer extends ItemRenderer
	{
		private var button:Button;
		public function ButtonItemRenderer(){
			var roundRectangle:Texture = ShapeTextur.roundRectangle("Menu Item", 160, 40, 5, Color.GRAY);
			button = new Button(roundRectangle);
			button.fontColor = Color.WHITE;
			button.addEventListener(Event.TRIGGERED, onButtonTrigger);
			addChild(button);
		}
		
		private function onButtonTrigger():void
		{
			if(data is ButtonData){
				if(data && data.callBack){
					data.callBack();
				}	
			}
			
		}
		
		override public function updateData(data:Object):void
		{
			super.updateData(data);
			if(data){
				button.text = data.toString();
			}
		}
		
		
	}
}