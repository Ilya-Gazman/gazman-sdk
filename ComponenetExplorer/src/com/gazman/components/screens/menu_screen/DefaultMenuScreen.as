package com.gazman.components.screens.menu_screen
{
	import com.gazman.components.screens.Screen;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.layouts.AlignLayout;
	import com.gazman.ui.layouts.ContainerLayout;
	import com.gazman.ui.layouts.Layout;
	import com.gazman.ui.utils.ShapeTextur;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class DefaultMenuScreen extends Screen
	{
		protected var title:TextField;
		protected var description:TextField;
		protected var backButton:Button;
		
		override public function addChildrenHandler():void
		{
			initBackButton();
		}
		
		override public function initLayout():void
		{
			var containerLayout:ContainerLayout = new ContainerLayout();
			// Layout title
			containerLayout.top = 10;
			containerLayout.horizontalCenter = 0;
			containerLayout.applyLayoutOn(title);
			
			containerLayout.horizontalCenter = Layout.CLEAR_VALUE;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(description);
			var alignLayout:AlignLayout = inject(AlignLayout);
			alignLayout.below = 0;
			alignLayout.applyLayoutOn(description, title);
			
			containerLayout.horizontalCenter = Layout.CLEAR_VALUE;
			containerLayout.left = 10;
			containerLayout.applyLayoutOn(backButton);
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
			backButton.addEventListener(Event.TRIGGERED, close); // close is defined in BaseScreen, it remove the screen from screens stack
			addChild(backButton);
		}
	}
}