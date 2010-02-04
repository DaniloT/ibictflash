package Ibict
{
	import Ibict.States.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * Classe principal do jogo, DisplayObject principal do Flash.
	 * 
	 * Essa classe é também a máquina de estados principal do jogo.
	 */
	public class Main extends Sprite {
		/** Estado do Menu. */
		public static const ST_MENU			: int = 0;
		/** Estado "Em Jogo". */
		public static const ST_GAME			: int = 1;
		/** Estado "Em Pausa". */
		public static const ST_PAUSE		: int = 2;
		/** Estado de loading. */
		public static const ST_LOAD			: int = 3;
		
		
		/** Largura da tela. */
		public static const WIDTH : int = 800;
		/** Altura da tela. */
		public static const HEIGHT : int = 600;
		
		
		/* Guarda a instância única desse singleton. */
		private static var instance : Main;
		
		/* Conjunto de estados do jogo. */
		private static var states : Array;
		
		/* Estado atual. */
		private var currentState : State;


		/**
		 * Cria uma nova instância de Main.
		 * 
		 * Lembre-se: essa classe é um singleton, instanciado automaticamente pelo
		 * Flash, tentar instanciá-la novamente causará um erro.
		 */
		public function Main()
		{
			if (instance != null)
				throw new Error("Tried to reinstantiate singleton!");
			
			
			/* Prepara os recursos globais */
			Main.instance = this;
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			states[ST_LOAD] = new LoadState();
			
			/* Seta estado inicial. */
			//setState(ST_LOAD);
			setState(ST_GAME);
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * Retorna a instância única deste singleton.
		 */
		public static function getInstance() : Main
		{
			return instance;
		}
		
		/**
		 * Altera o estado atual para o estado dado.
		 * 
		 * @param state o novo estado, que dever ser uma das constantes
		 * de estado.
		 */
		public function setState(state : int)
		{
			var prev : State = currentState;
			
			if (prev != null) {
				prev.leave();
			}
			
			currentState = states[state];
			currentState.assume(prev);
		}
		
		private function enterFrameHandler(e:Event)
		{
			currentState.enterFrame(e);			
		}
	}
}
