package com.gazman.ui.group.strict
{
	public interface IstrictGroup
	{
		/**
		 * A good place to add all your children. Originaly this method should be named initLayers as this is exactly what addind children does, 
		 * but with the current name you don't even have to read this comment. 
		 */
		function addChildrenHandler():void;
		
		/**
		 * @return true if you cannot procced to init layout just yet. 
		 * If you don't have any depandencies just return false.
		 * 
		 */
		function verifyDependencies():Boolean;
		
		/**
		 * A good place to set up your position and height and mofidy your children layout as neccecery.
		 */
		function initLayout():void;
	}
}