// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.components.default_screen
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.screens.ScreensManager;
	import com.gazman.ui.screens.StrictScreenView;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class DefaultMenuScreen extends StrictScreenView
	{
		protected var title:TextField;
		protected var description:TextField;
		protected var backButton:Button;
		protected var background:Quad;
		private var screenManger:ScreensManager;
		
		override protected function injectionHandler():void
		{
			screenManger = inject(ScreensManager);
		}
		
		override protected function addChildrenHandler():void
		{
			initBackground();
			initBackButton();
		}
		
		private function initBackground():void
		{
			background = new Quad(960, 640, Color.WHITE);
			addChild(background);
		}
		
		protected function initTitle(text:String):void
		{
			title = new TextField(600, 32, text, "Verdana", 20, 0, true);
			addChild(title);
		}
		
		protected function initDescription(text:String):void
		{
			description = new TextField(960 - 20, 170, text);
			description.hAlign = HAlign.LEFT;
			description.vAlign = VAlign.TOP;
			addChild(description);
		}
		
		protected function initBackButton():void{
			var texture:Texture = ShapeTextur.roundRectangle("back button");
			backButton = new Button(texture, "Back");
			backButton.addEventListener(Event.TRIGGERED, backButtonHandler);
			addChild(backButton);
		}
		
		private function backButtonHandler():void
		{
			screenManger.popScreen();
		}
		
		override protected function initLayout():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			// Layout title
			containerLayout.top = 10;
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(title);
			
			containerLayout.horizontalCenter = Layout.CLEAR_VALUE;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(description);
			var alignLayout:AlignLayout = new AlignLayout();
			alignLayout.below = 0;
			alignLayout.applyLayoutOn(description, title);
			
			containerLayout.horizontalCenter = Layout.CLEAR_VALUE;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(backButton);
		}
		
		override protected function verifyDependencies():Boolean
		{
			return false;
		}
		
	}
}