package com.gazman.tutorials.groups
{
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.ContainerLayout;
	
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class GroupsRoot extends Group
	{
		private var backgroud:Quad;
		private var menu:Menu = new Menu();
		
		override protected function initilize():void
		{
			backgroud = new Quad(600, 800, Color.BLUE);
			addChild(backgroud);
			addChild(menu);
			
			var containerLayout:ContainerLayout = new ContainerLayout();
			containerLayout.horizontalCenter = 0;
			containerLayout.top = 40;
			containerLayout.applyLayoutOn(menu, backgroud);
		}
		
	}
}