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
		
		private var ciclo : Ciclo;
		private var card_scroll : CardScroller;
		private var musica : Music;
		private var gameStateInstance : GameState;

		public function FabricaState() {
			super();
			
			this.root = new MovieClip();
			this.gameStateInstance = GameState.getInstance();
			
			this.root.addChild(new Bitmap(new fabFundo(0, 0)));

			//this.ciclo = Ciclo.load(CICLO1, CARDS, 8);		
		}

		/* Override */
		public override function assume(previousState : State) {
			musica = new Music(new MusicaFabrica, false, 20);
			
			card_scroll = new CardScroller(60, 60);
			this.root.addChild(card_scroll);
			card_scroll.x = 42;
			card_scroll.y = 61;
			for (var i : int = 0; i < 14; i++) {
				card_scroll.addCard(i);
			}

			if (previousState != null){
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}

			gameStateInstance.addGraphics(root);
		}


		/* Override */
		public override function leave() {
			this.root.removeChild(card_scroll);
			musica.stop(true);	
		}
		
		/* Override */
		public override function enterFrame(e : Event) {
			card_scroll.update(e);
		}
	}
}
