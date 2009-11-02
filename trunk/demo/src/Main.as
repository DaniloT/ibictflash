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
		
		public static const ST_MENU : int = 0;
		public static const ST_GAME : int = 1;
		public static const ST_PAUSE : int = 2;
		
		public static var currentState : State;

		public function Main()
		{
			/* Prepara os recursos globais */
			Main.stage_g = this.stage;
			Main.input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			
			/* Seta estado inicial. */
			currentState = states[ST_GAME];
			currentState.enter();
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function setState(state : int)
		{
			currentState.leave();	
			currentState = states[state];
			currentState.enter();
		}
		
		private function enterFrameHandler(e:Event)
		{
			currentState.enterFrame(e);			
		}
	}
}
