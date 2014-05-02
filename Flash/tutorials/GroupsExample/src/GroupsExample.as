package
{
	import com.gazman.tutorials.groups.GroupsRoot;
	
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#4a4137")]
	public class GroupsExample extends Sprite
	{
		public function GroupsExample()
		{
			var starlingInstance:Starling = new Starling(GroupsRoot, stage);
			starlingInstance.start();
		}
	}
}