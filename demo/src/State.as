package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class State
	{
		private var root : MovieClip;
		
		public function State()
		{
			Main.stage_g.removeChild(root);
		}
		
		public function enterFrame(e : Event)
		{
			
		}
		
		public function getGraphicsRoot() : DisplayObject
		{
			return null;
		}
	}
}
