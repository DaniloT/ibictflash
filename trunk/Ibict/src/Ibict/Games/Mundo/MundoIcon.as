package Ibict.Games.Mundo
{
	import Ibict.InputManager;
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
		private static const FRAME_COUNT : int = 20;
		
		//a escala máxima a ser atingida pelo ícone
		private static const MAX_SCALE : Number = 1.5;
		
		private var input : InputManager;
		private var isActive : Boolean;
		private var curFrame : int;
		
		/**
		 * Cria um novo ícone, que vai ser linkado com o gráfico no flash.
		 */
		public function MundoIcon() {
			input = InputManager.getInstance();
			isActive = false;
		}
		
		public function update(e : Event) {
			var wasActive : Boolean = isActive;
			var mousePoint : Point = input.getMousePoint();
			
			isActive = input.mouseClick() && hitTestPoint(mousePoint.x, mousePoint.y, true);
			
			if (isActive) {
				curFrame = ++curFrame % FRAME_COUNT;
				resize();
			}
			else {
				curFrame = 0;
				if (wasActive) {
					resize();
				}
			}
		}
		
		private function resize() {
			var ds : Number = MAX_SCALE - 1.0;
			var half_fc : int = FRAME_COUNT / 2;
			var k : int;
			var scale : Number;
			
			//se for a primeira metade, cresce, senão, diminui
			k = (curFrame < half_fc) ? curFrame : half_fc - (FRAME_COUNT - curFrame);
			
			//nova escala para o objeto
			scale = (ds * (k + 1)) / half_fc;
			
			this.scaleX = this.scaleY = scale;
		}
	}
}
