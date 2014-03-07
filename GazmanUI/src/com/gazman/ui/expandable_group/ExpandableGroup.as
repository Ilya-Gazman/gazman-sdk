// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.expandable_group
{
	import com.gazman.ui.expandable_group.signals.SizeChangedSignal;
	import com.gazman.ui.group.Group;
	
	import flash.display.Stage3D;
	
	import starling.display.DisplayObject;
	
	/**
	 * Allows user to change Group size
	 */
	public class ExpandableGroup extends StrictGroup
	{
		private var allowAddChild:Boolean;

		private var target:DisplayObject;
		private var topLeftBox:Box;
		private var topRightBox:Box;
		private var bottomLeftBox:Box;
		private var bottomRightBox:Box;
		
		private var leftStick:HorizontalStick;
		private var righStick:HorizontalStick
		private var topStick:VerticalStick;
		private var bottomStick:VerticalStick;
		
		public const sizeChangedSignal:SizeChangedSignal = new SizeChangedSignal();
		
		/**
		 * ExpandableGroup can have only one child and it is the target
		 * 
		 */		
		public function ExpandableGroup(target:DisplayObject)
		{
			this.target = target;
			topLeftBox = new Box(this);
			topRightBox = new Box(this);
			bottomLeftBox = new Box(this);
			bottomRightBox = new Box(this);
			
			leftStick = new HorizontalStick(this);
			righStick = new HorizontalStick(this);
			
			topStick = new VerticalStick(this);
			bottomStick = new VerticalStick(this);
		}
		
		override protected function addChildrenHandler():void
		{
			addChildPrivatly(target, 1);
			addChildPrivatly(leftStick);
			addChildPrivatly(righStick);
			addChildPrivatly(bottomStick);
			addChildPrivatly(topStick);
			addChildPrivatly(topLeftBox);
			addChildPrivatly(topRightBox);
			addChildPrivatly(bottomLeftBox);
			addChildPrivatly(bottomRightBox);
		}
		
		override protected function initLayout():void
		{
			target.x = target.y = 0;
			
			var paddingX:int = -topLeftBox.width / 2;
			var paddingY:int = -topLeftBox.height / 2;
			
			topLeftBox.x = paddingX;
			topLeftBox.y = paddingY;
			
			topRightBox.x = paddingX + target.width;
			topRightBox.y = paddingY;
			
			bottomLeftBox.x = paddingX;
			bottomLeftBox.y = paddingY + target.height;
			
			bottomRightBox.x = paddingX + target.width;
			bottomRightBox.y = paddingY + target.height;
			
			updateStickSizesAndPosition();
		}
		
		/**
		 * Calls initLayout
		 */
		public function validate():void
		{
			initLayout();
		}
		
		override protected function verifyDependencies():Boolean
		{
			if(target is Group && subscribeForInitilize(target as Group)){
				return true;
			}
			
			return false;
		}
		
		private function addChildPrivatly(child:DisplayObject, alpha:Number = 0):void{
			allowAddChild = true;
			child.alpha = alpha;
			addChild(child);
			allowAddChild = false;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject{
			if(allowAddChild){
				return super.addChildAt(child,index);
			}
			throw new Error("Addind child is not supported");
		}
		
		internal function updateSizeAndPositionsByBoxes(delatX:Number, deltaY:Number):void
		{
			if(topLeftBox.x > topRightBox.x || topLeftBox.x > bottomRightBox.x
			|| bottomLeftBox.x > topRightBox.x || bottomLeftBox.x > bottomRightBox.x){
				swapBoxesHorizontaly();				
			}
			
			if(topLeftBox.y > bottomLeftBox.y || topLeftBox.y > bottomRightBox.y
				|| topRightBox.y > bottomLeftBox.y || topRightBox.y > bottomRightBox.y){
				swapBoxesVerticaly();				
			}
			
			if(delatX < 0){
				topLeftBox.x = bottomLeftBox.x = Math.min(topLeftBox.x, bottomLeftBox.x);
				topRightBox.x = bottomRightBox.x = Math.min(topRightBox.x, bottomRightBox.x);
			}
			else if(delatX > 0){
				topLeftBox.x = bottomLeftBox.x = Math.max(topLeftBox.x, bottomLeftBox.x);
				topRightBox.x = bottomRightBox.x = Math.max(topRightBox.x, bottomRightBox.x);
			}
			
			if(deltaY < 0){
				topLeftBox.y = topRightBox.y = Math.min(topLeftBox.y, topRightBox.y);
				bottomLeftBox.y = bottomRightBox.y = Math.min(bottomLeftBox.y, bottomRightBox.y);
			}
			else{
				topLeftBox.y = topRightBox.y = Math.max(topLeftBox.y, topRightBox.y);
				bottomLeftBox.y = bottomRightBox.y = Math.max(bottomLeftBox.y, bottomRightBox.y);
			}
			
			target.width = topRightBox.x - bottomLeftBox.x; 
			target.height = bottomLeftBox.y - topRightBox.y; 
			
			target.x = topLeftBox.x + topLeftBox.width / 2;
			target.y = topLeftBox.y + topLeftBox.height / 2;
			trim();
			updateStickSizesAndPosition();
		}
		
		internal function updateSizeAndPositionsBySticks():void
		{
			if(leftStick.x > righStick.x){
				var tmpHorizontal:HorizontalStick = leftStick;
				leftStick = righStick;
				righStick = tmpHorizontal;
			}
			
			if(topStick.y > bottomStick.y){
				var tmpVertical:VerticalStick = topStick;
				topStick = bottomStick;
				bottomStick = tmpVertical;
			}
			
			topLeftBox.x = bottomLeftBox.x = leftStick.x;
			topRightBox.x = bottomRightBox.x = righStick.x;
			topLeftBox.y = topRightBox.y = topStick.y;
			bottomRightBox.y = bottomLeftBox.y = bottomStick.y;
			updateSizeAndPositionsByBoxes(0, 0);
			updateStickSizesAndPosition();
		}
		
		private function updateStickSizesAndPosition():void
		{
			leftStick.height = righStick.height = target.height - topLeftBox.height;
			topStick.width = bottomStick.width = target.width - topLeftBox.width;
			
			leftStick.x = topLeftBox.x;
			leftStick.y = topLeftBox.y + topLeftBox.height;
			
			righStick.x = topRightBox.x;
			righStick.y = topRightBox.y + topRightBox.height;
			
			topStick.x = topLeftBox.x + topLeftBox.width;
			topStick.y = topLeftBox.y;
			
			bottomStick.x = bottomLeftBox.x  + bottomLeftBox.width;
			bottomStick.y = bottomLeftBox.y;
			
			sizeChangedSignal.sizeChangedHandler();
		}
		
		private function trim():void
		{
			var deltaX:Number = target.x;
			var deltaY:Number = target.y;
			
			x += deltaX;
			y += deltaY;
			
			target.x -= deltaX;
			target.y -= deltaY;
			topLeftBox.x -= deltaX;
			topLeftBox.y -= deltaY;
			topRightBox.x -= deltaX;
			topRightBox.y -= deltaY;
			bottomLeftBox.x -= deltaX;
			bottomLeftBox.y -= deltaY;
			bottomRightBox.x -= deltaX;
			bottomRightBox.y -= deltaY;
		}
		
		private function swapBoxesVerticaly():void
		{
			var tmpBox:Box = topLeftBox;
			topLeftBox = bottomLeftBox;
			bottomLeftBox = tmpBox;
			
			tmpBox = topRightBox;
			topRightBox = bottomRightBox;
			bottomRightBox = tmpBox;
		}
		
		private function swapBoxesHorizontaly():void
		{
			var tmpBox:Box = topLeftBox;
			topLeftBox = topRightBox;
			topRightBox = tmpBox;
			
			tmpBox = bottomLeftBox;
			bottomLeftBox = bottomRightBox;
			bottomRightBox = tmpBox;
		}
		
		internal function dragFinished():void
		{
			// TODO Auto Generated method stub
		}
		
		internal function dragStarted():void
		{
			// TODO Auto Generated method stub
		}
	}
}