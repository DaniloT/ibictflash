package Ibict.Games.Fabrica
{
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Classe principal do jogo da Fábrica, modela um State de GameState.
	 * 
	 * @author Luciano Santos
	 */
	public class FabricaState extends State {
		private static const CICLO1 : String =
			"7 283 135;1 614 135;5 350 255;1 481 255;5 614 255;2 481 381;6 614 381;8 283 70;12 682 70;"
			"9 283 198;11 547 198;10 419 313;13 682 313;14 547 439;";
		
		private static var CARDS : Array = null;
		
		private var ciclo : Ciclo;
		private var musica : Music;
		private var gameStateInstance : GameState;

		public function FabricaState() {
			super();
			
			if (CARDS == null) {
				CARDS = new Array();
				CARDS[0] = new fabArrow0(0, 0);
				CARDS[1] = new fabArrow1(0, 0);
				CARDS[2] = new fabArrow2(0, 0);
				CARDS[3] = new fabArrow3(0, 0);
				CARDS[4] = new fabArrow4(0, 0);
				CARDS[5] = new fabArrow5(0, 0);
				CARDS[6] = new fabArrow6(0, 0);
				CARDS[7] = new fabArrow7(0, 0);
				CARDS[8] = new fabCard8(0, 0);
				CARDS[9] = new fabCard9(0, 0);
				CARDS[10] = new fabCard10(0, 0);
				CARDS[11] = new fabCard11(0, 0);
				CARDS[12] = new fabCard12(0, 0);
				CARDS[13] = new fabCard13(0, 0);
				CARDS[14] = new fabCard14(0, 0);
			}
			
			this.root = new MovieClip();
			this.gameStateInstance = GameState.getInstance();
			
			this.root.addChild(new Bitmap(new fabFundo(0, 0)));
			
			this.ciclo = Ciclo.load(CICLO1, CARDS, 8);		
		}

		/* Override */
		public override function assume(previousState : State) {
			musica = new Music(new MusicaFabrica, false, 20);

			if (previousState != null){
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}

			gameStateInstance.addGraphics(root);
		}


		/* Override */
		public override function leave() {
			musica.stop(true);	
		}
		
		/* Override */
		public override function enterFrame(e : Event) {
				
		}
	}
}
