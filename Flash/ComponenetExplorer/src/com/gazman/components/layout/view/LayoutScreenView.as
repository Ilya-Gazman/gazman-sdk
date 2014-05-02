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
	import com.gazman.components.menu.view.signals.layout.ILayoutSelectedSignal;
	import com.gazman.components.screens.menu_screen.DefaultMenuScreen;
	import com.gazman.components.screens.menu_screen.SettingItem;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.layouts.LinearLayout;
	import com.gazman.ui.panel.Panel;
	import com.gazman.ui.utils.ShapeTextur;
	import com.gazman.ui.utils.SpaceContainer;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class LayoutScreenView extends DefaultMenuScreen implements ILayoutSelectedSignal
	{
		private var boxA:Box;
		private var boxB:Box;
		private var containerLayoutPanel:Panel;
		private var alignLayoutPanel:Panel;
		
		// Container options
		private var top:SettingItem;
		private var bottom:SettingItem;
		private var left:SettingItem;
		private var right:SettingItem;
		private var horizontalCenter:SettingItem;
		private var verticalCenter:SettingItem;
		
		// Align options
		private var above:SettingItem;
		private var below:SettingItem;
		private var toLeft:SettingItem;
		private var toRight:SettingItem;
		
		private var applyContainerLayoutButton:Button;
		private var applyAlignLayoutButton:Button;
		private var containerLayoutButton:Button;
		private var alignLayoutButton:Button;
		
		// Layouts
		private var alignLayout:AlignLayout;
		private var containerLayout:ContainerLayout;
		private var defaultBoxLayout:ContainerLayout;
		private var background:SpaceContainer;
		
		override public function addChildrenHandler():void
		{
			containerLayoutPanel = inject(Panel);
			alignLayoutPanel = inject(Panel);
			
			
			boxA = inject(Box);
			boxA.setData("A", Color.BLUE, 100);
			boxB = inject(Box);
			boxB.setData("B", Color.RED, 200);
			containerLayoutPanel = inject(Panel);
			alignLayoutPanel = inject(Panel);
			
			// Container options
			top = inject(SettingItem);
			bottom = inject(SettingItem);
			left = inject(SettingItem);
			right = inject(SettingItem);
			horizontalCenter = inject(SettingItem);
			verticalCenter = inject(SettingItem);
			
			// Align options
			above = inject(SettingItem);
			below = inject(SettingItem);
			toLeft = inject(SettingItem);
			toRight = inject(SettingItem);
			
			// Layouts
			alignLayout = inject(AlignLayout);
			containerLayout = inject(ContainerLayout);
			defaultBoxLayout = inject(ContainerLayout);
			background = inject(SpaceContainer);
			
			
			addChild(background);
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
			// Cannot be injected as it don't have default constructor(without parameters).
			alignLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton", 120), "Align Layout");
			alignLayoutButton.fontColor = Color.WHITE;
			alignLayoutButton.addEventListener(Event.TRIGGERED, showAlignLayout);
			addChild(alignLayoutButton);
		}
		
		private function initContainerLayoutButton():void
		{
			// Cannot be injected as it don't have default constructor(without parameters).
			containerLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton", 120), "Container Layout");
			containerLayoutButton.fontColor = Color.WHITE;
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
			// Cannot be injected as it don't have default constructor(without parameters).
			applyAlignLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton"), "Apply");
			applyAlignLayoutButton.fontColor = Color.WHITE;
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
			// Cannot be injected as it don't have default constructor(without parameters).
			applyContainerLayoutButton = new Button(ShapeTextur.roundRectangle("layoutButton"), "Apply");
			applyContainerLayoutButton.fontColor = Color.WHITE;
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
		
		override public function initLayout():void
		{
			super.initLayout();
			background.height = 640;
			background.width = 960;

			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.right = 110;
			containerLayout.bottom = 110;
			containerLayout.applyLayoutOn(boxB, background);
			defaultBoxLayout.top = 0;
			defaultBoxLayout.left = 0;
			defaultBoxLayout.applyLayoutOn(boxA, boxB);
			
			containerLayout.clear();
			containerLayout.bottom = 10;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(containerLayoutButton, this);
			
			var alignLayout:AlignLayout = inject(AlignLayout);
			alignLayout.toRight = 10;
			alignLayout.applyLayoutOn(alignLayoutButton, containerLayoutButton);
			containerLayout.clear();
			containerLayout.top = 0;
			containerLayout.applyLayoutOn(alignLayoutButton, containerLayoutButton);
			
			var linearLayout:LinearLayout =inject(LinearLayout);
			linearLayout.verticalLayout = true; // The default is false what is making it to be horizontal layout
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
		
		public function layoutSelectedSignal():void
		{
			open();
		}
		
	}
}