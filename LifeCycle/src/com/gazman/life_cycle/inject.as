// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package com.gazman.life_cycle
{
	
	
	
	/**
	 * The factory of the application. First it will search in the list created by the Registrators, if it's not been registered, new instance will be created.
	 * If classToReturn implements ISingleton, new instance will be created only once, and used for the next injections, also it supports multiton using the key parameter.
	 * 
	 * @param classToReturn the class to create or retrive
	 * @param key used for singleton pattern to have more than one singleton from same type in the system
	 * @return instance of @classToReturn 
	 * @see http://en.wikipedia.org/wiki/Multiton_pattern
	 */
	public function inject(classToReturn:Class, key:String = null):*{
		return Factory.instance.inject(classToReturn, key);
	}
}