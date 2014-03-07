// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.layouts
{
	import starling.display.DisplayObject;

	public class LinearLayout
	{
		private var containerLayout:ContainerLayout = new ContainerLayout();
		private var children:Array = new Array();
		
		/**
		 * Default is 5
		 */
		public var gap:Number = 5;
		
		/**
		 * Set true for vertical layout and false for horizontal layout
		 */
		public var verticalLayout:Boolean;
		
		/**
		 * Set true for vertical layout and false for horizontal layout
		 */
		public function LinearLayout(isVerticalLayout:Boolean)
		{
			this.verticalLayout = isVerticalLayout;
		}
		
		/**
		 * Reset 
		 */
		public function clear():void{
			children = new Array();
		}
		
		/**
		 * adding DisplayObjects
		 */
		public function addChildren(...children):void{
			this.children.push.apply(this.children, children);
		}
		
		private var belowLayout:AlignLayout = new AlignLayout();
		private var rightLayout:AlignLayout = new AlignLayout();
		
		/**
		 * Calls to addChildren and layout
		 */
		public function applyLayout(...children):void{
			addChildren.apply(this, children);
			// We will just ignor this case
			if(this.children.length == 0){
				return;
			}
			if(verticalLayout){
				if(isNaN(left) && isNaN(right) && isNaN(horizontalCenter)){
					horizontalCenter = 0;
					applyLayout();
					horizontalCenter = Layout.CLEAR_VALUE;
					return;
				}
			}
			else{
				if(isNaN(top) && isNaN(left) && isNaN(verticalCenter)){
					verticalCenter = 0;
					applyLayout();
					verticalCenter = Layout.CLEAR_VALUE;
					return;
				}
			}
			var relativeChild:DisplayObject = this.children[0];
			var previusChild:DisplayObject = null;
			belowLayout.below = gap;
			rightLayout.toRight = gap;
			
			var alignLayout:AlignLayout;
			
			if(verticalLayout){
				alignLayout = belowLayout;
			}
			else{
				alignLayout = rightLayout;
			}
			
			for(var i:int = 0; i < this.children.length; i++){
				var child:DisplayObject = this.children[i];
				if(previusChild){
					containerLayout.applyLayoutOn(child, this.children[0]);
					alignLayout.applyLayoutOn(child, previusChild);
				}
				previusChild = child;
			}
		}

		public function get top():Number
		{
			return containerLayout.top;
		}

		public function set top(value:Number):void
		{
			containerLayout.top = value;
		}

		public function get bottom():Number
		{
			return containerLayout.bottom;
		}

		public function set bottom(value:Number):void
		{
			containerLayout.bottom = value;
		}

		public function get left():Number
		{
			return containerLayout.left;
		}

		public function set left(value:Number):void
		{
			containerLayout.left = value;
		}

		public function get right():Number
		{
			return containerLayout.right;
		}

		public function set right(value:Number):void
		{
			containerLayout.right = value;
		}

		public function get horizontalCenter():Number
		{
			return containerLayout.horizontalCenter;
		}

		public function set horizontalCenter(value:Number):void
		{
			containerLayout.horizontalCenter = value;
		}

		public function get verticalCenter():Number
		{
			return containerLayout.verticalCenter;
		}

		public function set verticalCenter(value:Number):void
		{
			containerLayout.verticalCenter = value;
		}
	}
}