// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.screens
{
	import com.gazman.life_cycle.SingleTon;
	import com.gazman.ui.screens.signals.IStarlingIsReady;
	
	import starling.display.Sprite;
	
	/**
	 * Controlling the screens stack
	 */
	public class ScreensManager extends SingleTon implements IStarlingIsReady
	{
		private var screens:Vector.<BaseScreen> = new Vector.<BaseScreen>();
		private var _activeScreen:BaseScreen;

		private var _baseView:Sprite;
		
		/**
		 * Return the base view, the view that been registred with startling
		 */
		public function get baseView():Sprite
		{
			return _baseView;
		}

		public function startlingReadyHandler(baseView:Sprite):void
		{
			_baseView = baseView;
		}
		
		/**
		 * Retunr the top screen of the screens stack
		 */
		public function get activeScreen():BaseScreen
		{
			return _activeScreen;
		}

		/**
		 * Add screen to the top of the stack
		 */
		public function pushScreen(screen:BaseScreen):void{
			screens.push(screen);
			
			if(_activeScreen != null){
				_activeScreen.pause();
			}
			_activeScreen = screen;
			_activeScreen.create();
		}
		
		/**
		 * Remove the curently active screen. 
		 * @return the removed screen 
		 */		
		public function popScreen():BaseScreen{
			var screen:BaseScreen = screens.pop();
			if(screen != null){
				screen.clean();
			}
			
			if(screens.length > 0){
				_activeScreen = screens[screens.length - 1];
				_activeScreen.resume();
			}
			else{
				_activeScreen = null;
			}
			return screen;
		}
		
		/**
		 * Remove screen by referance 
		 * @param screen the screen to remove from the screens stack
		 */		
		public function removeScreen(screen:BaseScreen):void{
			for (var i:int = 0; i < screens.length; i++){
				if(screens[i] == screen){
					screens[i].clean();
					screens.splice(i, 1);
					break;
				}
			}
		}
	}
}