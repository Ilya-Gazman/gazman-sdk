package com.gazman.ui.screens
{
	import com.gazman.life_cycle.IInjector;
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.screens.model.signals.IActiveScreenChangedSignal;
	import com.gazman.ui.screens.signals.container_ready.ContainerIsReadySignal;
	import com.gazman.ui.screens.model.ScreenModel;
	
	public class BaseScreensContainer extends Group implements ISingleTon, IInjector, IActiveScreenChangedSignal
	{
		protected var family:String = null;
		private var screenModel:ScreenModel;
		private var containerIsReadySignal:ContainerIsReadySignal;
		
		public function injectionHandler():void
		{
			if(family == null){
				throw new Error("You must initilize the family parameter in the constractor");
			}
			screenModel = inject(ScreenModel, family);
			screenModel.activeScreenChangedSignal.addListener(this);
			containerIsReadySignal = inject(ContainerIsReadySignal, family);
		}
		
		override protected function initilize():void
		{
			containerIsReadySignal.containerIsReadyHandler();
		}
		
		[Private]
		public function activeScreenChangeHandler(activeScreen:BaseScreen):void
		{
			removeChildren();
			addChild(activeScreen);
		}
		
		override public function dispose():void
		{
			screenModel.activeScreenChangedSignal.removeListener(this);
			super.dispose();
			removeChildren();
		}
		
		override public function reset():void
		{
			super.reset();
			screenModel.activeScreenChangedSignal.addListener(this);
		}
	}
}