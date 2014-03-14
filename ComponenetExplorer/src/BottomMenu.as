package
{
	import com.gazman.ui.group.Group;
	
	public class BottomMenu extends Group
	{
		override protected function initilize():void
		{
			// Create dependency for parent. If background have not 
			// been initilize yet the subscription will succeed
			// And this.initilize() will be called again one 
			// background initilize is complete
			if (subscribeForInitilize(parent as Group)){ 
				return;
			}
			
			// do layouting logic here
		}
		
	}
}