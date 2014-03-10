// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.text
{
	import com.gazman.ui.expandable_group.StrictGroup;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.text.text_change.TextChangedSignal;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	/**
	 * Allow user to write text. It wrapping starling TextField component
	 * 
	 * <p>Currently only suporting english text</p>
	 */
	public class TextInput extends StrictGroup
	{
		private var flashTextField:flash.text.TextField = new flash.text.TextField();
		private var background:Quad;
		private var frame:Quad;
		private var _textField:starling.text.TextField;
		private var _frameWidth:Number = 1;
		private var frameExtraSizeWhenFocused:Number = 0;
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var _focused:Boolean = false;
		private var _text:String = "";
		
		/**
		 * Fires when text is changed by user or by code.
		 */
		public const textChangedSignal:TextChangedSignal = new TextChangedSignal();
		
		/**
		 * Maximum alloud characters
		 */
		public var maxChars:int = 0;
		
		public function TextInput(){
			flashTextField.needsSoftKeyboard = true;
		}
		
		protected function requestSoftKeyboard():void{
			flashTextField.requestSoftKeyboard();
		}
		
		override protected function addChildrenHandler():void
		{
			addEventListener(TouchEvent.TOUCH, onTextBoxTouch);
			startlingStage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			flashStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			initFrame();
			initBackground();
			initTextField();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(focused){
				switch(event.keyCode){
					case Keyboard.BACKSPACE:
						text = text.substr(0, text.length - 1);
						break;
					default:
						if(event.charCode >= 32 && event.charCode <= 126){
							var char:String = String.fromCharCode(event.charCode);
							text += char;
						}
						break;
				}
			}
		}
		
		private function isBetween(charCode:uint, a:String, b:String):Boolean{
			return charCode >= a.charCodeAt(0) && charCode <= b.charCodeAt(0);
		}
		
		private function get startlingStage():starling.display.Stage{
			return Starling.current.stage;
		}
		
		private function get flashStage():flash.display.Stage{
			return Starling.current.nativeStage;
		}
		
		private function initFrame():void
		{
			frame = new Quad(1, 1, Color.GRAY);
			addChild(frame);
		}
		
		private function initBackground():void
		{
			background = new Quad(1, 1, Color.WHITE);
			addChild(background);
		}
		
		private function initTextField():void
		{
			_textField = new starling.text.TextField(200, 32, "");
			textField.hAlign = HAlign.LEFT;
			addChild(textField);
		}
		
		private function onStageTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				return;
			}
			touch = event.getTouch(startlingStage);
			if(touch){
				switch(touch.phase){
					case TouchPhase.BEGAN:
						focused = false;
						break;
				}
			}
		}
		
		private function onTextBoxTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);;
			if(touch){
				switch(touch.phase){
					case TouchPhase.BEGAN:
						focused = true;
						break;
					case TouchPhase.ENDED:
						break;
				}
			}
		}
		
		public function validate():void{
			initLayout();
		}
		
		override protected function initLayout():void
		{
			if(_focused){
				frame.alpha = 1;
				requestSoftKeyboard();
			}
			else{
				frame.alpha = 0.4;
			}
			frame.width = textField.width + frameSize * 2;
			frame.height = textField.height + frameSize * 2;
			
			containerLayout.bottom = frameSize;
			containerLayout.top = frameSize;
			containerLayout.right = frameSize;
			containerLayout.left = frameSize;
			containerLayout.applyLayoutOn(background, frame);
			containerLayout.applyLayoutOn(textField, frame);
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}

		private function get focused():Boolean
		{
			return _focused;
		}

		private function set focused(value:Boolean):void
		{
			if(_focused == value){
				return;
			}
			_focused = value;
			if(_focused){
				startBlinking();
			}
			else{
				stopBlinking();
			}
			initLayout();
		}
		
		private function stopBlinking():void
		{
			startlingStage.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			blinkOn = false;
			text = _text;
		}
		
		private function onEnterFrame(event:Event, time:Number):void
		{
			var timePass:Number = getTimer();
			blinkOn = Math.round(timePass / 500) % 2 == 0;
			text = _text;
		}
		
		private var blinkOn:Boolean = false
		
		private function startBlinking():void
		{
			startlingStage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if(maxChars > 0 && value.length > maxChars){
				value = value.substr(0, maxChars);
			}
			if(_text != value){
				_text = value;
				updateText(value);
				textChangedSignal.textChangedHandler(value);
			}
			else{
				updateText(value);
			}
		}
		
		private function updateText(value:String):void
		{
			if(blinkOn){
				if(textField.hAlign == HAlign.CENTER){
					textField.text = " " + _text + "|";	
				}
				else{
					textField.text = _text + "|";
				}
			}
			else{
				textField.text = _text;
			}
		}
		
		private function get frameSize():Number
		{
			if(!focused){
				return _frameWidth;
			}
			else{
				return _frameWidth + frameExtraSizeWhenFocused;
			}
		}

		private function set frameSize(value:Number):void
		{
			_frameWidth = value;
		}

		/**
		 * Return referance to underling texfield object
		 */
		public function get textField():starling.text.TextField
		{
			return _textField;
		}
		
		
	}
}