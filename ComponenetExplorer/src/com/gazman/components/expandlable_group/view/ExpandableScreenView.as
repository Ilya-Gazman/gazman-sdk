// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.expandlable_group.view
{
	import com.gazman.components.default_screen.DefaultMenuScreen;
	import com.gazman.components.layout.view.Box;
	import com.gazman.ui.expandable_group.ExpandableGroup;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class ExpandableScreenView extends DefaultMenuScreen
	{
		private var box:Box = new Box("A", Color.GREEN, 200);
		private var expandable:ExpandableGroup = new ExpandableGroup(box);
		private var resetButton:Button;
		
		override protected function addChildrenHandler():void
		{
			super.addChildrenHandler();
			initTitle("Expandable Group Component");
			initDescription("Just strech it and play with it.\n\nSimple as that.");
			addChild(expandable);
			initResetButton();
		}
		
		private function initResetButton():void
		{
			resetButton = new Button(ShapeTextur.roundRectangle("resetButton"), "Rest");
			resetButton.addEventListener(Event.TRIGGERED, reset);
			addChild(resetButton);
		}
		
		private function reset():void
		{
			layoutExpandable();
			expandable.validate();
			layoutExpandable();
		}
		
		override protected function initLayout():void
		{
			super.initLayout();
			
			reset();
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(resetButton);
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(resetButton, description);
		}
		
		private function layoutExpandable():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.verticalCenter = 0;
			containerLayout.applyLayoutOn(expandable);
			box.width = 200;
			box.height = 200;
		}
		
	}
}