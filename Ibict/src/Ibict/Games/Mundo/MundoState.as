package Ibict.Games.Mundo
{
	import Ibict.Main;
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
			pushLocale(new Casa(), 50, 50);
			pushLocale(new Escola(), 300, 200);
			pushLocale(new Fabrica(), 500, 40);
			for each (var m : MundoIcon in locales) {
				root.addChild(m);
			}
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
			for each (var m : MundoIcon in locales) {
				m.update(e);
			}
		}
		
		public override function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
		
		private function pushLocale(locale : MovieClip, x : int, y : int) {
			locale.x = x;
			locale.y = y;
			locales.push(locale);
		}
	}
}
