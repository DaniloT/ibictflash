package Ibict.Games.Mundo
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
		
		/**
		 * Cria novo Mundo.
		 */
		public function MundoState()
		{
			super();
			root = new MovieClip();
			locales = new Array();
			mainInstance = Main.getInstance();
			
			locales.push(new Casa());
			for each (var m : MundoIcon in locales) {
				root.addChild(m);
			}
		}
		
		public override function assume(previousState : State)
		{
			locales[0].x = mainInstance.stage.width / 2;
			locales[0].y = mainInstance.stage.width / 2;
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			mainInstance.stage.addChild(root);
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
	}
}
