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
	import com.adobe.viewsource.ViewSource;
	import com.gazman.components.ComponenetsContext;
	import com.gazman.ui.screens.root.RootView;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#ffffff")]
	public class ComponenetExplorer extends RootView
	{
		public function ComponenetExplorer()
		{
			ViewSource.addMenuItem(this, "srcview/index.html");
			new ComponenetsContext().initialize();
		}
	}
}
