package Ibict.Games.Mundo
{
	import Ibict.States.State;
	
	import flash.display.DisplayObject;
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
		/**
		 * Cria novo Mundo.
		 */
		public function MundoState()
		{
			super();
		}
		
		public override function assume(previousState : State)
		{
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{	
		}
		
		public override function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
	}
}
