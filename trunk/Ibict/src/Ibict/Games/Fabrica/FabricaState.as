package Ibict.Games.Fabrica {
	import Ibict.Games.QuebraCabeca.ImageSelector;
	import Ibict.Games.QuebraCabeca.ImageSelectorEvent;
	import Ibict.InputManager;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Classe principal do jogo da Fábrica, modela um State de GameState.
	 * 
	 * @author Luciano Santos
	 */
	public class FabricaState extends State {
		private static const CICLO1 : Array = new Array(
			new Array(8,280,70), new Array(12,680,70),
			new Array(7,280,130), new Array(1,610,130),
			new Array(15,280,200), new Array(11,540,200),
			new Array(7,280,260), new Array(1,475,260), new Array(5,610,260),
			new Array(9,280,320), new Array(0,350,320), new Array(10,415,320), new Array(13,680,320),
			new Array(2,475,390), new Array(6,610,390),
			new Array(14,540,450));
		
		private static const CICLO2 : Array = new Array(
			new Array(8,280,70), new Array(0,350,70), new Array(15,415,70), new Array(0,475,70), new Array(16,540,70),
			new Array(7,540,130),
			new Array(18,415,200), new Array(4,475,200), new Array(17,540,200),
			new Array(7,415,260),
			new Array(19,415,320),
			new Array(5,475,390),
			new Array(20,540,450));

		private static const CICLO3 : Array = new Array(
			new Array(21,280,70), new Array(26,540,70),
			new Array(7,280,130), new Array(3,540,130),
			new Array(14,280,200), new Array(25,540,200),
			new Array(7,280,260), new Array(3,540,260),
			new Array(22,280,320), new Array(0,350,320), new Array(23,415,320), new Array(0,475,320), new Array(24,540,320));


		private var inputManager : InputManager;
		private var gameStateInstance : GameState;
		
		private var in_game : FabricaInGame;
		
		private var cur_state : Updatable;

		private var ciclo_sl : ImageSelector;

		private var musica : Music;

		public function FabricaState() {
			super();
			
			this.inputManager = InputManager.getInstance();
			this.gameStateInstance = GameState.getInstance();
			
			this.root = new MovieClip();

			this.ciclo_sl = createCicloSelector();
			this.root.addChild(ciclo_sl);
			this.cur_state = ciclo_sl;
		}

		
		private function createCicloSelector() : ImageSelector {
			var sel : ImageSelector = new ImageSelector(
				200, 130,
				420, 315,
				"ESCOLHA O CICLO PARA MONTAR",
				new Bitmap(new fabMenu(0, 0)));
			
			sel.addImage(new fabSelPapel(0, 0), "PAPEL");
			sel.addImage(new fabSelLapis(0, 0), "LÁPIS");
			sel.addImage(new fabSelTenis(0, 0), "TÊNIS");
			
			sel.addEventListener(ImageSelector.IMAGE_SELECTED, cicloSelectorHandler);
			
			return sel;
		}
		
		private function cicloSelectorHandler(e : ImageSelectorEvent) {
			root.removeChild(ciclo_sl);
			
			var ciclo : Array = null;
			var prob : Number = 0.7;
			var ciclo_ref : int = ciclo_sl.currentImageIndex;
			/* Salva o modo selecionado. */
			switch (ciclo_ref) {
				case 0 :
					ciclo = CICLO1;
					prob = 0.6;
					break;
				case 1 :
					ciclo = CICLO2;
					prob = 0.4;
					break;
				default :
					ciclo_ref = 2;
					ciclo = CICLO3;
					prob = 0.2;
					break;
			}
			
			in_game = new FabricaInGame(ciclo_ref, ciclo, prob);
			root.addChild(in_game);			
			cur_state = in_game;
		}


		/* Override */
		public override function assume(previousState : State) {
			musica = new Music(new MusicaFabrica, false, 20);
			if (cur_state != ciclo_sl) {
				this.root.removeChild(in_game);
				this.root.addChild(ciclo_sl);
				this.cur_state = ciclo_sl;
			}
			
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
			cur_state.update(e);
			
			if (cur_state == ciclo_sl) {
				if(inputManager.getMousePoint().x < 230 &&
					inputManager.getMousePoint().y > 524 &&
					inputManager.mouseClick()) {
						GameState.setState(GameState.ST_MUNDO);
				}
			}
			else if ((cur_state == in_game) && (in_game.complete)) {
				root.removeChild(in_game);

				GameState.profile.fabricaData.ciclos_done[in_game.ciclo_ref] = true;
				GameState.profile.save();

				ciclo_sl.currentImageIndex = 0;
				root.addChild(ciclo_sl);
				cur_state = ciclo_sl;
			}
		}
	}
}
