// =================================================================================================
//
//	Life Cycle Framework
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================

package
{
	import com.gazman.components.ComponenetsContext;
	import com.gazman.ui.screens.root.RootView;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#4a4137")]
	public class ComponenetExplorer extends RootView
	{
		public function ComponenetExplorer()
		{
			new ComponenetsContext().initialize();
		}
	}
}