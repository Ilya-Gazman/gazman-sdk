package com.gazman.ui.screens.model
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.ui.screens.model.signals.ActiveScreenChangedSignal;
	import com.gazman.ui.screens.BaseScreen;
	
	public class ScreenModel implements ISingleTon
	{
		public const activeScreenChangedSignal:ActiveScreenChangedSignal = new ActiveScreenChangedSignal();
		
		private var screens:Vector.<BaseScreen> = new Vector.<BaseScreen>();
		private var oldActiveScreen:BaseScreen;
		
		/**
		 * When fifo mode is set, the screen will be aded to the head of the queue. 
		 * If fifo mode is off, the screen will be pushed to the tail.
		 */
		public function puch(screen:BaseScreen, fifoMode:Boolean = true):void{
			saveActiveScreenState();
			if(fifoMode || screens.length == 0){
				screens.push(screen);
			}
			else{
				screens.splice(0, 0, screen);
			}
			validateActiveScreen();
		}
		
		public function removeScreen(screen:BaseScreen):void{
			saveActiveScreenState();
			for (var i:int = screens.length - 1; i >= 0; i--){
				if(screens[i] == screen){
					screens.splice(i, 1);
					break;
				}
			}
			
			validateActiveScreen();
		}
		
		public function get activeScreen():BaseScreen{
			return screens.length > 0 ? screens[screens.length - 1] : null;
		}
		
		
		private function saveActiveScreenState():void{
			oldActiveScreen = activeScreen;
		}
		
		private function validateActiveScreen():void{
			if(oldActiveScreen != activeScreen){
				activeScreenChangedSignal.activeScreenChangeHandler(activeScreen);
				if(oldActiveScreen){
					oldActiveScreen.pauseHandler();
				}
				if(activeScreen){
					activeScreen.resumeHandler();
				}
			}
		}
	}
}