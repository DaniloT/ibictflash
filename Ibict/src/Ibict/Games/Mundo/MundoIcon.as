package Ibict.Games.Mundo
{
	import Ibict.CubicInterpolator;
	import Ibict.InputManager;
	import Ibict.Interpolator;
	import Ibict.Texture;
	import Ibict.Updatable;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Um ícone (para um lugar) do mundo que pode ser selecionado pelo jogador.
	 * 
	 * Quando um ícone está ativo (o jogador está com o mouse em cima dele),
	 * ele fica crescendo e diminuindo.
	 */
	public class MundoIcon extends Texture implements Updatable
	{
		//total de frames para a animação de crescer/diminuir o ícone, quando ativo
		private static const FRAME_COUNT : int = 30;
		
		//as escalas mínima e máxima a ser atingida pelo ícone
		private static const MIN_SCALE : Number = 1.0;
		private static const MAX_SCALE : Number = 1.2;
		
		private var input : InputManager;
		private var isActive : Boolean;
		private var inter : Interpolator;
		private var curFrame : int;
		
		/**
		 * Cria um novo ícone, que vai ser linkado com o gráfico no flash.
		 */
		public function MundoIcon() {
			input = InputManager.getInstance();
			isActive = false;
			//inter = new LinearInterpolator();
			inter = new CubicInterpolator();
		}
		
		public function update(e : Event) {
			var mousePoint : Point = input.getMousePoint();
			var wasActive : Boolean = isActive;
			
			isActive = hitTestPoint(mousePoint.x, mousePoint.y, true);
			
			if (input.isMouseDown()) {
				if (isActive)
					MundoState.getInstance().iconClicked(this);
				else
					resize();
			}
			else {
				if (isActive && !wasActive)
					inter.begin(MIN_SCALE, MAX_SCALE, FRAME_COUNT / 2);				
				resize();
			}
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
	}
}
