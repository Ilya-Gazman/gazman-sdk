// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.group.strict
{
	import com.gazman.ui.group.Group;
	
	/**
	 * Splits the initilize() process of Group to three parts. By not implemnting any of the parts you will get exception.
	 */
	public class StrictGroup extends Group
	{
		protected var childrenInitilized:Boolean;
		final override protected function initilize():void
		{
			if(!childrenInitilized){
				childrenInitilized = true;
				addChildrenHandler();
			}
			if (verifyDependencies()){
				return;
			}
			initLayout();
		}
		
		/**
		 * A good place to add all your children. Originaly this method should be named initLayers as this is exactly what addind children does, 
		 * but with the current name you don't even have to read this comment. 
		 */
		protected function addChildrenHandler():void
		{
			throw new Error("in StrickedGroup addChildrenHandler must be overiden");
		}
		
		/**
		 * @return true if you cannot procced to init layout just yet. 
		 * If you don't have any depandencies just return false.
		 * 
		 */
		protected function verifyDependencies():Boolean
		{
			throw new Error("in StrickedGroup verifyDependencies must be overiden");
		}
		
		/**
		 * A good place to set up your position and height and mofidy your children layout as neccecery.
		 */
		protected function initLayout():void
		{
			throw new Error("in StrickedGroup initLayout must be overiden");
		}
		
		override public function reset():void
		{
			super.reset();
			childrenInitilized = false;
		}
		
	}
}