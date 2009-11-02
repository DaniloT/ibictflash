package States
{
	import Entities.Trash;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameState extends State
	{
		private var trashes : Array;
		private static const NUM_ELEMENTS : int = 10;
		
		private var playing;
		
		public function GameState()
		{
			root = new MovieClip();
			playing = false;
		}
		
		public override function assume(previousState : State)
		{
			if (!playing) {
				trashes = new Array();
				for (var i : int = 0; i < NUM_ELEMENTS; i++) {
					trashes[i] = new Trash();
				}
				playing = true;
			}
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
			for (var i : int = 0; i < trashes.length; i++) {
				trashes[i].update(e);
			}
		}
	}
}
