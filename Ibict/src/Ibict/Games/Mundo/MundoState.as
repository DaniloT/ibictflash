package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.Music.MusicController;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * Sub-estado da classe GameState que controla o "mundo" do jogo, dando acesso
	 * aos locais que podem ser acessados pelo jogador e, consequentemente, aos
	 * mini-jogos.
	 * 
	 * @author Luciano Santos
	 */
	public class MundoState extends State{
		/* Define de quanto vai ser a variação da música
		 * a cada clique que o jogador der para mudar o volume
		 */
		private const MUSIC_VARIATION : Number = 0.1;
		
		/* Indicam se determinado local está acessível ou não.
		 * Os locais se tornam acessíveis conforme o jogador vai ganhando estrelas.
		 */
		private var escolaDesbloqueada : Boolean = false;
		private var parqueDesbloqueado : Boolean = false;
		private var cooperativaDesbloqueada : Boolean = false;
		private var fabricaDesbloqueada : Boolean = false;
		
		
		private static var instance : MundoState;
		
		private var locales : Array;
		private var mainInstance : Main;
		private var mainStage : Stage;
		private var gameStateInstance : GameState;
		
		private var musica : Music;
		
		private var musicControllerInstance : MusicController = MusicController.getInstance();
		
		private var totalEstrelas : MundoTotalEstrelas = new MundoTotalEstrelas();

		/**
		 * Cria novo Mundo.
		 */
		public function MundoState(){
			super();
			
			totalEstrelas.x = 630;
			totalEstrelas.y = 540;
			
			root = new MovieClip();
			mainInstance = Main.getInstance();
			mainStage = mainInstance.stage;
			gameStateInstance = GameState.getInstance();
			
			root.addChild(new Bitmap(new mndFundo(0, 0)));
			
			locales = new Array();
			
			var icons : Array = [new mndEscola(), new mndErros(), new mndCooperativa(),
				new mndColeta()];
			var pos : Array = [new Point(700, 257), new Point(367, 250), new Point(597, 355), new Point(433, 4)];
			var states : Array = [GameState.ST_ESCOLA, GameState.ST_ERROS, GameState.ST_SELECAO_COOPERATIVA,
				GameState.ST_SELECAO_FASES];
			
			for (var i : int  = 0; i < icons.length; i++) {
				pushLocale(icons[i], pos[i].x, pos[i].y, states[i]);
			}

			for each (var locale : Locale in locales) {
				locale.icon.addEventListener(MundoIcon.CLICKED, iconClicked);
				root.addChild(locale.icon);
			}
			
			root.addChild(totalEstrelas);
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
			for (i = 0; (i < locales.length) && (locales[i].icon != e.icon);){
				i++; //era um empty statemente, mas o flash reclamou
			}
			
			/*TODO: Não deixar entrar no jogo cujo icone foi clicado caso
			 * a variavel 'local'Desbloqueado esteja como false.*/ 
			GameState.setState(locales[i].state);
		}
		
		
		
		public override function assume(previousState : State){
			//Salva o jogo sempre que entrar no Mundo
			GameState.profile.save();
			
			totalEstrelas.txt.text = GameState.profile.getTotalStarCount().toString();
			
			musica = new Music(new MusicaMundo, false, 20);
			
			if (previousState != null){
				//mainStage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			mainStage.addChild(root);
			gameStateInstance.addGraphics(root);
			
			gerenciaDesbloqueio();
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e : Event){
			for each (var locale : Locale in locales) {
				locale.icon.update(e);
			}
			
			if (InputManager.getInstance().kbClick(Keyboard.UP)) {
				musicControllerInstance.changeMusicVolume(MusicController.musicVolume + MUSIC_VARIATION);				
				musicControllerInstance.changeEffectVolume(MusicController.musicVolume + MUSIC_VARIATION);
			}
			if (InputManager.getInstance().kbClick(Keyboard.DOWN)) {
				musicControllerInstance.changeMusicVolume(MusicController.musicVolume - MUSIC_VARIATION);				
				musicControllerInstance.changeEffectVolume(MusicController.musicVolume + MUSIC_VARIATION);
			}
			
			if (InputManager.getInstance().kbClick(Keyboard.SHIFT)) {
				Main.getInstance().setState(Main.ST_MENU);
			}
		}
		
		private function gerenciaDesbloqueio(){
			var estrelas : int;
			estrelas = GameState.profile.getTotalStarCount();
			
			/* Ok. Vai vários if's não encadeados pq tah mto calor
			pra eu pensar num algoritmo mais eficiente. */ 
			if (estrelas >= 1){
				escolaDesbloqueada = true;
				/*TODO: Tira o icone preto e branco da escola */
			}
			if (estrelas >= 10){
				parqueDesbloqueado = true;
				/*TODO: Tira o icone preto e branco do parque */
			}
			if (estrelas >= 15){
				cooperativaDesbloqueada = true;
				/*TODO: Tira o icone preto e branco da cooperativa */
			}
			if (estrelas >= 18){
				fabricaDesbloqueada = true;
				/*TODO: Tira o icone preto e branco da fabrica */
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
