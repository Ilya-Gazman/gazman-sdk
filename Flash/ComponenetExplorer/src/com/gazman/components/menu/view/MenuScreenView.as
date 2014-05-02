// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.menu.view
{
	import com.gazman.components.menu.view.signals.expandable_group.ExpandableSelectedSignal;
	import com.gazman.components.menu.view.signals.layout.LayoutSelectedSignal;
	import com.gazman.components.menu.view.signals.list.ListSelectedSignal;
	import com.gazman.components.screens.Screen;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.list.buttons_list.ButtonsList;
	import com.gazman.ui.list.buttons_list.ButtonData;
	import com.gazman.ui.screens.signals.root_created.IRootCratedSignal;
	
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class MenuScreenView extends Screen implements IRootCratedSignal
	{
		private var background:Quad;
		private var menu:ButtonsList = new ButtonsList();
		private var title:TextField;
		private var groupSelectedSignal:ExpandableSelectedSignal = inject(ExpandableSelectedSignal);
		private var listSelectSignal:ListSelectedSignal = inject(ListSelectedSignal);
		private var layoutSelectedSignal:LayoutSelectedSignal = inject(LayoutSelectedSignal);
		private var expandableSelectedSignal:ExpandableSelectedSignal = inject(ExpandableSelectedSignal);
		
		override public function addChildrenHandler():void
		{
			background = new Quad(960, 640, Color.WHITE);
			addChild(background);
			title = new TextField(350, 50, "Gazman SDK");
			title.autoScale = false;
			
			addChild(title);
			addChild(menu);
		}
		
		override public function initLayout():void
		{
			var layout:ContainerLayout = inject(ContainerLayout);
			layout.horizontalCenter = 0;
			layout.top = 10;
			layout.applyLayoutOn(title, this);
			layout.applyLayoutOn(menu, this);
			
			var alignLayout:AlignLayout = inject(AlignLayout);
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(menu, title);
			
			title.fontSize = 20;
			initMenu();
		}
		
		private function initMenu():void
		{
			var data:Array = new Array();
			data.push(new ButtonData("List", listSelectSignal.listSelectedSignal));
			data.push(new ButtonData("Layout", layoutSelectedSignal.layoutSelectedSignal));
			data.push(new ButtonData("Expandable Group", expandableSelectedSignal.expandableSelectedHandler));
			menu.structure.dataProvider = data;
			menu.invalidate();
		}		
		
		public function rootCratedHandler():void
		{
			open();
		}
		
	}
}