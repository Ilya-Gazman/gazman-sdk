// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.ui.group
{
	import com.gazman.ui.utils.setInitListener;
	
	import avmplus.getQualifiedClassName;
	
	import starling.display.Sprite;
	
	/**
	 * GazmanUI base componenet, it add a more clear life cycle to Sprite
	 */
	public class Group extends Sprite
	{
		private const initilizeCompleteSignal:InitilizeCompleteSignal = new InitilizeCompleteSignal();
		
		private var inititilizeComplete:Boolean;
		private var _pandingInitilize:Group;
		private var signalsListener:PrivateSignalListener;
		
		public function Group()
		{
			signalsListener = new PrivateSignalListener(this);
			setInitListener(this, startInitilize);
		}
		
		/**
		 * Make the initialize processes to run again.
		 */
		public function reset():void{
			inititilizeComplete = false;
			setInitListener(this, startInitilize);
		}
		
		private function startInitilize():void
		{
			initilize();
			inititilizeComplete = pandingInitilize == null;
			if(inititilizeComplete){
				initilizeCompleteSignal.initilizeCompleteHandler();
			}
		}
		
		/**
		 * Fire at the first time the Group been added to stage and never again.
		 */
		protected function initilize():void
		{
//			Log.warning(this, "No initilize was performed");
		}
		
		/**
		 * If target finished initilize, the subscribtion will fail and false will be returned. 
		 * In seccessfull subscribtion, <b>this.initilize</b> will be called once target initilize is complete
		 */
		public final function subscribeForInitilize(target:Group):Boolean{
			if(target.inititilizeComplete){
				return false;
			}
			target.initilizeCompleteSignal.addListener(signalsListener);
			pandingInitilize = target;
			return true;
		}
		
		private function get pandingInitilize():Group
		{
			return _pandingInitilize;
		}
		
		private function set pandingInitilize(value:Group):void
		{
			if(_pandingInitilize == value){
				return;
			}
			var targetPandingInitilize:Group = value;
			
			while(targetPandingInitilize != this){
				targetPandingInitilize = targetPandingInitilize.pandingInitilize;
				if(!targetPandingInitilize){
					_pandingInitilize = value;
					return;
				}
			}
			// Preparing error log
			var groups:Array = new Array();
			targetPandingInitilize = value;
			groups.push(getQualifiedClassName(this));
			while(targetPandingInitilize != this){
				groups.push(getQualifiedClassName(targetPandingInitilize));
				targetPandingInitilize = targetPandingInitilize.pandingInitilize;
			}
			groups.push(getQualifiedClassName(targetPandingInitilize));
			throw new Error("Recursion subscription acure", groups);
		}
		
		protected function get isInitilized():Boolean{
			return inititilizeComplete;
		}
		
		internal final function initilizeCompleteHandler():void
		{
			_pandingInitilize = null;
			startInitilize();
		}
	}
}
