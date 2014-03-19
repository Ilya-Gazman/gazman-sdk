package com.gazman.components.screens
{
	import com.gazman.life_cycle.inject;
	import com.gazman.ui.group.strict.IstrictGroup;
	import com.gazman.ui.group.strict.StrictGroupHelper;
	import com.gazman.ui.screens.BaseScreen;
	
	public class Screen extends BaseScreen implements IstrictGroup
	{
		private var strictGroupHelper:StrictGroupHelper;
		public function Screen()
		{
			family = ScreensContainer.FAMILY;
		}
		
		override protected function initilize():void
		{
			strictGroupHelper = inject(StrictGroupHelper);
			strictGroupHelper.target = this;
			strictGroupHelper.initilize();
		}
		
		override public function reset():void
		{
			super.reset();
			strictGroupHelper.reset();
		}
		
		public function addChildrenHandler():void{}
		public function initLayout():void{}
		public function verifyDependencies():Boolean
		{
			return false;
		}
		
	}
}