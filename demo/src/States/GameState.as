package States
{
	import Entities.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameState extends State
	{
		private var trashes : Array;
		private static const NUM_ELEMENTS : int = 5;
		
		public var bins : Array;
		
		private var playing;
		
		public function GameState()
		{
			root = new MovieClip();
			playing = false;
			
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
					trashes[i] = getRandomTrash(false);
					root.addChild(trashes[i]);
				}
				
				trashes[i].update(e);
			}
		}
		
		private function getRandomTrash(randomY: Boolean):Trash
		{
			var i : int = Math.floor(Math.random() * TrashTypesEnum.size);
			
			switch (i) {
				case TrashTypesEnum.PAPER:
					return new Paper(randomY);
					break;
				case TrashTypesEnum.PLASTIC:
					return new Plastic(randomY);
					break;
				case TrashTypesEnum.GLASS:
					return new Glass(randomY);
					break;
				case TrashTypesEnum.METAL:
					return new Metal(randomY);
					break;
				default:
					return new NotRec(randomY);
					break;
			}
		}
	}
}
