package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	/**
	 * Sub-estado da classe GameState que controla o "mundo" do jogo, dando acesso
	 * aos locais que podem ser acessados pelo jogador e, consequentemente, aos
	 * mini-jogos.
	 * 
	 * @author Luciano Santos
	 */
	public class MundoState extends State
	{
		private static var instance : MundoState;
		
		private var locales : Array;
		private var mainInstance : Main;
		private var mainStage : Stage;
		private var gameStateInstance : GameState;
		
		private var musica : Music;
				
		
		/**
		 * Cria novo Mundo.
		 */
		public function MundoState()
		{
			super();
			
			
			
			root = new MovieClip();
			mainInstance = Main.getInstance();
			mainStage = mainInstance.stage;
			gameStateInstance = GameState.getInstance();
			
			root.addChild(new Bitmap(new mndFundo(0, 0)));
			
			locales = new Array();
			
			var icons : Array = [new mndCaca(), new mndQuebra(), new mndSete(), new mndColeta(),
				new mndMemoria(), new mndCooperativa()];
			var states : Array = [GameState.ST_SELECAO_CACA, GameState.ST_QUEBRACABECA, GameState.ST_ERROS,
				GameState.ST_SELECAO_FASES, GameState.ST_SELECAO_MEMORIA, GameState.ST_SELECAO_COOPERATIVA];
			
			for (var i : int  = 0; i < icons.length; i++) {
				var x : Number = Math.cos(2 * Math.PI * i / icons.length) * 200 + mainStage.stageWidth / 2;
				var y : Number = Math.sin(2 * Math.PI * i / icons.length) * 200 + mainStage.stageHeight / 2;
				pushLocale(icons[i], x, y, states[i]);
			}
			
			for each (var locale : Locale in locales) {
				locale.icon.addEventListener(MundoIcon.CLICKED, iconClicked);
				root.addChild(locale.icon);
			}
		}
		
		/**
		 * Retorna a instância de MundoState.
		 * 
		 * Esse método deve ser o único utilizado para obter uma instância de MundoState,
		 * já que essa classe é um singleton.
		 */
		public static function getInstance() : MundoState {
			if (instance == null)
				instance = new MundoState();
			
			return instance;
		}
		
		
		
		private function pushLocale(locale : MundoIcon, x : int, y : int, state : int) {
			locale.x = x;
			locale.y = y;
			locales.push(new Locale(locale, state));
		}
		
		private function iconClicked(e : MundoIconEvent) {
			var i : int;
			for (i = 0; (i < locales.length) && (locales[i].icon != e.icon);)
				i++; //era um empty statemente, mas o flash reclamou
			GameState.setState(locales[i].state);
		}
		
		
		
		public override function assume(previousState : State){
			musica = new Music(new MusicaMundo, false, 20);
			
			if (previousState != null){
				//mainStage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			mainStage.addChild(root);
			gameStateInstance.addGraphics(root);
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e : Event){
			if(InputManager.getInstance().kbClick(Keyboard.SPACE)){
				GameState.setState(GameState.ST_PAUSE);
			}
			for each (var locale : Locale in locales) {
				locale.icon.update(e);
			}
		}
	}
}

import Ibict.Games.Mundo.MundoIcon;

internal class Locale {
	public var icon : MundoIcon;
	public var state : int;
	
	public function Locale(icon : MundoIcon, state : int) {
		this.icon = icon;
		this.state = state;
	}
}
