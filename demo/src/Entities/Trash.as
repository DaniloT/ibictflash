package Entities
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Trash extends Sprite
	{
		protected var velocidadeMax : Number = 0;
		private var velocidade : Point;
		protected var inputManager : InputManager;
		protected var graph:Sprite; /*Armazena a imagem do lixo*/
		
		// dragDiff - diferença do ponteiro do mouse até a 
		//            posição 0,0 de um movieClip clicado.
		private var dragDiff : Point;
		
		
		public function Trash(randomY:Boolean)
		{
			this.x = Math.floor((Math.random() * (Main.stage_g.stageWidth-300)) + 100);
			this.y = randomY ? Math.floor(Math.random() * -300) : -50;	
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

		public function toBeRemoved():Boolean{
			return(this.y > Main.stage_g.stageHeight);
		}
	}
}
