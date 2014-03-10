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
	 * If classToReturn extends singleton, new instance will be created only once, and used for the next injections.
	 */
	public function inject(classToReturn:Class):*{
		return Factory.instance.inject(classToReturn);
	}
}