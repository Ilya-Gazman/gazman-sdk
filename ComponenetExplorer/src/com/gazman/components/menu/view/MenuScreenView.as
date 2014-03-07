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
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.list.simple_list.SimpleData;
	import com.gazman.ui.list.simple_list.SimpleList;
	import com.gazman.ui.screens.StrictScreenView;
	
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class MenuScreenView extends StrictScreenView
	{
		private var background:Quad;
		private var menu:SimpleList = new SimpleList();
		private var title:TextField;
		private var groupSelectedSignal:ExpandableSelectedSignal;
		private var listSelectSignal:ListSelectedSignal;
		private var layoutSelectedSignal:LayoutSelectedSignal;
		private var expandableSelectedSignal:ExpandableSelectedSignal;
		
		override protected function injectionHandler():void
		{
			groupSelectedSignal = inject(ExpandableSelectedSignal);
			listSelectSignal = inject(ListSelectedSignal);
			layoutSelectedSignal = inject(LayoutSelectedSignal);
			expandableSelectedSignal = inject(ExpandableSelectedSignal);
		}
		
		override protected function addChildrenHandler():void
		{
			background = new Quad(960, 640, Color.WHITE);
			addChild(background);
			title = new TextField(350, 50, "Gazman SDK");
			title.autoScale = false;
			
			addChild(title);
			addChild(menu);
		}
		
		override protected function initLayout():void
		{
			var layout:ContainerLayout = new ContainerLayout();
			layout.horizontalCenter = 0;
			layout.top = 10;
			layout.applyLayoutOn(title);
			layout.applyLayoutOn(menu);
			
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(menu, title);
			
			title.fontSize = 20;
			initMenu();
		}
		
		private function initMenu():void
		{
			var data:Array = new Array();
			data.push(new SimpleData("List", listSelectSignal.listSelectedSignal));
			data.push(new SimpleData("Layout", layoutSelectedSignal.layoutSelectedSignal));
			data.push(new SimpleData("Expandable Group", expandableSelectedSignal.expandableSelectedHandler));
			menu.structure.dataProvider = data;
			menu.invalidate();
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}
		
	}
}