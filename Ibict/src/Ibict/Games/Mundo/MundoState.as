package Ibict.Games.Mundo
{
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
		
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
		
		/**
		 * Cria novo Mundo.
		 */
		public function MundoState()
		{
			super();
			
			root = new MovieClip();
			mainInstance = Main.getInstance();
			mainStage = mainInstance.stage;
			
			locales = new Array();
			pushLocale(new Casa(), 50, 50, GameState.ST_COLETA);
			pushLocale(new Escola(), 300, 200, GameState.ST_SETEERROS);
			pushLocale(new Fabrica(), 500, 40, GameState.ST_MUNDO);
			for each (var locale : Locale in locales) {
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
		
		/**
		 * Chamado por instâncias de MundoIcon para informar que foram clicadas.
		 */
		public function iconClicked(icon : MundoIcon) {
			var i : int;
			for (i = 0; (i < locales.length) && (locales[i].icon != icon); i++);
			GameState.setState(locales[i].state);
		}
		
		public override function assume(previousState : State)
		{
			if (previousState != null){
				mainStage.removeChild(previousState.getGraphicsRoot());
			}
			mainStage.addChild(root);
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
			for each (var locale : Locale in locales) {
				locale.icon.update(e);
			}
		}
		
		public override function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
		
		private function pushLocale(locale : MundoIcon, x : int, y : int, state : int) {
			locale.x = x;
			locale.y = y;
			locales.push(new Locale(locale, state));
		}
	}
}
