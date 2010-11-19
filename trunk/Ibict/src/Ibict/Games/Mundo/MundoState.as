package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.Music.MusicController;
	import Ibict.Profile.Profile;
	import Ibict.States.GameState;
	import Ibict.States.Message;
	import Ibict.States.State;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private static var instance : MundoState;
		
		private var locales : Array;
		private var mainInstance : Main;
		private var mainStage : Stage;
		private var gameStateInstance : GameState;
		
		private var musica : Music;
		
		private var msg : Message;
		
		private var musicControllerInstance : MusicController = MusicController.getInstance();
		
		private var totalEstrelas : MundoTotalEstrelas = new MundoTotalEstrelas();
		
		private var fundo_root : Sprite;
		private var fundo_atual : Bitmap;
		private var fundos : Array;

		/**
		 * Cria novo Mundo.
		 */
		public function MundoState(){
			super();
			
			fundos = [
				new Bitmap(new mndFundo1(0, 0)),
				new Bitmap(new mndFundo2(0, 0)),
				new Bitmap(new mndFundo3(0, 0)),
				new Bitmap(new mndFundo4(0, 0)),
				new Bitmap(new mndFundo5(0, 0)),
				new Bitmap(new mndFundo6(0, 0))
			];

			totalEstrelas.x = 630;
			totalEstrelas.y = 540;
			
			root = new MovieClip();
			mainInstance = Main.getInstance();
			mainStage = mainInstance.stage;
			gameStateInstance = GameState.getInstance();
			
			fundo_atual = fundos[0];
			fundo_root = new Sprite();
			fundo_root.addChild(fundo_atual);
			root.addChild(fundo_root);

			locales = new Array();
			
			/* Para um ícone começar desabilitado, mude de "true" para false e vice-versa. */
			var icons : Array = [
				new MundoIcon(
					new Bitmap(new mndEscolaEnabled(0,0)), new Bitmap(new mndEscolaDisabled(0,0)), true),
				new MundoIcon(
					new Bitmap(new mndErrosEnabled(0,0)), new Bitmap(new mndErrosDisabled(0,0)), true),
				new MundoIcon(
					new Bitmap(new mndCoopEnabled(0,0)), new Bitmap(new mndCoopDisabled(0,0)), true),
				new MundoIcon(
					new Bitmap(new mndFabEnabled(0,0)), new Bitmap(new mndFabDisabled(0,0)), true),
				new MundoIcon(
					new Bitmap(new mndColetaEnabled(0, 0)), new Bitmap(new mndColetaDisabled(0, 0)), true)];

			var pos : Array = [new Point(700, 257), new Point(367, 250), new Point(597, 355),
				new Point(-52, 22), new Point(433, 4)];

			var stars : Array = [4, 0, 1, 18, 13];

			var msgs : Array = [
				"Aprenda de onde vêm os produtos e conceitos sobre o meio ambiente.",
				"Em cada cômodo da casa, encontre os erros relacionados ao desperdício de recursos naturais.",
				"Reutilize lixo para montar brinquedos.",
				"Monte o ciclo de vida dos produtos usando seus conhecimentos sobre os seis êrres.",
				"Ajude a manter o parque um local limpo juntando o lixo dele e depois separando o material reciclável."];

			var states : Array = [GameState.ST_ESCOLA, GameState.ST_ERROS, GameState.ST_SELECAO_COOPERATIVA,
				GameState.ST_FABRICA, GameState.ST_SELECAO_FASES];
			
			for (var i : int  = 0; i < icons.length; i++) {
				pushLocale(icons[i], pos[i].x, pos[i].y, stars[i], msgs[i], states[i]);
			}

			for each (var locale : Locale in locales) {
				locale.icon.addEventListener(MundoIcon.ICON_CLICKED, iconClicked);
				locale.icon.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				locale.icon.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
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
		
		
		
		private function pushLocale(
				locale : MundoIcon, x : int, y : int, stars : int, msg : String, state : int) {

			locale.x = x;
			locale.y = y;
			locales.push(new Locale(locale, state, stars, msg));
		}
		
		private function iconClicked(e : MundoIconEvent) {
			var i : int;
			for (i = 0; (i < locales.length) && (locales[i].icon != e.icon);){
				i++;
			}

			GameState.setState(locales[i].state);
		}		


		public override function assume(previousState : State){
			//Salva o jogo sempre que entrar no Mundo
			GameState.profile.save();
			
			totalEstrelas.txt.text = GameState.profile.getTotalStarCount().toString();
			
			musica = new Music(new MusicaMundo, false, 20);
			if(!gameStateInstance.getGraphicsRoot().contains(this.root)){
                gameStateInstance.addGraphics(this.root);
   			}
   			
			if (previousState != null){
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			/* Desbloqueia os lugares. */
			gerenciaDesbloqueio();
			
			/* Define o fundo. */
			var prof : Profile = GameState.profile;
			var estrelas : Array = [
				prof.errosData.getStarCount(),
				prof.cooperativaData.getStarCount(),
				prof.cacaPalavrasData.getStarCount() + prof.memoriaData.getStarCount() + prof.quebraCabecaData.getStarCount(),
				prof.selecaoColetaData.getStarCount(),
				prof.fabricaData.getStarCount()
			];
			
			var new_fundo : Bitmap = fundos[0];
			for (var i : int = 0; i < estrelas.length; ++i) {
				if (estrelas[i] > 0) {
					new_fundo = fundos[i + 1]
				}
			}
			
			if (new_fundo != fundo_atual) {
				fundo_root.removeChild(fundo_atual);
				fundo_root.addChild(new_fundo);
				fundo_atual = new_fundo;
			}
		}

		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e : Event){
			for each (var locale : Locale in locales) {
				locale.icon.update(e);
			}
			
			//Mudar o volume
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
		
		//Destroi a mensagem quando o mouse sai de cima de um lugar
		private function mouseOut(evt:MouseEvent){
			if (msg != null){
				msg.destroy();
			}
		}
		
		//Mostra a mensagem de explicação da coruja quando passa o mouse em cima de um lugar
		private function mouseOver(e : MouseEvent){
			var i : int;
			for (i = 0; (i < locales.length) && (locales[i].icon != e.target); ){
				i++;
			}
			var locale : Locale = locales[i];
			var estrelas : int = GameState.profile.getTotalStarCount();
			var msg_text : String;

			if (locale.stars_needed <= estrelas) {
				msg_text = locale.msg;
			}
			else {
				msg_text = "Este local está bloqueado. Para desbloqueá-lo, consiga " + locale.stars_needed + " estrelas.";
			}
			
			this.msg = gameStateInstance.writeMessage(msg_text, new Point(0, 150), false, "", false, "", false);
		}

		private function gerenciaDesbloqueio(){
			var estrelas : int = GameState.profile.getTotalStarCount();
			
			/* Verifica todos os ícones... */
			for (var i : int = 0; i < locales.length; i++) {
				locales[i].icon.active = (locales[i].stars_needed <= estrelas);
			}
		}
	}
}

import Ibict.Games.Mundo.MundoIcon;

internal class Locale {
	public var icon : MundoIcon;
	public var state : int;
	public var stars_needed : int;
	public var msg : String;
	
	public function Locale(icon : MundoIcon, state : int, stars : int, msg : String) {
		this.icon = icon;
		this.state = state;
		this.stars_needed = stars;
		this.msg = msg;
	}
}
