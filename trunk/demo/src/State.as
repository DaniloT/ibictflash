package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class State
	{
		protected var root : MovieClip;
				
		public function State()
		{
			root = null;
		}
		
		public function enter()
		{
		}
		
		public function leave()
		{	
		}
		
		public function enterFrame(e : Event)
		{	
		}
		
		public function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
	}
}
