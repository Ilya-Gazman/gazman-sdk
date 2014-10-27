package com.gazman.ui.screens.model
{
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.ui.screens.BaseScreen;
	import com.gazman.ui.screens.model.signals.ActiveScreenChangedSignal;
	
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
		
		public function get numberOfScreensInStack():int{
			return screens.length;
		}
		
		/**
		 * Remove the top screen
		 * @param fifoMode if set than will remove from tail, otherwise from head
		 * @return the removed screen or null if there are no screens in the stack
		 */
		public function pop(fifoMode:Boolean = true):BaseScreen{
			if(screens.length == 0){
				return null;
			}
			saveActiveScreenState();
			if (fifoMode) {
				screens[screens.length - 1].close();
			}
			else{
				screens[0].close();
			}
			
			return activeScreen;
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