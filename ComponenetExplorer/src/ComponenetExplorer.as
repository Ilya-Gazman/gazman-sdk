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
	import com.gazman.components.RootView;
	import com.gazman.ui.screens.FlashBaseView;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#ffffff")]
	public class ComponenetExplorer extends FlashBaseView
	{
		public function ComponenetExplorer()
		{
			// Attach source view
			ViewSource.addMenuItem(this, "srcview/index.html");
			
			// Initilize
			initialize(new ComponenetsContext(), RootView);
		}
	}
}
