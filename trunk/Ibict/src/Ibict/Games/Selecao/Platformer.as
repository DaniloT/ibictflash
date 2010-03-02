package Ibict.Games.Selecao
{
	import Ibict.InputManager;
	import Ibict.Texture;
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	public class Platformer extends MovieClip
	{
		var px : int, py : int;
		var vx : Number, vy : Number;
		var cenario : Texture;
		var gravidade : int;
		var staticBall : Texture;
		var bola2 : Texture;
		var inputManager : InputManager;
		var tempoPulo : Timer;
		var colisores : Colisores;

		
		
				
		public function Platformer()
		{
			/* instanciando objetos e setando variaveis principais */
			gravidade = 1;
			staticBall = new selectSB();
			staticBall.x = 0;
			staticBall.y = 0;
			
			px = 0;
			py = 0;
			vx = 0;
			vy = 0;
			
			bola2 = new selectSB();
			this.addChild(staticBall);
			this.addChild(bola2);
			
			/* inicializando o timer do pulo */
			tempoPulo = new Timer(10);
			
			/* inicializando o inputManager */
			inputManager = InputManager.getInstance();
			
			/* inicializando o cenario */
			cenario = new selectStage1();
			this.addChild(cenario);
			
			
			/* inicializando os colisores */
			colisores = new Colisores(cenario, this);
		}
				
		private function detectaColisao(): Boolean {
			
			return false;
		}
		
		private function updatePhysics() {
			
			/* aplicando tudo que fara o personagem se mover */
			var count : int;
			
			if(!colisores.detectaColisaoBaixo()) {
				vy += gravidade;
			} else {
				vy = 0;
				
				
				/*aplicando controle do pulo */
				if(inputManager.isDown(Keyboard.UP)) {
					tempoPulo.start();
					trace(tempoPulo.currentCount);
					if(tempoPulo.currentCount < 20) {
						vy = -10;
						py -= 2;
					}
					
					
				} else {
					tempoPulo.reset();
					tempoPulo.stop();
				}
			}		
			
			px += vx;
			py += vy;	
			
			if(staticBall.pixelCollidesWith(cenario)) {
				trace("lol");
			}
			
			
			
			if(inputManager.isDown(Keyboard.RIGHT)) {
				vx = 5;
			} else if(inputManager.isDown(Keyboard.LEFT)) {
				vx = -5;
			} else {
				vx = 0;
			}
			
			colisores.updatePhysics();
			
			
			/* da um update render de novo */
			colisores.colisorMenosBaixo.avanca(vx, vy);
			
						
			
			
			while(colisores.detectaColisaoMenosBaixo()) {
				py--;
				colisores.updatePhysics();
				colisores.updateRender();
			}
			colisores.colisorMenosBaixo.retorna();
			
			
			
			
			
			
			
		}
		
		private function updateRenders() {
			staticBall.x = px;
			staticBall.y = py;
			colisores.updateRender();
		}
		
		public function update() {
			updateRenders();
			updatePhysics();			
			
		}

	}
}