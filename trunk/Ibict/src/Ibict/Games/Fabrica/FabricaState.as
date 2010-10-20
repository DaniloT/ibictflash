package Ibict.Games.Fabrica
{
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
		
		private var in_game : FabricaInGame;
		
		private var cur_state : Updatable;

		private var musica : Music;
		private var gameStateInstance : GameState;

		public function FabricaState() {
			super();
			
			this.root = new MovieClip();
			this.gameStateInstance = GameState.getInstance();
			
			this.root.addChild(new Bitmap(new fabFundo(0, 0)));

			cur_state = in_game = new FabricaInGame(CICLO1);
			this.root.addChild(in_game);
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
			cur_state.update(e);
		}
	}
}
