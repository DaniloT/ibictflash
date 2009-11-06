package States
{
	import Entities.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameState extends State
	{
		/* Maximum number of trash elements on screen. */
		private static const NUM_ELEMENTS : int = 5;
		
		/* Arrays for holding trashes and bins. */
		private var trashes : Array;
		public var bins : Array;
		
		/* Helps controlling this state's loading process. */
		private var started : Boolean;
		
		public function GameState()
		{
			root = new MovieClip();
			started = false;
			
			bins = new Array();
			bins[TrashTypesEnum.GLASS] = new GlassBin();
			bins[TrashTypesEnum.METAL] = new MetalBin();
			//bin[TrashTypesEnum.NOT_REC] = new NotRecBin();
			bins[TrashTypesEnum.PAPER] = new PaperBin();
			bins[TrashTypesEnum.PLASTIC] = new PlasticBin();
			
			for(var i:int = 0; i <= TrashTypesEnum.PAPER /*i < TrashTypesEnum.size*/; i++){
				root.addChild(bins[i]);
			}
		}
		
		public override function assume(previousState : State)
		{
			if (!started) {
				trashes = new Array();
				for (var i : int = 0; i < NUM_ELEMENTS; i++) {
					newTrash(i, true)
				}
				started = true;
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
			var remove, test : Boolean;
			
			for (var i : int = 0; i < trashes.length; i++) {
				remove = trashes[i].toBeRemoved();
				test = false;
				
				// testa se colidiu com alguma lixeira
				for (var j : int = 0; (j < bins.length) && (!test); j++) {
					if ((test = trashes[i].pixelCollidesWith(bins[j]))) {
						if (j == trashes[i].getTargetBin()) {
							//calcular pontos positivos
						}
						else {
							//calcular pontos negativos
						}
					}
				}
				
				if (remove || test) {
					root.removeChild(trashes[i]);
					newTrash(i, false);
				}
				
				trashes[i].update(e);
			}
		}
		
		private function newTrash(index : int, randomY : Boolean)
		{
			var trash : Trash = null;
			var type : int = Math.floor(Math.random() * TrashTypesEnum.size);
			switch (type) {
				case TrashTypesEnum.PAPER:
					trash = new Paper(randomY);
					break;
				case TrashTypesEnum.PLASTIC:
					trash = new Plastic(randomY);
					break;
				case TrashTypesEnum.GLASS:
					trash = new Glass(randomY);
					break;
				case TrashTypesEnum.METAL:
					trash = new Metal(randomY);
					break;
				default:
					trash = new NotRec(randomY);
					break;
			}
			
			trashes[index] = trash;
			root.addChild(trashes[index]);
		}
	}
}
