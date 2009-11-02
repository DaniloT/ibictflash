package States
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameState extends State
	{
		private var trashes : Array;
		private static const NUM_ELEMENTS : int = 10;
		 
		public function GameState()
		{
			root = new MovieClip();
		}
		
		public override function enter()
		{
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{	
		}
	}
}
