package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.States.State;
	
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
			
			image_sl = new ImageSelector();
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
