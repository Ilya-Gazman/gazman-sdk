// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.list.view 
{
	import com.gazman.components.list.view.balls.BallRenderer;
	import com.gazman.components.menu.view.signals.list.IListSelectedSignal;
	import com.gazman.components.screens.menu_screen.DefaultMenuScreen;
	import com.gazman.components.screens.menu_screen.SettingItem;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.drag.SmoothDragHandler;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.layouts.LinearLayout;
	import com.gazman.ui.list.List;
	import com.gazman.ui.list.ListLayoutData;
	import com.gazman.ui.panel.Panel;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class ListScreenView extends DefaultMenuScreen implements IListSelectedSignal
	{
		private var balls:List;
		private var smoothDragHandler:SmoothDragHandler;
		private var panel:Panel;
		private var optionsContainer:Group;
		private var horizontalListButton:Button;
		private var verticalListButton:Button;
		private var gridListButton:Button;
		private var applyButton:Button;
		
		private var settingsContainer:Group;
		private var structureRowsSettings:SettingItem;
		private var structureColumnsSettings:SettingItem;
		private var layoutColumnsSettings:SettingItem;
		private var layoutRowsSettings:SettingItem;
		private var layoutWidthSettings:SettingItem;
		private var layoutHigthSettings:SettingItem;
		private var listData:ListData;
		private const LIST_VERTICAL_SIZE:Number = 5;
		private const LIST_HORIZONTAL_SIZE:Number = 7;
		
		override public function addChildrenHandler():void
		{
			super.addChildrenHandler();
			
			balls = inject(List);
			panel = inject(Panel);
			optionsContainer = inject(Group);
			settingsContainer = inject(Group);
			structureRowsSettings = inject(SettingItem);
			structureColumnsSettings = inject(SettingItem);
			layoutColumnsSettings = inject(SettingItem);
			layoutRowsSettings = inject(SettingItem);
			layoutWidthSettings = inject(SettingItem);
			layoutHigthSettings = inject(SettingItem);
			listData = inject(ListData);
			
			
			smoothDragHandler = new SmoothDragHandler(balls);
			
			// By keeping all the initilize processes in one line, it will be easy later to change the layers order.
			initTitle("List componenet");
			initDescription(DescriptionText.LIST);
			addChild(panel);
			initButtons();
			initListSettings();
			initBalls();
			initApplyButton();
		}
		
		private function initApplyButton():void
		{
			applyButton = createButton("Apply", applyHandler);
			addChild(applyButton);
		}
		
		private function initListSettings():void
		{
			addChild(settingsContainer);
			initSettings(layoutColumnsSettings, "layout.columnsCount", setLayoutColumns);
			initSettings(layoutRowsSettings, "layout.rowsCount", setLayoutRows);
			initSettings(layoutWidthSettings, "layout.width", setLayoutWidth);
			initSettings(layoutHigthSettings, "layout.height", setLayoutHeight);
			initSettings(structureColumnsSettings, "structure.columnsCount", setStructureColumns);
			initSettings(structureRowsSettings, "structure.rowsCount", setStructureRows);
		}
		
		private function setLayoutWidth(value:Number):void
		{
			listData.layoutWidth = value;
		}
		
		private function setLayoutHeight(value:Number):void
		{
			listData.layoutHeight = value;
		}
		
		private function setStructureRows(value:Number):void
		{
			listData.stractureRows = value;
		}
		
		private function setStructureColumns(value:Number):void
		{
			listData.stractureColumns = value;
		}
		
		private function setLayoutRows(value:Number):void
		{
			listData.layoutRows = value;
		}
		
		private function setLayoutColumns(value:Number):void
		{
			listData.layoutColumns = value;
		}
		
		private function initSettings(listSettings:SettingItem, label:String, setLayoutColumns:Function):void
		{
			listSettings.label = label;
			listSettings.clearValue = ListLayoutData.NONE;
			listSettings.applyValue = setLayoutColumns;
			settingsContainer.addChild(listSettings);
		}
		
		private function initButtons():void
		{
			horizontalListButton = createButton("Horizontal Layout", horizontalListSelectedHandler);
			verticalListButton = createButton("Vertical Layout", verticalListSelectedHandler);
			gridListButton = createButton("Grid Layout", gridListSelectedHandler);
			
			addChild(optionsContainer);
			optionsContainer.addChild(horizontalListButton);
			optionsContainer.addChild(verticalListButton);
			optionsContainer.addChild(gridListButton);
		}
		
		private function gridListSelectedHandler():void
		{
			clearSelections();
			structureColumnsSettings.value = LIST_HORIZONTAL_SIZE * 10;
			structureRowsSettings.value = LIST_VERTICAL_SIZE * 10;
			layoutRowsSettings.value = LIST_VERTICAL_SIZE;
			layoutColumnsSettings.value = LIST_HORIZONTAL_SIZE;
			smoothDragHandler.allowHorizontalDrag = true;
			smoothDragHandler.allowVerticalDrag = true;
			applyHandler();
		}
		
		private function verticalListSelectedHandler():void
		{
			clearSelections();
			layoutRowsSettings.value = LIST_VERTICAL_SIZE;
			layoutColumnsSettings.value = 1;
			structureColumnsSettings.value = 1;
			smoothDragHandler.allowHorizontalDrag = false;
			smoothDragHandler.allowVerticalDrag = true;
			applyHandler();
		}
		
		private function horizontalListSelectedHandler():void
		{
			clearSelections();
			layoutColumnsSettings.value = LIST_HORIZONTAL_SIZE;
			layoutRowsSettings.value = 1;
			structureRowsSettings.value = 1;
			smoothDragHandler.allowHorizontalDrag = true;
			smoothDragHandler.allowVerticalDrag = false;
			applyHandler();
		}
		
		private function clearSelections():void
		{
			for(var i:int = 0; i < settingsContainer.numChildren; i++){
				var listSetting:SettingItem = settingsContainer.getChildAt(i) as SettingItem;
				listSetting.value = Layout.CLEAR_VALUE;
			}
		}
		
		private function createButton(label:String, trigger:Function):Button{
			var roundRectangle:Texture = ShapeTextur.roundRectangle("buttons", 120, 30, 3);
			var button:Button = new Button(roundRectangle, label);
			button.addEventListener(Event.TRIGGERED, trigger);
			button.fontColor = Color.WHITE;
			
			return button;
		}
		
		private function initBalls():void
		{
			balls.layout.rowsCount = LIST_VERTICAL_SIZE;
			balls.layout.columnsCount = 1;
			balls.structure.columnsCount = 1;
			
			balls.layout.typicalItem = inject(BallRenderer);
			balls.structure.itemRenderer = BallRenderer;
			
			var data:Array = new Array();
			for(var i:int = 1; i < 10000; i++){
				data.push(i);
			}
			
			balls.structure.dataProvider = data;
			
			smoothDragHandler.allowHorizontalDrag = false;
			
			panel.container.addChild(balls);
			verticalListSelectedHandler();
		}
		
		override public function initLayout():void
		{
			super.initLayout();

			// Layout buttons
			var linearLayout:LinearLayout = inject(LinearLayout);
			linearLayout.applyLayout(verticalListButton, horizontalListButton, gridListButton);
			var containerLayout:ContainerLayout = inject(ContainerLayout);
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(optionsContainer);
			var alignLayout:AlignLayout = inject(AlignLayout);
			alignLayout.below = 10;
			alignLayout.applyLayoutOn(optionsContainer, description);
			
			// Layout balls properties
			alignLayout.below = 30;
			containerLayout.applyLayoutOn(settingsContainer);
			alignLayout.applyLayoutOn(settingsContainer, optionsContainer);
			linearLayout.clear();
			linearLayout.verticalLayout = true;
			linearLayout.addChildren(structureColumnsSettings);
			linearLayout.addChildren(structureRowsSettings);
			linearLayout.addChildren(layoutColumnsSettings);
			linearLayout.addChildren(layoutRowsSettings);
			linearLayout.addChildren(layoutWidthSettings);
			linearLayout.addChildren(layoutHigthSettings);
			linearLayout.applyLayout();
			
			// Layout applyButton
			containerLayout.applyLayoutOn(applyButton);
			alignLayout.applyLayoutOn(applyButton, settingsContainer);
			
			// Layout panel
			alignLayout.applyLayoutOn(panel, title);
			alignLayout.toRight = 30;
			alignLayout.below = Layout.CLEAR_VALUE;
			alignLayout.applyLayoutOn(panel, optionsContainer);
			containerLayout.clear();
			containerLayout.top = 0;
			containerLayout.applyLayoutOn(panel, optionsContainer);
			panel.title = "List";
			panel.resizeByContainer(10);
		}
		
		private function applyHandler():void
		{
			balls.layout.width = listData.layoutWidth;
			balls.layout.height = listData.layoutHeight;
			balls.layout.rowsCount = listData.layoutRows;
			balls.layout.columnsCount = listData.layoutColumns;
			balls.structure.rowsCount = listData.stractureRows;
			balls.structure.columnsCount = listData.stractureColumns;
			balls.invalidate();
			panel.resizeByContainer(10);
		}
		
		public function listSelectedSignal():void
		{
			open();
		}
	}
}