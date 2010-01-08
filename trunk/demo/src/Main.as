package
{
	import States.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class Main extends Sprite
	{
		
		public static var input : InputManager;
		
		public static var stage_g : Stage; /* Auxilia os eventos de mouse e teclado. */
		
		public static var states : Array; /* Conjunto de estados do jogo. */
		
		public static var mainInstance : Main;
		
		public static const ST_MENU : int = 0;
		public static const ST_GAME : int = 1;
		public static const ST_PAUSE : int = 2;
		public static const ST_SETEERROS : int = 3;
		
		public static const WIDTH : int = 800;
		public static const HEIGHT : int = 600;
		
		public static var currentState : State;

		public function Main()
		{
			/* Prepara os recursos globais */
			Main.stage_g = this.stage;
			mainInstance = this;
			Main.input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			
			/*ainda nao sei como vai ser organizado cada jogo. Por enquanto so criei um
			estado a mais para o JOGO DOS SETE ERROS*/
			states[ST_SETEERROS] = new SeteErrosState();
			
			/* Seta estado inicial. */
			
			//Nao testem com o ST_SETEERROS pq vai dar erro. Pra funcionar
			//tem q mudar umas coisas no inputManager q eu tenho q ver dps
			//currentState = states[ST_SETEERROS];
			
			currentState = states[ST_GAME];
			currentState.assume(null);
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function setState(state : int)
		{
			var prev : State = currentState;
			currentState.leave();	
			currentState = states[state];
			currentState.assume(prev);
		}
		
		private function enterFrameHandler(e:Event)
		{
			currentState.enterFrame(e);			
		}
	}
}
