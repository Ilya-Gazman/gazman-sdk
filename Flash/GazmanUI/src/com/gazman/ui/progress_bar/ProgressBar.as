package com.gazman.ui.progress_bar 
{
	import com.gazman.life_cycle.inject;
	import com.gazman.life_cycle.injectWithParams;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.ContainerLayout;
	import flash.text.TextFieldAutoSize;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	/**
	 * ...
	 * @author Ilya Gazman
	 */
	public class ProgressBar extends Group 
	{
		public var juggler:Juggler = Starling.juggler;
		static private const DEFAULT_WIDTH:Number = 30;
		static private const DEFAULT_HEIGHT:Number = 10;
		private var background:Quad = injectWithParams(Quad, [DEFAULT_WIDTH, DEFAULT_HEIGHT, 0]);
		private var fillArea:Quad = injectWithParams(Quad, [1, DEFAULT_HEIGHT, 0x00FF00]);
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var _padding:Number = 2;
		private var tween:Tween = new Tween(this, 1);
		private var _progress:Progress = new Progress();
		
		override protected function initilize():void 
		{
			addChild(background);
			addChild(fillArea);
			layout();
		}
		
		private function layout():void 
		{
			initContainer();
		}
		
		public function resize(width:Number, height:Number):void {
			background.width = width;
			background.height = height;
			fillArea.height = height;
			updateProgress();
		}
		
		public function get backgroundColor():uint 
		{
			return background.color;
		}
		
		public function set backgroundColor(value:uint):void 
		{
			background.color = value;
		}
		
		public function get fillColor():uint 
		{
			return fillArea.color;
		}
		
		public function set fillColor(value:uint):void 
		{
			fillArea.color = value;
		}
		
		private function updateProgress():void{
			containerLayout.right = background.width * (1 - _progress.progress) + padding;
			containerLayout.applyLayoutOn(fillArea, background);
		}
		
		private function initContainer():void{
			containerLayout.left = padding;
			containerLayout.top = padding;
			containerLayout.bottom = padding;
		}
		
		public function setProgress(value:Number, animate:Boolean = true):void{
			juggler.remove(tween);
			if(!animate){
				_progress.progress = value;
				updateProgress();				
			}
			else{
				tween.reset(_progress, 1);
				tween.animate("progress", value);
				tween.onUpdate = updateProgress;
				juggler.add(tween);
			}
		}	
		
		public function get progress():Number{
			return _progress.progress;
		}
		
		public function get padding():Number 
		{
			return _padding;
		}
		
		public function set padding(value:Number):void 
		{
			_padding = value;
		}
	}
}
class Progress {
	public var progress:Number = 1;
	
	public function Progress() 
	{
		super();
	}
}