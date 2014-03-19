package com.gazman.ui.screens
{
	import com.gazman.life_cycle.IInjector;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.screens.model.ScreenModel;
	
	public class BaseScreen extends Group implements ISingleTon, IInjector
	{
		protected var family:String = null;
		/**
		 * When fifo mode is set, the screen will be aded to the head of the queue. 
		 * If fifo mode is off, the screen will be pushed to the tail.
		 */
		protected var fifoMode:Boolean = true;
		private var screenModel:ScreenModel;
		
		
		public function injectionHandler():void
		{
			if(family == null){
				throw new Error("You must initilize the family parameter in the constractor");
			}
			screenModel = inject(ScreenModel, family);
		}
		
		public function resumeHandler():void{
			
		}
		
		public function pauseHandler():void{
			
		}
		
		/**
		 * Remove the screen from screens stack
		 */
		protected final function close():void{
			screenModel.removeScreen(this);
		}
		
		/**
		 * Add the screen to screens stack
		 */
		protected final function open():void{
			screenModel.puch(this, fifoMode);
		}
	}
}