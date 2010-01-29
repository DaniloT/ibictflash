package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Sub-estado da classe GameState que controla o mini-jogo de quebra-cabeça.
	 * 
	 * @author Luciano Santos
	 */
	public class QuebraCabecaState extends State
	{
		/* Define se está em jogo ou selecionando imagens. */
		private var in_game : Boolean;
		
		/* Raiz da árvore de gráficos para o estado de seleção de imagens. */
		private var img_selection_root : MovieClip;
		
		/* Raiz da árvore de gráficos para o estado de jogo. */
		private var in_game_root : MovieClip;
		
		private var image_sl : ImageSelector;
		
		/**
		 * Cria novo QuebraCabecaState.
		 */
		public function QuebraCabecaState()
		{
			super();
			
			root = new MovieClip();
			
			image_sl = new ImageSelector(PieceUtility.BOARD_WIDTH, PieceUtility.BOARD_HEIGHT);
			image_sl.addImage(new Quebra0(0,0), false);
			image_sl.addImage(new Quebra1(0,0), true);
			image_sl.addImage(new Quebra2(0,0), false);
			image_sl.addImage(new Quebra3(0,0), true);
			image_sl.addImage(new Quebra4(0,0), false);
			image_sl.addImage(new Quebra5(0,0), true);
			root.addChild(image_sl);
		}
		
		/* Override. */
		public override function assume(previousState : State)
		{
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			Main.getInstance().stage.addChild(root);
		}
		
		/* Override. */
		public override function leave()
		{	
		}
		
		/* Override. */
		public override function enterFrame(e : Event)
		{
			image_sl.update(e);
		}
	}
}
