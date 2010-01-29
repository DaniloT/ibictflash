package Ibict.States
{
	import Ibict.Games.Coleta.ColetaState;
	import Ibict.Games.Mundo.MundoState;
	import Ibict.Games.QuebraCabeca.QuebraCabecaState;
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.events.Event;
	
	/**
	 * Estado "Em Jogo" do jogo principal.
	 * 
	 * Esse estado também é ele mesmo uma máquina de estados, que alterna entre
	 * o mundo, os locais e os mini-jogos, que são sub-estados desse estado.
	 */
	public class GameState extends State
	{
		private static var mainInstance : Main;
		private static var input : InputManager;
		private static var currentState : State;
		
		private static var states : Array; /* Conjunto de estados do jogo. */
		
		/** Sub-estado do mundo. */
		public static const ST_MUNDO		: int = 0;
		/** Sub-estado do mini-jogo de coleta. */
		public static const ST_COLETA		: int = 1;
		/** Sub-estado do mini-jogo dos sete erros. */
		public static const ST_SETEERROS	: int = 2;
		/** Sub-estado do mini-jogo do quebra-cabeça. */
		public static const ST_QUEBRACABECA	: int = 3;
		/** Sub-estado do mini-jogo do caça-palavras. */
		public static const ST_CACAPALAVRAS	: int = 4;
		
		/**
		 * Cria um novo GameState.
		 */
		public function GameState()
		{
			/* Prepara os recursos globais */
			mainInstance = Main.getInstance();
			input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_COLETA] = new ColetaState();
			states[ST_MUNDO] = MundoState.getInstance();
			states[ST_SETEERROS] = new SeteErrosState();
			states[ST_QUEBRACABECA] = new QuebraCabecaState();
			states[ST_CACAPALAVRAS] = new PalavrasCruzadasState();
			
			/* Seta estado inicial. */
			//setState(ST_MUNDO);
			//setState(ST_COLETA);
			//setState(ST_SETEERROS);
			setState(ST_QUEBRACABECA);
			//setState(ST_CACAPALAVRAS);
		}
		
		/**
		 * Altera o estado atual para o estado dado.
		 * 
		 * @param state o novo estado, que dever ser uma das constantes
		 * de sub-estado.
		 */
		public static function setState(state : int)
		{
			var prev : State = currentState;
			
			if (prev != null) {
				prev.leave();
			}
			
			currentState = states[state];
			currentState.assume(prev);
		}
		
		/* Override. */
		public override function assume(previousState:State){
			
		}
		
		/* Override. */
		public override function enterFrame(e : Event)
		{
			currentState.enterFrame(e);			
		}
		
		/* Override. */
		public override function leave()
		{	
		}
	}
}
