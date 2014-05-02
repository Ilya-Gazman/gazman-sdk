package com.gazman.tutorials.groups
{
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.ContainerLayout;
	
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class Background extends Group
	{
		private var backgroundCover:Quad;
		
		override protected function initilize():void
		{
			backgroundCover = new Quad(10, 10, Color.FUCHSIA);
			addChild(backgroundCover);
			var containerLayout:ContainerLayout = new ContainerLayout();
			var margin:Number = -10;
			containerLayout.top = margin;
			containerLayout.bottom = margin;
			containerLayout.left = margin;
			containerLayout.right = margin;
			containerLayout.applyLayoutOn(backgroundCover, parent);
		}
	}
}