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
		var bloqueiaPulo : Boolean;

		
		
				
		public function Platformer()
		{
			/* instanciando objetos e setando variaveis principais */
			gravidade = 1;
			staticBall = new selectSB();
			staticBall.x = 0;
			staticBall.y = 0;
			
			px = 3;
			py = 3;
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
			
			/* seta o bloqueiaPulo */
			bloqueiaPulo = false;
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
				vy = 2;
				tempoPulo.reset();
				tempoPulo.stop();
				bloqueiaPulo = false;
			}		
			
			/*aplicando controle do pulo */
			
			if(vy > 2) {
				tempoPulo.start();
				bloqueiaPulo = true;
			}
			
			if(inputManager.isDown(Keyboard.UP)) {
				tempoPulo.start();
				if(tempoPulo.currentCount < 20 && !bloqueiaPulo) {
					vy = -10;
					py -= 2;					
				}
				
				
			}
			
			

			if(colisores.detectaColisaoDir() || colisores.detectaColisaoEsq()) {
				vx = 0;
			}
			
			if(inputManager.isDown(Keyboard.RIGHT) && !colisores.detectaColisaoDir()) {
				vx = 5;
			} else if(inputManager.isDown(Keyboard.LEFT) && !colisores.detectaColisaoEsq()) {
				vx = -5;
			} else {
				vx = 0;
			}
			
			
			if(colisores.detectaColisaoCima() && vy < 0) {
				py -= vy;
				vy = 0;
				bloqueiaPulo = true;
			}
			
			px += vx;
			py += vy;	
			
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