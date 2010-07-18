package Ibict.Games.Fabrica
{
	import Ibict.States.State;

	/**
	 * Classe principal do jogo da Fábrica, modela um State de GameState.
	 * 
	 * @author Luciano Santos
	 */
	public class FabricaState extends State
	{
		public function FabricaState()
		{
			super();
		}
		
		/* Override */
		public function assume(previousState : State)
		{
		}
		
		/* Override */
		public function reassume(previousState : State){
			
		}
		
		/* Override */
		public function leave()
		{	
		}
		
		/* Override */
		public function enterFrame(e : Event)
		{	
		}
	}
}
