package Ibict.States
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Modela um estado genérico, que pode ser usado por qualquer máquina de estados.
	 * 
	 * Um estado teoricamente tem controle total do jogo, mas as transições de um
	 * estado para outro devem ser realizadas por uma <i>máquina de estados</i>
	 * específica.
	 * 
	 * Supondo-se que estamos no estado X e, em algum ponto desejamos mudar para o estado
	 * Y, uma máquina de estados correta deveria realizar as seguintes operações:
	 * 
	 * - enquanto X está ativo, a cada atualização, deve-se chamar o método <code>enterFrame</code>;
	 * - quando X solicita a mudança para o estado Y, a máquina chamará o método <code>leave</code>
	 * de X e, ao transitar para Y, chamar o método <code>enter</code> de Y;
	 * - o estado Y passa a ficar ativo e o ciclo se repete;
	 * 
	 * @author Luciano Santos
	 * @author Bruno Zumba
	 */
	public class State
	{
		/** A raiz da árvore de gráficos do estado. */
		protected var root : MovieClip;
		
		/**
		 * Instancia um novo estado.
		 * 
		 * Idealmente, todo estado é único e, portanto, deveria ser um <i>singleton</i>.
		 */
		public function State()
		{
			root = null;
		}
		
		/**
		 * Chamado quando o estado atual deve assumir controle do jogo.
		 * 
		 * @param previousState o estado anteriormente ativo, que pode ser null.
		 */
		public function assume(previousState : State)
		{
		}
		
		/**
		 * Chamado quando o estado atual deve deixar de ser o estado ativo.
		 */
		public function leave()
		{	
		}
		
		/**
		 * Chamado a cada atualização de frame, permitindo ao estado atualizar
		 * seus gráficos.
		 * 
		 * @param e o evento de atualização de frame.
		 */
		public function enterFrame(e : Event)
		{	
		}
		
		/**
		 * Retorna a raiz da árvore de gráficos.
		 */
		public function getGraphicsRoot() : DisplayObject
		{
			return root;
		}
	}
}
