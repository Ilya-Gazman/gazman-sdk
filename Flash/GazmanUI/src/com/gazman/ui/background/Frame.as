// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.background
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.strict.StrictGroup;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.utils.SpaceContainer;
	
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class Frame extends StrictGroup
	{
		private var _thikness:Number = 0;
		private var _color:int = Color.BLACK;
		
		private var topQuad:Quad = new Quad(10,10,_color);
		private var bottomQuad:Quad = new Quad(10,10,_color);
		private var leftQuad:Quad = new Quad(10,10,_color);
		private var rightQuad:Quad = new Quad(10,10,_color);
		private var spaceContainer:SpaceContainer = inject(SpaceContainer);
		
		override protected function addChildrenHandler():void
		{
			addChild(spaceContainer);
			addChild(topQuad);
			addChild(bottomQuad);
			addChild(leftQuad);
			addChild(rightQuad);
		}
		
		override protected function initLayout():void
		{
			if(!stage){
				return;
			}
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.left = 0;
			containerLayout.right = 0;
			containerLayout.top = 0;
			containerLayout.applyLayoutOn(topQuad, parent);
			containerLayout.top = Layout.CLEAR_VALUE;
			containerLayout.bottom = 0;
			containerLayout.applyLayoutOn(bottomQuad, parent);
			
			containerLayout.clear();
			containerLayout.bottom = 0;
			containerLayout.top = 0;
			containerLayout.left = 0;
			containerLayout.applyLayoutOn(leftQuad, parent);
			containerLayout.left = Layout.CLEAR_VALUE;
			containerLayout.right = 0;
			containerLayout.applyLayoutOn(rightQuad, parent);
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}
		
		public function set thikness(value:Number):void
		{
			if(_thikness == value){
				return;
			}
			
			leftQuad.width = value;
			rightQuad.width = value;
			bottomQuad.height = value;
			topQuad.height = value;
			
			initLayout();
		}
		
		public function get thikness():Number
		{
			return _thikness;
		}
		
		override public function set width(value:Number):void{
			if(spaceContainer.width == value){
				return;
			}
			spaceContainer.width = value;
			initLayout();
		}
		
		override public function set height(value:Number):void{
			if(spaceContainer.height == value){
				return;
			}
			spaceContainer.height = value;
			initLayout();
		}
		
		public function get color():int
		{
			return _color;
		}
		
		public function set color(value:int):void
		{
			_color = value;
			topQuad.color = bottomQuad.color = leftQuad.color = rightQuad.color = value;
		}
	}
}