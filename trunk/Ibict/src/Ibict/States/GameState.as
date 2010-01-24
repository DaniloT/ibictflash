package Ibict.States
{
	import Ibict.Games.Coleta.ColetaState;
	import Ibict.Games.Mundo.MundoState;
	import Ibict.Games.QuebraCabeca.PieceBuilder;
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.events.Event;
		
	public class GameState extends State
	{
		private static var mainInstance : Main;
		private static var input : InputManager;
		private static var currentState : State;
		
		public static var states : Array; /* Conjunto de estados do jogo. */
		
		public static const ST_COLETA		: int = 0;
		public static const ST_MUNDO		: int = 1;
		public static const ST_SETEERROS	: int = 2;
			
		public function GameState()
		{
			new PieceBuilder();
			/* Prepara os recursos globais */
			mainInstance = Main.getInstance();
			input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_COLETA] = new ColetaState();
			states[ST_MUNDO] = MundoState.getInstance();
			states[ST_SETEERROS] = new SeteErrosState();
			
			/* Seta estado inicial. */
			setState(ST_MUNDO);
			//setState(ST_COLETA);
		}
		
		public static function setState(state : int)
		{
			var prev : State = currentState;
			
			if (prev != null) {
				prev.leave();
			}
			
			currentState = states[state];
			currentState.assume(prev);
		}
		
		public override function enterFrame(e : Event)
		{
			currentState.enterFrame(e);			
		}
	}
}
