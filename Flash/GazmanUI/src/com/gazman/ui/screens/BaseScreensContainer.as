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
	import com.gazman.life_cycle.ISingleTon;
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.Group;
	import com.gazman.ui.screens.model.ScreenModel;
	import com.gazman.ui.screens.model.signals.IActiveScreenChangedSignal;
	import com.gazman.ui.screens.signals.container_ready.ContainerIsReadySignal;
	import com.gazman.ui.utils.SpaceContainer;
	
	import starling.errors.AbstractClassError;
	
	public class BaseScreensContainer extends Group implements ISingleTon, IActiveScreenChangedSignal
	{
		private var screenModel:ScreenModel = inject(ScreenModel, family);
		private var containerIsReadySignal:ContainerIsReadySignal  = inject(ContainerIsReadySignal, family);
		private var background:SpaceContainer = inject(SpaceContainer);
		
		override protected function initilize():void
		{
			visible = false;
			screenModel.activeScreenChangedSignal.addListener(this);
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			addChild(background);
			containerIsReadySignal.containerIsReadyHandler();
		}
		
		/**
		 * Remove all the screens and add the new active screen
		 */
		public function activeScreenChangeHandler(activeScreen:BaseScreen):void
		{
			removeChildren(1);
			if(activeScreen != null){
				addChild(activeScreen);
			}
			visible = numChildren > 1;
		}
		
		override public function dispose():void
		{
			screenModel.activeScreenChangedSignal.removeListener(this);
			super.dispose();
			removeChildren(1);
		}
		
		override public function reset():void
		{
			super.reset();
			screenModel.activeScreenChangedSignal.addListener(this);
		}
		
		protected function get family():String
		{
			throw new AbstractClassError();
		}
	}
}