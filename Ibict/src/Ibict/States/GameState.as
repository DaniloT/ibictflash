﻿package Ibict.States
{
	import Ibict.Games.CacaPalavras.CacaPalavrasState;
	import Ibict.Games.CacaPalavras.SeletorDificuldadeState;
	import Ibict.Games.Coleta.ColetaState;
	import Ibict.Games.Cooperativa.CooperativaMenuState;
	import Ibict.Games.Cooperativa.CooperativaState;
	import Ibict.Games.Erros.ErrosState;
	import Ibict.Games.Escola.EscolaState;
	import Ibict.Games.Fabrica.FabricaState;
	import Ibict.Games.Memoria.MemoriaMenuState;
	import Ibict.Games.Memoria.MemoriaState;
	import Ibict.Games.Mundo.MundoState;
	import Ibict.Games.QuebraCabeca.QuebraCabecaState;
	import Ibict.Games.Selecao.SelecaoState;
	import Ibict.Games.SeletorFases.SeletorFasesState;
	import Ibict.GraphicsHolder;
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.MusicController;
	import Ibict.Profile.Profile;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * Estado "Em Jogo" do jogo principal.
	 * 
	 * Esse estado também é ele mesmo uma máquina de estados, que alterna entre
	 * o mundo, os locais e os mini-jogos, que são sub-estados desse estado.
	 */
	public class GameState extends State implements GraphicsHolder	{		
		private static var mainInstance : Main;
		private static var input : InputManager;
		private static var currentState : State;
		private static var instance : GameState;
		
		private static var states : Array; /* Conjunto de estados do jogo. */
		
		public static var beforePause : State ;
		public static var beforePauseConst : int = -1;
		
		public static var profile : Profile = new Profile();
		
		private var msg : Array = new Array();
		
		/** Sub-estado do mundo. */
		public static const ST_MUNDO		: int = 0;
		/** Sub-estado do mini-jogo de coleta. */
		public static const ST_COLETA		: int = 1;
		/** Sub-estado do mini-jogo dos sete erros. */
		public static const ST_ERROS	: int = 2;
		/** Sub-estado do mini-jogo do quebra-cabeça. */
		public static const ST_QUEBRACABECA	: int = 3;
		/** Sub-estado do mini-jogo do caça-palavras. */
		public static const ST_CACAPALAVRAS	: int = 4;
		/** Estado "Em Pausa" */
		public static const ST_PAUSE	: int = 5;
		/** Sub-estado do mini-jogo da memoria. */
		public static const ST_MEMORIA	: int = 6;
		public static const ST_SELECAO : int = 7;
		public static const ST_SELECAO_FASES : int = 8;
		public static const ST_SELECAO_CACA : int = 9;
		public static const ST_COOPERATIVA : int = 10;
		public static const ST_SELECAO_MEMORIA : int = 11;
		public static const ST_SELECAO_COOPERATIVA : int = 12;
		public static const ST_ESCOLA : int = 13;
		public static const ST_FABRICA : int = 14;


		private var cursor : MovieClip;
		
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
			states[ST_ERROS] = new ErrosState();
			states[ST_QUEBRACABECA] = new QuebraCabecaState();
			states[ST_CACAPALAVRAS] = new CacaPalavrasState();
			states[ST_PAUSE] = new PauseState();
			states[ST_MEMORIA] = new MemoriaState();
			states[ST_SELECAO] = new SelecaoState();
			states[ST_SELECAO_FASES] = new SeletorFasesState();
			states[ST_SELECAO_CACA] = new SeletorDificuldadeState();
			states[ST_COOPERATIVA] = new CooperativaState();
			states[ST_SELECAO_MEMORIA] = new MemoriaMenuState();
			states[ST_SELECAO_COOPERATIVA] = new CooperativaMenuState();
			states[ST_ESCOLA] = new EscolaState();
			states[ST_FABRICA] = new FabricaState();
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
		
		public static function setColetaState(nro_lixos : int, pontuacao_inicial : int, nstage : int) {
			var coletaState : ColetaState;
			
			coletaState = states[ST_COLETA];
			
			coletaState.setNroLixos(nro_lixos);
			coletaState.addPontuacaoInicial(pontuacao_inicial);
			coletaState.setFase(nstage);
			setState(ST_COLETA);
		}
		
		public static function setSelecaoLevelState(level : int) {
			var selecaoState : SelecaoState;
			
			selecaoState = states[ST_SELECAO];
			
			selecaoState.setLevel(level);
			setState(ST_SELECAO);
		}
		
		public static function setCacaPalavrasState(nivel : int) {
			var cacaPalavrasState : CacaPalavrasState;
			
			cacaPalavrasState = states[ST_CACAPALAVRAS];
			
			cacaPalavrasState.setDificulty(nivel);
			setState(ST_CACAPALAVRAS);
		}
		
		public static function setMemoriaState(nivel : int) {
			var memoriaState : MemoriaState;
			
			memoriaState = states[ST_MEMORIA];
			
			memoriaState.setDificulty(nivel);
			setState(ST_MEMORIA);
		}
		
		public static function setCooperativaState(num : int) {
			var cooperativaState : CooperativaState;
			
			cooperativaState = states[ST_COOPERATIVA];
			
			cooperativaState.setImgNum(num);
			setState(ST_COOPERATIVA);
		}
		
		public static function setEscolaState(jogo : int) {
			if (jogo == 1) {
				setState(ST_SELECAO_CACA);
			} else {
				if (jogo == 2) {
					setState(ST_SELECAO_MEMORIA);
				} else {
					setState(ST_QUEBRACABECA);
				}
			}
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
			var msgAux : Message = new Message(msg, pos, hasOk, okText, hasCancel, 
												cancelText, willVanish, root, cursor);
			return(msgAux);
			
			
		}
		
		
		
		
		/* Override. */
		public override function assume(previousState:State){
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			setState(ST_MUNDO);
			mainInstance.stage.addChild(this.root);
		}
		
		public static function reassume(previousState:State){
			currentState = previousState;
		}
		
		/* Override. */
		public override function enterFrame(e : Event){
			//if (input.kbClick(Keyboard.SPACE)) {
			//	setState(ST_MUNDO);
			//}
						
			currentState.enterFrame(e);
		}
		
		/* Override. */
		public override function leave(){
			if (currentState != null){
				currentState.leave();
			}
			
		}
		
		/** Adiciona um movieclip para ser o mouse. */
		public function addMouse(cursor_p:MovieClip){
			cursor = cursor_p;
			root.addChild(cursor);
		}
		/** Retira o movieclip que representa o mouse. */
		public function removeMouse(){
			if((cursor != null) && (root.contains(cursor))){
				root.removeChild(cursor);
			}
			cursor = null;
		}
		
		/* Override. */
		public function addGraphics(g : DisplayObject) {
			if (!this.root.contains(g)){
				this.root.addChild(g);
				if(cursor!=null){
					this.root.swapChildren(g,cursor);
				}
			}
		}
		
		/* Override. */
		public function removeGraphics(g : DisplayObject) {
			if (this.root.contains(g))
				this.root.removeChild(g);
		}
		
		/* Função que seta o nível de "limpeza" da cidade
		 * baseado na quantidade de estrelas que o jogador coletou
		 *
		 * Função em desenvolvimento e ainda não é usada. by Zumba
		 */
		private function setaNivel(){
			
		}
		
	}
}
