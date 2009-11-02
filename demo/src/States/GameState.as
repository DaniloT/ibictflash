package States
{
	import Entities.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameState extends State
	{
		private var trashes : Array;
		private static const NUM_ELEMENTS : int = 10;
		
		public var bin : Array;
		
		private var playing;
		
		public function GameState()
		{
			root = new MovieClip();
			playing = false;
			bin = new Array();
			
			
			bin.push(new MetalBin());
			bin.push(new GlassBin());
			bin.push(new PlasticBin());
			bin.push(new PaperBin());
			
			for(var i:int = 0; i<4; i++){
				root.addChild(bin[i]);
			}
		}
		
		public override function assume(previousState : State)
		{
			if (!playing) {
				trashes = new Array();
				for (var i : int = 0; i < NUM_ELEMENTS; i++) {
					trashes[i] = getRandomTrash(true);
					root.addChild(trashes[i]);
				}
				playing = true;
			}
			
			if (previousState != null){
				Main.stage_g.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.stage_g.addChild(this.root);
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
			for (var i : int = 0; i < trashes.length; i++) {
				trashes[i].update(e);
				
				if (trashes[i].toBeRemoved()){
					root.removeChild(trashes[i]);
					trashes[i] = getRandomTrash(false);
					root.addChild(trashes[i]); 
				}
			}
		}
		
		private function getRandomTrash(bool: Boolean):Trash
		{
			var i : int;
			i = Math.floor(Math.random() * 5);
			switch (i) {
				case (0): return(new Paper(bool));
						break;
				case (1): return(new Plastic(bool));
						break;
				case (2): return(new Glass(bool));
						break;
				case (3): return(new Metal(bool));
						break;
				case (4): return(new NotRec(bool));
						break;
			}
			return(null);
		}
	}
}
