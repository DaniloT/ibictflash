package Ibict.Util
{
	import Ibict.InputManager;
	import Ibict.Updatable;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Classe base que faz um DisplayObject qualquer se comportar como um botão.
	 * 
	 * Esse botão, obviamente, só funcionará quando estiver na árvore de gráficos
	 * do Flash, ou seja, esteja visível.
	 * 
	 * É possível ativar e desativar o botão: quando desativado, ele não dispara o
	 * evento de clique, mesmo que esteja visível na tela. Além disso, pode-se fornecer
	 * uma imagem para o estado ativado e outra para desativado.
	 * 
	 * Para capturar o evento do clique, utiliza normalmente <code>addEventListener</code>,
	 * com tipo CLICKED.
	 * 
	 * @author Luciano Santos
	 */
	public class Button extends MovieClip implements Updatable
	{
		public static var CLICKED : String = "buttonClicked";
		
		private var input : InputManager;
		private var img_act : DisplayObject;
		private var img_deact : DisplayObject;
		private var _active : Boolean;
		
		/**
		 * Cria um novo botão.
		 * 
		 * @param activ_img a imagem do botão, quando ativo.
		 * @param deactiv_img a imagem do botão, quando desativado; se for null,
		 * será usada activ_img.
		 */
		public function Button(activ_img : DisplayObject, deactiv_img : DisplayObject = null)
		{
			super();
			
			if (deactiv_img == null) deactiv_img = activ_img;
			
			this.input = InputManager.getInstance();
			this.img_act = activ_img;
			this.img_deact = deactiv_img;
			this.addChild(img_act);
			this._active = true;
		}
		
		/**
		 * Define se o botão está ativo ou não.
		 */
		public function get active() : Boolean {
			return this._active;
		}
		
		/**
		 * Ativa ou desativa o botão.
		 */
		public function set active(value : Boolean) {
			if (value != this._active) {
				if (this._active) {
					this.removeChild(img_act);
					this.addChild(img_deact);
				}
				else {
					this.removeChild(img_deact);
					this.addChild(img_act);
				}
				
				this._active = value;
			}
		}
		
		/**
		 * Retorna a imagem a ser utilizada com o botão ativado.
		 */
		public function get activatedImage() : DisplayObject {
			return img_act;
		}
		
		/**
		 * Seta a imagem a ser utilizada com o botão ativado.
		 */
		public function set activatedImage(value : DisplayObject) {
			var prev : DisplayObject = this.img_act;
			this.img_act = value;
			
			if (this.active) {
				this.removeChild(prev);
				this.addChild(img_act);
			}
		}
		
		/**
		 * Retorna a imagem a ser utilizada com o botão desativado.
		 */
		public function get deactivatedImage() : DisplayObject {
			return img_deact;
		}
		
		/**
		 * Seta a imagem a ser utilizada com o botão desativado.
		 */
		public function set deactivatedImage(value : DisplayObject) {
			if (value == null) value = img_act;
			
			var prev : DisplayObject = this.img_deact;
			this.img_deact = value;
				
			if (!this.active) {
				this.removeChild(prev);
				this.addChild(img_deact);
			}
		}
		
		/* Override. */
		public function update(e : Event) {
			if (this.active) {
				if (input.mouseClick()) {
					var p : Point = input.getMousePoint();
					
					if (img_act.hitTestPoint(p.x, p.y, true))
						dispatchEvent(new ButtonEvent(this, CLICKED));
				}
			}
		}
	}
}
