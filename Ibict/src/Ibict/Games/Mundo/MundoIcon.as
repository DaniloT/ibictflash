package Ibict.Games.Mundo
{
	import Ibict.InputManager;
	import Ibict.Updatable;
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
	public class MundoIcon extends Sprite implements Updatable
	{
		public static const CLICKED : String = "iconClicked";
		
		
		//total de frames para a animação de crescer/diminuir o ícone, quando ativo
		private static const FRAME_COUNT : int = 30;
		
		//as escalas mínima e máxima a serem atingidas pelo ícone
		private static const MIN_SCALE : Number = 1.0;
		private static const MAX_SCALE : Number = 1.2;

		
		private var _enabled : Boolean;
		private var en_icon : DisplayObject;
		private var dis_icon : DisplayObject;
		private var input : InputManager;
		private var isActive : Boolean;
		private var inter : Interpolator;
		private var refCenter : Point;
		

		override public function set x(value:Number) : void {
			super.x = value;
			if (!isActive)
				refCenter.x = this.x + this.width / 2;
		}

		override public function set y(value:Number) : void {
			super.y = value;
			if (!isActive)
				refCenter.y = this.y + this.height / 2;
		}


		public function get enabled() : Boolean {
			return _enabled;
		}

		public function set enabled(value : Boolean) {
			if (_enabled != value) {
				_enabled = value;
				
				if (_enabled) {
					this.removeChild(dis_icon);
					this.addChild(en_icon);
				}
				else {
					this.removeChild(en_icon);
					this.addChild(dis_icon);
				}
			}
		}

		/**
		 * Cria um novo ícone, que vai ser linkado com o gráfico no flash.
		 */
		public function MundoIcon(
				en_icon : DisplayObject, dis_icon : DisplayObject,
				enabled : Boolean = true) {

			_enabled = true;
			this.addChild(en_icon);
			this.en_icon = en_icon;
			this.dis_icon = dis_icon;

			input = InputManager.getInstance();
			isActive = false;
			inter = new CubicInterpolator();
			refCenter = new Point();
			this.x = 0;
			this.y = 0;
			
			this.enabled = enabled;
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

			this.x = refCenter.x - this.width / 2;
			this.y = refCenter.y - this.height / 2;
		}


		/* Override. */
		public function update(e : Event) {
			if (enabled) {
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
}
