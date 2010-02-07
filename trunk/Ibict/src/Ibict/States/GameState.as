package Ibict.States
{
	import Ibict.Games.CacaPalavras.CacaPalavrasState;
	import Ibict.Games.Coleta.ColetaState;
	import Ibict.Games.Mundo.MundoState;
	import Ibict.Games.QuebraCabeca.QuebraCabecaState;
	import Ibict.Games.SeteErros.SeteErrosState;
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.Message;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
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
		private static var instance : GameState;
		
		private static var states : Array; /* Conjunto de estados do jogo. */
		
		public static var beforePause : State ;
		public static var beforePauseConst : int = -1;
		
		private var msg : Array = new Array();
		
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
		/** Estado "Em Pausa" */
		public static const ST_PAUSE	: int = 5;
		
		/**
		 * Cria um novo GameState.
		 */
		public function GameState(){
			
			if (instance != null)
				throw new Error("Tried to reinstantiate singleton!");
				
			instance = this;
			
			root = new MovieClip();
			root.added = false;
			/* Prepara os recursos globais */
			mainInstance = Main.getInstance();
			input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_COLETA] = new ColetaState();
			states[ST_MUNDO] = MundoState.getInstance();
			states[ST_SETEERROS] = new SeteErrosState();
			states[ST_QUEBRACABECA] = new QuebraCabecaState();
			states[ST_CACAPALAVRAS] = new CacaPalavrasState();
			states[ST_PAUSE] = new PauseState();
			
			/* Seta estado inicial. */
			//setState(ST_MUNDO);
			//setState(ST_COLETA);
			//setState(ST_SETEERROS);
			setState(ST_QUEBRACABECA);
			//setState(ST_CACAPALAVRAS);
		}
		
		/**
		 * Retorna a instância única deste singleton.
		 */
		public static function getInstance() : GameState{
			return instance;
		}
		
		/**
		 * Altera o estado atual para o estado dado.
		 * 
		 * @param state o novo estado, que dever ser uma das constantes
		 * de sub-estado.
		 */
		public static function setState(state : int){
			
			var prev : State = currentState;
			if (prev != null) {
				trace("leave no: "+currentState);
				prev.leave();
			}
			
			if((state == beforePauseConst) || (state == ST_MUNDO)){
				/* Esta saindo do pause: ou voltando pro anterior ou voltando
				pro MundoState */
				beforePauseConst = -1;
			}
			
			if (state == ST_PAUSE){
				beforePause = currentState;
			}else{
				beforePauseConst = state;
			}
			
			currentState = states[state];
			currentState.assume(prev);
		}
		
		/* Override. */
		public override function assume(previousState:State){
			mainInstance.stage.addChild(this.root);
		}
		
		public static function reassume(previousState:State){
			currentState = previousState;
		}
		
		/* Override. */
		public override function enterFrame(e : Event){
			currentState.enterFrame(e);			
		}
		
		/* Override. */
		public override function leave(){	
		}
		
		/* Funções da Interface de Programação */		
		/**
		 * Anima o personagem com a animação contida em determinado frame
		 * (necessário saber, a partir do .fla, em qual frame começa cada animação).
		 * 
		 * @param Frame inicial de cada animação
		 */ 
		public static function animCharacter(frame:int){
			/* Esta função eh simples. Soh pegar o movieclip do personagem (coruja)
			que estará na Barra Superior do jogo, e dar um play nesse movieClip para
			determinado frame. Mas precisa da barra inicial, e do movieClip da coruja no .fla */
		}
		
		/** 
		 * Monta uma caixa de diálogo com uma mensagem.
		 * 
		 * @param Mensagem que será escrita na caixa de diálogo
		 * @return O DisplayObject da caixa com a mensagem
		 */
		public function writeMessage(msg:String, pos:Point, hasOk:Boolean, 
		okText:String, hasCancel:Boolean, cancelText:String, willVanish:Boolean):Message{
			var msgAux : Message = new Message(msg, pos, hasOk, okText, hasCancel, cancelText, willVanish, root);
			return(msgAux);
			
			
		}
	}
}
