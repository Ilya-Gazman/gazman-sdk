package com.gazman.tutorials.groups
{
	import com.gazman.ui.group.Group;
	import com.gazman.ui.layouts.LinearLayout;
	
	import starling.display.Quad;
	
	public class Menu extends Group
	{
		private var background:Background = new Background();
		private var icons:Array = new Array();
		
		override protected function initilize():void
		{
			addChild(background);
			var linearLayout:LinearLayout = new LinearLayout(false);
			for(var i:int = 0; i < 8; i++){
				icons[i] = new Quad(50,50, randomColor);
				addChild(icons[i]);
				linearLayout.addChildren(icons[i]);
			}
			
			linearLayout.gap = 0;
			linearLayout.applyLayout();
		}
		
		private function get randomColor():uint{
			return Math.random() * 1000000;
		}
	}
}