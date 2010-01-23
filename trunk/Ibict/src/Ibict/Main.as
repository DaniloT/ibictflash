package Ibict
{
	import Ibict.States.*;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class Main extends Sprite
	{
		public static const ST_MENU : int = 0;
		public static const ST_GAME : int = 1;
		public static const ST_PAUSE : int = 2;
		public static const ST_SETEERROS : int = 3;
		public static const ST_LOAD	: int = 4;
		
		public static const WIDTH : int = 800;
		public static const HEIGHT : int = 600;
		
		private static var instance : Main;
		
		public static var states : Array; /* Conjunto de estados do jogo. */
		
		private var currentState : State;

		public function Main()
		{
			/* Prepara os recursos globais */
			Main.instance = this;
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			
			/*ainda nao sei como vai ser organizado cada jogo. Por enquanto so criei um
			estado a mais para o JOGO DOS SETE ERROS e para o estado de load*/
			states[ST_SETEERROS] = new SeteErrosState();
			states[ST_LOAD] = new LoadState();
			
			/* Seta estado inicial. */
			setState(ST_GAME);
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public static function getInstance() : Main
		{
			return(instance);
		}
		
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
