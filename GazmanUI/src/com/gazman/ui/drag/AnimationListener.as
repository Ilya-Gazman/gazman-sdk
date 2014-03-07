// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.drag
{
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;

	internal class AnimationListener
	{
		private var _deltaY:Number;
		private var _deltaX:Number;
		private var tween:Tween;
		
		private var target:IDragable;
		public var duration:Number = 1.5;
		
		private var _jugler:Juggler;
		
		public function AnimationListener(target:IDragable){
			this.target = target;
		}
		
		public function start(deltaX:Number, deltaY:Number):void{
			_deltaX = deltaX;
			_deltaY = deltaY;
			
			stop();
			tween = new Tween(this, duration, Transitions.EASE_OUT);
			tween.repeatCount = 1;
			tween.animate("deltaX", 0);
			tween.animate("deltaY", 0);
			jugler.add(tween);
		}
		
		public function get jugler():Juggler
		{
			if(_jugler){
				return _jugler;
			}
			else{
				return Starling.juggler;
			}
		}
		
		public function set jugler(value:Juggler):void
		{
			_jugler = value;
		}
		
		public function stop():void{
			if(tween){
				jugler.remove(tween);
			}
		}
		
		public function get deltaY():Number
		{
			return _deltaY;
		}
		
		public function set deltaY(value:Number):void
		{
			_deltaY = value;
			value = Math.round(value);
			if(value){
				target.updateViewPort(0, value);
			}
		}
		
		public function get deltaX():Number
		{
			return _deltaX;
		}
		
		public function set deltaX(value:Number):void
		{
			_deltaX = value;
			value = Math.round(value);
			if(value){
				target.updateViewPort(value, 0);
			}
		}
	}
}