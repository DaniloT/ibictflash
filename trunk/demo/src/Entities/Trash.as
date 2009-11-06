package Entities
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Trash extends Texture
	{
		public static const HMARGIN : int = 150;
		public static const VMARGIN : int = 300;
		
		protected var velocidadeMax : Number = 0;
		protected var inputManager : InputManager;
		protected var graph : Sprite; /*Armazena a imagem do lixo*/
		
		private var velocidade : Point;
		
		// dragDiff - diferença do ponteiro do mouse até a 
		//            posição 0,0 de um movieClip clicado.
		private var dragDiff : Point;
		
		
		public function Trash(randomY:Boolean)
		{
			var range : int = Main.stage_g.stageWidth - 2 * HMARGIN - width;
			
			this.x = Math.floor(Math.random() * range) + HMARGIN;
			this.y = -1 * (randomY ? Math.floor(Math.random() * VMARGIN) : this.height);	
			
			inputManager = InputManager.getInstance();
				
			dragDiff = new Point();		
			velocidade = new Point(0,0);		
		}

		public function update(e : Event)
		{			
			if(inputManager.mouseClick() && inputManager.getMouseTarget() == this) {
				dragDiff.x = Math.abs(inputManager.getMousePoint().x - this.x);
				dragDiff.y = Math.abs(inputManager.getMousePoint().y - this.y);
			}

			if(!(inputManager.isMouseDown() && inputManager.getMouseTarget() == this)) {
				if(velocidade.y < velocidadeMax) velocidade.y += 1;
				
				this.x += velocidade.x;
				
				this.y += velocidade.y;
			} else {
				velocidade.y = inputManager.getMouseVelocity().y*2;
				velocidade.x = inputManager.getMouseVelocity().x*2;
				this.x = inputManager.getMousePoint().x - dragDiff.x;
				this.y = inputManager.getMousePoint().y - dragDiff.y;
			}
		}

		public function toBeRemoved() : Boolean {
			return this.y > Main.stage_g.stageHeight;
		}
		
		public function getTargetBin() : int {
			return TrashTypesEnum.NOT_REC;
		}
	}
}
