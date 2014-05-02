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
	public class DescriptionText
	{
		public static const LIST:String = "" +
			"List control a collection of items that we wish to show to the user. In this example we have 10,000 balls that we wish to display." +
			"\nList have two main properties for that: List.layout - controls the display, and List.structure - controls the background data." +
			" List.stracture.rowsCount and List.stracture.columnsCount define what grid to create from the underling data, by not setting one of them " +
			"the list will calculate the other one as List.stracture.dataProvider.length / (the property you set)." +
			"\nThose properties are different from List.layout.columnsCount and List.layout.rowsCount because they define how many rows and columns we want to see." +
			" Also if List.layout.columnsCount" +
			" not set it will be calculated by List.layout.width and if you not set List.layout.rowsCount it will be calculated by List.layout.height" +
			"\n\nYou can now play with the above properties to see the various of lists that you can create."
			
		public static const LAYOUT:String = "You have two main ways to layout your component, either by using ContainerLayout or by using AlignLayout.\n" +
			"In this example we are layouting Box A relatively to Box B. Each time you hit the apply button before applying your settings the position " + 
			"and the size of the box are restored to its originals, so it will be easy for you to test each property separately."
	}
}