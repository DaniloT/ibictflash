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
		private static const CICLO1 = [
			[8,280,70], [12,680,70],
			[7,280,130], [1,610,130],
			[15,280,200], [11,540,200],
			[7,280,260], [1,475,260], [5,610,260],
			[9,280,320], [0,350,320], [10,415,320], [13,680,320],
			[2,475,390], [6,610,390],
			[14,540,450]];
		
		private static const CICLO2 : Array = [
			[8,280,70], [0,350,70], [15,415,70], [0,475,70], [16,540,70],
			[7,540,130],
			[18,415,200], [4,475,200], [17,540,200],
			[7,415,260],
			[19,415,320],
			[5,475,390],
			[20,540,450]];

		private static const CICLO3 : Array = [
			[21,280,70], [26,540,70],
			[7,280,130], [3,540,130],
			[14,280,200], [25,540,200],
			[7,280,260], [3,540,260],
			[22,280,320], [0,350,320], [23,415,320], [0,475,320], [24,540,320]];


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
			
			sel.addImage(new fabSelPapel(0, 0), "PAPEL - +1 estrela");
			sel.addImage(new fabSelLapis(0, 0), "LÁPIS - +2 estrelas");
			sel.addImage(new fabSelTenis(0, 0), "TÊNIS - +2 estrelas");
			
			sel.addEventListener(ImageSelector.IMAGE_SELECTED, cicloSelectorHandler);
			
			return sel;
		}
		
		private function cicloSelectorHandler(e : ImageSelectorEvent) {
			root.removeChild(ciclo_sl);
			
			var ciclo : Array = null;
			var prob : Number = 0.7;
			var ciclo_ref : int;
			/* Salva o modo selecionado. */
			switch (ciclo_sl.currentImageIndex) {
				case 0 :
					ciclo_ref = 0;
					ciclo = CICLO1;
					prob = 0.6;
					break;
				case 1 :
					ciclo_ref = 1;
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
			else if ((cur_state == in_game) && (in_game.done)) {
				root.removeChild(in_game);
				
				if (in_game.won) {
					GameState.profile.fabricaData.setCicloDone(in_game.ciclo_ref, true);
					GameState.profile.save();
				}

				ciclo_sl.currentImageIndex = 0;
				root.addChild(ciclo_sl);
				cur_state = ciclo_sl;
			}
		}
	}
}
