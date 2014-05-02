package com.gazman.ui.group.strict
{
	public class StrictGroupHelper
	{
		public var target:IstrictGroup;
		private var childrenInitilized:Boolean;
		
		public function initilize():void{
			if(!target){
				throw new Error("Target is not set");
			}
			if(!childrenInitilized){
				childrenInitilized = true;
				target.addChildrenHandler();
			}
			if (target.verifyDependencies()){
				return;
			}
			target.initLayout();
		}
		
		public function reset():void{
			childrenInitilized = false;
		}
	}
}