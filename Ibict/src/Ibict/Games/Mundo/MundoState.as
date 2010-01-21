package Ibict.Games.Mundo
{
	import Ibict.States.State;

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
		
		public function assume(previousState : State)
		{
		}
		
		public function leave()
		{	
		}
		
		public function enterFrame(e : Event)
		{	
		}
		
		public function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
	}
}
