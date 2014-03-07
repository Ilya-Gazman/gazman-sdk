// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.panel
{
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	
	import starling.display.Quad;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	/**
	 * One of the lego UI elements, makes any UI looks better.
	 */
	public class Panel extends Group
	{
		private var frameSize:Number = 1;
		private var frame:Quad;
		private var background:Quad;
		private var titleBackground:Quad;
		private var _titleTextField:TextField;
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var align:AlignLayout = new AlignLayout();
		private var margin:Number = 0;
		public const container:Group = new Group();
		
		private const TEXT_HEIGHT:Number = 32;
		private var _tile:String = "";
		
		override protected function initilize():void
		{
			frame = new Quad(1,1, Color.GRAY);
			background = new Quad(1,1,Color.WHITE);
			titleBackground = new Quad(1,1,Color.GRAY);
			
			_titleTextField = new TextField(300, TEXT_HEIGHT, _tile);
			_titleTextField.bold = true;
			
			addChild(frame);
			addChild(background);
			addChild(titleBackground);
			addChild(_titleTextField);
			addChild(container);
			frame.filter = BlurFilter.createDropShadow();
			titleBackground.alpha = 0.5;
			
			titleTextField.hAlign = HAlign.LEFT;
			
			resize(300, 400);
		}
		
		/**
		 * The underling TextField component used to create the title
		 * 
		 */		
		public function get titleTextField():TextField
		{
			return _titleTextField;
		}
		
		public function set title(value:String):void{
			_tile = value;
			if(titleTextField){
				titleTextField.text = value;
			}
		}
		
		/**
		 * Title text
		 */
		public function get title():String{
			return _tile;
		}
		
		/**
		 * Resize the panel to wrape its content 
		 * @param margin 
		 * 
		 */		
		public function resizeByContainer(margin:Number = 0):void{
			this.margin = margin;
			var marginAndFrame:Number = (margin + frameSize) * 2;
			resize(container.width + marginAndFrame, container.height + marginAndFrame + TEXT_HEIGHT);
		}
		
		/**
		 * Resize without scalling the content
		 */
		public function resize(width:Number, height:Number):void{
			frame.width = width;
			frame.height = height;
			
			containerLayout.clear();
			containerLayout.right = frameSize + 5;
			containerLayout.left = frameSize;
			containerLayout.applyLayoutOn(titleTextField, frame);
			
			containerLayout.right = frameSize;
			containerLayout.top = frameSize;
			containerLayout.bottom = frameSize;
			containerLayout.applyLayoutOn(background, frame);
			
			containerLayout.applyLayoutOn(titleBackground, frame);
			titleBackground.height = TEXT_HEIGHT;
			
			align.clear();
			containerLayout.clear();
			align.below = margin + frameSize * 2;
			containerLayout.left = margin + frameSize * 2;
			align.applyLayoutOn(container, titleBackground);
			containerLayout.applyLayoutOn(container, titleBackground);
		}
	}
}