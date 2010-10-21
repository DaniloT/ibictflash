package Ibict.Games.Fabrica
{
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
			new Array(7,283,135), new Array(1,614,135), new Array(5,350,255), new Array(1,481,255), new Array(5,614,255),
			new Array(2,481,381), new Array(6,614,381), new Array(8,283,70), new Array(12,682,70), new Array(9,283,198),
			new Array(11,547,198), new Array(10,419,313), new Array(13,682,313), new Array(14,547,439));
		
		private static const CICLO2 : Array = new Array(
			new Array(7,283,135), new Array(1,614,135), new Array(5,350,255), new Array(1,481,255), new Array(5,614,255),
			new Array(2,481,381), new Array(6,614,381), new Array(8,283,70), new Array(12,682,70), new Array(9,283,198),
			new Array(11,547,198), new Array(10,419,313), new Array(13,682,313), new Array(14,547,439));
		
		private static const CICLO3 : Array = new Array(
			new Array(7,283,135), new Array(1,614,135), new Array(5,350,255), new Array(1,481,255), new Array(5,614,255),
			new Array(2,481,381), new Array(6,614,381), new Array(8,283,70), new Array(12,682,70), new Array(9,283,198),
			new Array(11,547,198), new Array(10,419,313), new Array(13,682,313), new Array(14,547,439));
		
		
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
			sel.addImage(new fabSelLapis(0, 0), "LÁPIS", false);
			sel.addImage(new fabSelTenis(0, 0), "TÊNIS", false);
			
			sel.addEventListener(ImageSelector.IMAGE_SELECTED, cicloSelectorHandler);
			
			return sel;
		}
		
		private function cicloSelectorHandler(e : ImageSelectorEvent) {
			root.removeChild(ciclo_sl);
			
			var ciclo : Array = null;
			/* Salva o modo selecionado. */
			switch (ciclo_sl.currentImageIndex) {
				case 0 :
					ciclo = CICLO1;
					break;
				case 1 :
					ciclo = CICLO2;
					break;
				default :
					ciclo = CICLO3;
					break;
			}
			
			in_game = new FabricaInGame(ciclo);
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
				
				ciclo_sl.currentImageIndex = 0;
				root.addChild(ciclo_sl);
				cur_state = ciclo_sl;
			}
		}
	}
}
