package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Updatable;
	import Ibict.Util.CubicInterpolator;
	import Ibict.Util.Interpolator;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Um ícone (para um lugar) do mundo que pode ser selecionado pelo jogador.
	 * 
	 * Quando um ícone está ativo (o jogador está com o mouse em cima dele),
	 * ele fica crescendo e diminuindo.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see MundoState
	 */
	public class MundoIcon extends Sprite implements Updatable
	{
		public static const CLICKED : String = "iconClicked";
		
		
		//total de frames para a animação de crescer/diminuir o ícone, quando ativo
		private static const FRAME_COUNT : int = 30;
		
		//as escalas mínima e máxima a ser atingida pelo ícone
		private static const MIN_SCALE : Number = 1.0;
		private static const MAX_SCALE : Number = 1.2;
		
		private var input : InputManager;
		private var isActive : Boolean;
		private var inter : Interpolator;
		
		/**
		 * Cria um novo ícone, que vai ser linkado com o gráfico no flash.
		 */
		public function MundoIcon() {
			input = InputManager.getInstance();
			isActive = false;
			inter = new CubicInterpolator();
		}
		

		
		private function resize() {
			if (isActive) {
				if (inter.hasEnded()) {
					inter.swap()
					inter.reset();
					inter.next();
				}
				this.scaleX = this.scaleY = inter.next();
			}
			else
				this.scaleX = this.scaleY = 1.0;
		}
		
		
		/* Override. */
		public function update(e : Event) {
			var mousePoint : Point = input.getMousePoint();
			var wasActive : Boolean = isActive;
			
			isActive = hitTestPoint(mousePoint.x, mousePoint.y, true);
			
			if (input.isMouseDown()) {
				if (isActive)
					dispatchEvent(new MundoIconEvent(this, CLICKED));
				else
					resize();
			}
			else {
				if (isActive && !wasActive)
					inter.begin(MIN_SCALE, MAX_SCALE, FRAME_COUNT / 2);				
				resize();
			}
		}
	}
}
