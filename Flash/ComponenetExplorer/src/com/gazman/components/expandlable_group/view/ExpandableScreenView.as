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
	import com.gazman.components.layout.view.Box;
	import com.gazman.components.menu.view.signals.expandable_group.IExpandableSelectedSignal;
	import com.gazman.components.screens.menu_screen.DefaultMenuScreen;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.expandable_group.ExpandableGroup;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.utils.ShapeTextur;
	import com.gazman.ui.utils.SpaceContainer;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class ExpandableScreenView extends DefaultMenuScreen implements IExpandableSelectedSignal
	{
		private var box:Box;
		private var background:SpaceContainer;
		private var expandable:ExpandableGroup;
		private var resetButton:Button;
		
		override public function addChildrenHandler():void
		{
			expandable = inject(ExpandableGroup);
			background = inject(SpaceContainer);
			box = inject(Box);
			
			box.setData("Box", Color.GREEN, 200);
			expandable.target = box;
			addChild(background);
			
			super.addChildrenHandler();
			
			initTitle("Expandable Group Component");
			initDescription("Just strech it and play with it.\n\nSimple as that.");
			addChild(expandable);
			initResetButton();
		}
		
		private function initResetButton():void
		{
			resetButton = new Button(ShapeTextur.roundRectangle("resetButton"), "Rest");
			resetButton.fontColor = Color.WHITE;
			resetButton.addEventListener(Event.TRIGGERED, reset);
			addChild(resetButton);
		}
		
		private function reset():void
		{
			layoutExpandable();
			expandable.validate();
			layoutExpandable();
		}
		
		override public function initLayout():void
		{
			super.initLayout();
			background.height = 640;
			reset();
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(resetButton, this);
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(resetButton, description);
		}
		
		private function layoutExpandable():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.verticalCenter = 0;
			containerLayout.applyLayoutOn(expandable, this);
			box.width = 200;
			box.height = 200;
		}
		
		public function expandableSelectedHandler():void
		{
			open();	
		}
	}
}