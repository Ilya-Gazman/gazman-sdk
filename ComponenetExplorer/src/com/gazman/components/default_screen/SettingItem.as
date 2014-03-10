// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.default_screen
{
	import com.gazman.ui.expandable_group.StrictGroup;
	import com.gazman.ui.layouts.LinearLayout;
	import com.gazman.ui.text.TextInput;
	import com.gazman.ui.text.text_change.ITextChangedSignal;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	public class SettingItem extends StrictGroup implements ITextChangedSignal
	{
		private var lableText:TextField;
		private var textInput:TextInput = new TextInput();
		private var clearButton:Button;
		
		private var _value:Number;
		public var applyValue:Function;
		public var label:String = "";
		public var clearValue:Number;
		
		override protected function addChildrenHandler():void
		{
			initLabelText();
			initTextInput();
			initClearButton();
		}
		
		private function initTextInput():void
		{
			textInput.textChangedSignal.addListener(this);
			textInput.maxChars = 5;
			addChild(textInput);
		}
		
		private function initClearButton():void
		{
			var roundRectangle:Texture = ShapeTextur.roundRectangle("clearButton", 50, 30);
			clearButton = new Button(roundRectangle, "Clear");
			clearButton.addEventListener(Event.TRIGGERED, onTrigger);
			addChild(clearButton);
		}
		
		private function onTrigger():void
		{
			textInput.text = "";
		}
		
		private function initLabelText():void
		{
			lableText = new TextField(160, 32, label);
			lableText.hAlign = HAlign.LEFT;
			addChild(lableText);
		}
		
		override protected function initLayout():void
		{
			textInput.textField.width = 50;
//			textInput.textField.hAlign = HAlign.CENTER;
			textInput.validate();
			var linearLayout:LinearLayout = new LinearLayout(false);
			linearLayout.gap = 20;
			linearLayout.applyLayout(lableText, textInput, clearButton);
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
			if(!isNaN(value)){
				textInput.text = "" + value;
			}
			else{
				textInput.text = "";
			}
		}

		
		public function textChangedHandler(text:String):void
		{
			if(text){
				applyValue(Number(text));
			}
			else{
				applyValue(clearValue);
			}
		}
		
	}
}