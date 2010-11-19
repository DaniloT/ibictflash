package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Updatable;
	import Ibict.Util.Button;
	import Ibict.Util.CubicInterpolator;
	import Ibict.Util.Interpolator;
	
	import flash.display.DisplayObject;
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
	public class MundoIcon extends Button
	{
		public static const ICON_CLICKED : String = "iconClicked";
		
		
		//total de frames para a animação de crescer/diminuir o ícone, quando ativo
		private static const FRAME_COUNT : int = 30;
		
		//as escalas mínima e máxima a serem atingidas pelo ícone
		private static const MIN_SCALE : Number = 1.0;
		private static const MAX_SCALE : Number = 1.2;


		private var input : InputManager;
		private var isMouseOver : Boolean;
		private var inter : Interpolator;
		private var refCenter : Point;
		

		override public function set x(value:Number) : void {
			super.x = value;
			if (!isMouseOver)
				refCenter.x = this.x + this.width / 2;
		}

		override public function set y(value:Number) : void {
			super.y = value;
			if (!isMouseOver)
				refCenter.y = this.y + this.height / 2;
		}

		/**
		 * Cria um novo ícone, que vai ser linkado com o gráfico no flash.
		 */
		public function MundoIcon(
				en_icon : DisplayObject, dis_icon : DisplayObject,
				active : Boolean = true) {
			
			super(en_icon, dis_icon);

			input = InputManager.getInstance();
			isMouseOver = false;
			inter = new CubicInterpolator();
			refCenter = new Point();
			this.y = 0;
			
			this.active = active;
		}

		private function resize() {
			if (isMouseOver) {
				if (inter.hasEnded()) {
					inter.swap()
					inter.reset();
					inter.next();
				}
				this.scaleX = this.scaleY = inter.next();				
			}
			else
				this.scaleX = this.scaleY = 1.0;

			this.x = refCenter.x - this.width / 2;
			this.y = refCenter.y - this.height / 2;
		}


		/* Override. */
		public override function update(e : Event) {
			super.update(e);
			if (active) {
				var mousePoint : Point = input.getMousePoint();
				var wasActive : Boolean = isMouseOver;
				
				isMouseOver = hitTestPoint(mousePoint.x, mousePoint.y, true);
				
				if (input.isMouseDown()) {
					if (isMouseOver)
						dispatchEvent(new MundoIconEvent(this, ICON_CLICKED));
					else
						resize();
				}
				else {
					if (isMouseOver && !wasActive)
						inter.begin(MIN_SCALE, MAX_SCALE, FRAME_COUNT / 2);
					resize();
				}
			}
		}
	}
}
