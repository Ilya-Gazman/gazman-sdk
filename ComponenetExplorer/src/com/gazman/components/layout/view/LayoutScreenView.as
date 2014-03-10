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
	import com.gazman.components.default_screen.DefaultMenuScreen;
	import com.gazman.components.default_screen.SettingItem;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.layouts.LinearLayout;
	import com.gazman.ui.panel.Panel;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class LayoutScreenView extends DefaultMenuScreen
	{
		private var boxA:Box = new Box("A", Color.BLUE, 100);
		private var boxB:Box = new Box("B", Color.RED, 200);
		private var containerLayoutPanel:Panel = new Panel();
		private var alignLayoutPanel:Panel = new Panel();
		
		// Container options
		private var top:SettingItem = new SettingItem();
		private var bottom:SettingItem = new SettingItem();
		private var left:SettingItem = new SettingItem();
		private var right:SettingItem = new SettingItem();
		private var horizontalCenter:SettingItem = new SettingItem();
		private var verticalCenter:SettingItem = new SettingItem();
		
		// Align options
		private var above:SettingItem = new SettingItem();
		private var below:SettingItem = new SettingItem();
		private var toLeft:SettingItem = new SettingItem();
		private var toRight:SettingItem = new SettingItem();
		
		private var applyContainerLayoutButton:Button;
		private var applyAlignLayoutButton:Button;
		private var containerLayoutButton:Button;
		private var alignLayoutButton:Button;
		
		// Layouts
		private var alignLayout:AlignLayout = new AlignLayout();
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var defaultBoxLayout:ContainerLayout = new ContainerLayout();
		
		override protected function addChildrenHandler():void
		{
			super.addChildrenHandler();
			initTitle("Layouting components");
			initDescription(DescriptionText.LAYOUT);
			initContainerLayoutButton();
			initAlignLayoutButton();
			initContainerLayoutPanel();
			initAlignLayoutPanel();
			addChild(boxB);
			initBoxA();
		}
		
		private function initAlignLayoutButton():void
		{
			alignLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton", 120), "Align Layout");
			alignLayoutButton.addEventListener(Event.TRIGGERED, showAlignLayout);
			addChild(alignLayoutButton);
		}
		
		private function initContainerLayoutButton():void
		{
			containerLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton", 120), "Container Layout");
			containerLayoutButton.addEventListener(Event.TRIGGERED, showContainerLayout);
			addChild(containerLayoutButton);
		}
		
		private function showContainerLayout():void
		{
			containerLayoutPanel.visible = true;
			alignLayoutPanel.visible = false;
		}
		
		private function showAlignLayout():void
		{
			containerLayoutPanel.visible = false;
			alignLayoutPanel.visible = true;
		}
		
		private function initOptionItem(settingsItem:SettingItem, lable:String, container:Group, action:Function):void
		{
			settingsItem.label = lable;
			settingsItem.clearValue = Layout.CLEAR_VALUE;
			settingsItem.applyValue = action;
			container.addChild(settingsItem);
		}
		
		private function initAlignLayoutPanel():void
		{
			alignLayoutPanel.title = "Align Layout";
			applyAlignLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton"), "Apply");
			applyAlignLayoutButton.addEventListener(Event.TRIGGERED, applyAlignLayoutHandler);
			alignLayoutPanel.container.addChild(applyAlignLayoutButton);
			
			addChild(alignLayoutPanel);	
			
			initOptionItem(toLeft, "To Left", alignLayoutPanel.container, setToLeft);
			initOptionItem(toRight, "To Right", alignLayoutPanel.container, setToRight);
			initOptionItem(above, "Above", alignLayoutPanel.container, setAbove);
			initOptionItem(below, "Below", alignLayoutPanel.container, setBelow);
		}
		
		private function setToRight(value:Number):void
		{
			alignLayout.toRight = value;
		}
		
		private function setAbove(value:Number):void
		{
			alignLayout.above = value;
		}
		
		private function setBelow(value:Number):void
		{
			alignLayout.below = value;
		}
		
		private function setToLeft(value:Number):void
		{
			alignLayout.toLeft = value;
		}
		
		private function initContainerLayoutPanel():void
		{
			containerLayoutPanel.title = "Container Layout";
			applyContainerLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton"), "Apply");
			applyContainerLayoutButton.addEventListener(Event.TRIGGERED, applyContainerLayoutHandler);
			containerLayoutPanel.container.addChild(applyContainerLayoutButton);
			
			addChild(containerLayoutPanel);	
			
			initOptionItem(top, "Top", containerLayoutPanel.container, setTop);
			initOptionItem(bottom, "Bottom", containerLayoutPanel.container, setBottom);
			initOptionItem(left, "Left", containerLayoutPanel.container, setLeft);
			initOptionItem(right, "Right", containerLayoutPanel.container, setRight);
			initOptionItem(horizontalCenter, "HorizontalCenter", containerLayoutPanel.container, setHorizontalCenter);
			initOptionItem(verticalCenter, "VerticalCenter", containerLayoutPanel.container, setVerticalCenter);
		}
		
		private function setBottom(value:Number):void
		{
			containerLayout.bottom = value;
		}
		
		private function setLeft(value:Number):void
		{
			containerLayout.left = value;
		}
		
		private function setRight(value:Number):void
		{
			containerLayout.right = value;
		}
		
		private function setHorizontalCenter(value:Number):void
		{
			containerLayout.horizontalCenter = value;
		}
		
		private function setVerticalCenter(value:Number):void
		{
			containerLayout.verticalCenter = value;
		}
		
		private function setTop(value:Number):void{
			containerLayout.top = value;
		}
		
		private function applyContainerLayoutHandler():void
		{
			resetBoxes();
			containerLayout.applyLayoutOn(boxA, boxB);
		}
		
		private function applyAlignLayoutHandler():void
		{
			resetBoxes();
			alignLayout.applyLayoutOn(boxA, boxB);
		}
		
		private function resetBoxes():void
		{
			boxA.width = boxA.height = 100;
			defaultBoxLayout.applyLayoutOn(boxA, boxB);
		}
		
		private function initBoxA():void
		{
			boxA.alpha = 0.5;
			addChild(boxA);
		}
		
		override protected function initLayout():void
		{
			super.initLayout();
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.right = 110;
			containerLayout.bottom = 110;
			containerLayout.applyLayoutOn(boxB, background);
			
			defaultBoxLayout.top = 5;
			defaultBoxLayout.left = 5;
			defaultBoxLayout.applyLayoutOn(boxA, boxB);
			
			containerLayout.clear();
			containerLayout.bottom = 10;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(containerLayoutButton);
			
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.toRight = 10;
			alignLayout.applyLayoutOn(alignLayoutButton, containerLayoutButton);
			containerLayout.clear();
			containerLayout.top = 0;
			containerLayout.applyLayoutOn(alignLayoutButton, containerLayoutButton);
			
			var linearLayout:LinearLayout = new LinearLayout(true);
			linearLayout.left = 0;
			linearLayout.applyLayout(
				top,
				bottom,
				left,
				right,
				horizontalCenter,
				verticalCenter, 
				applyContainerLayoutButton);
			containerLayoutPanel.resizeByContainer(10);
			alignLayout.clear();
			alignLayout.above = 10;
			alignLayout.applyLayoutOn(containerLayoutPanel, containerLayoutButton);
			containerLayout.clear();
			containerLayout.left = 0;
			containerLayout.applyLayoutOn(containerLayoutPanel, containerLayoutButton);
			
			linearLayout.clear();
			linearLayout.applyLayout(
				toLeft,
				toRight,
				above,
				below,
			applyAlignLayoutButton);
			alignLayoutPanel.resizeByContainer(10);
			alignLayout.applyLayoutOn(alignLayoutPanel, containerLayoutButton);
			containerLayout.applyLayoutOn(alignLayoutPanel, containerLayoutButton);
			showContainerLayout();
		}
		
	}
}