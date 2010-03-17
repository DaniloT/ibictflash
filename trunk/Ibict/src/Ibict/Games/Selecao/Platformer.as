package Ibict.Games.Selecao
{
	import Ibict.InputManager;
	import Ibict.TextureScrollable;
	import Ibict.Util.Temporizador;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	
	public class Platformer extends MovieClip
	{
		var vx : Number, vy : Number;
		var cenario : TextureScrollable;
		var objetosSprings : TextureScrollable;
		var objetosLixos : TextureScrollable;
		var inimigos : Inimigos;
		var movables : Movables;
		var gravidade : int;
		var staticBall : TextureScrollable;
		var inputManager : InputManager;
		var colisores : Colisores;
		var bloqueiaPulo : Boolean;
		var temporizadorPulo : Temporizador;
		
		var divisorTempo : int;

		
		
				
		public function Platformer()
		{
			/* instanciando objetos e setando variaveis principais */
			gravidade = 1;
			staticBall = new selectSB();
			staticBall.x = 0;
			staticBall.y = 0;
			
			staticBall.px = 3;
			staticBall.py = 3;
			vx = 0;
			vy = 0;
			
			this.addChild(staticBall);
			
			
			/* inicializando o inputManager */
			inputManager = InputManager.getInstance();
			
			/* inicializando o cenario */
			cenario = new selectStage1();
			this.addChild(cenario);
			
			/* inicializando os objetos de lixos */
			objetosLixos = new selectLixos();
			this.addChild(objetosLixos);
			
			/* inicializando os objetos das molas */
			objetosSprings = new selectSprings1();
			this.addChild(objetosSprings);			
			
			/* inicializando os movables */
			movables = new Movables(this, 0);
			movables.addChilds();
			movables.setCenter(staticBall);
			
			/* inicializando os inimigos */
			inimigos = new selectInimigos1();
			this.addChild(inimigos);
			
			/* inicializando os colisores */
			colisores = new Colisores(cenario, inimigos, this);
			
						
			/* seta o bloqueiaPulo */
			bloqueiaPulo = false;
			
			/* setando o centro */
			staticBall.setCenter(staticBall);
			cenario.setCenter(staticBall);
			colisores.setCentro(staticBall);
			objetosLixos.setCenter(staticBall);
			objetosSprings.setCenter(staticBall);
			inimigos.setCenter(staticBall);
			
			divisorTempo = 33;
			
			/* inicializando o temporizador do pulo */
			temporizadorPulo = new Temporizador();

			
			
		}
				
		private function detectaColisao(): Boolean {
			
			return false;
		}
		
		private function updatePhysics(dt : int) {
			
			/* aplicando tudo que fara o personagem se mover */
			var count : int;
			var i : int;
			var objeto : DisplayObject;
			
			if(!colisores.detectaColisaoBaixo()) {
				vy += gravidade*dt/divisorTempo;
			} else {
				vy = 2;
				temporizadorPulo.stop();
				bloqueiaPulo = false;
			}		
			
			/*aplicando controle do pulo */
			
			if(vy > 2) {
				temporizadorPulo.start();
				bloqueiaPulo = true;
			}
			
			if(inputManager.isDown(Keyboard.UP)) {
				temporizadorPulo.start();
				if(temporizadorPulo.getCount() < 200 && !bloqueiaPulo) {
					vy = -10;
					staticBall.py -= 2;					
				}
				
				
			}
			
			

			if(colisores.detectaColisaoDir() || colisores.detectaColisaoEsq()) {
				vx = 0;
			}
			
			if(inputManager.isDown(Keyboard.RIGHT) && !colisores.detectaColisaoDir()) {
				if(vx < 7)
					vx += 1;
			} else if(inputManager.isDown(Keyboard.LEFT) && !colisores.detectaColisaoEsq()) {
				if(vx > -7)
					vx += -1;
			} else {
				if(!inputManager.isDown(Keyboard.RIGHT) && vx > 0) {
					vx -= 1;
				}
				if(!inputManager.isDown(Keyboard.LEFT) && vx < 0) {
					vx += 1;
				}
				
			}
			
			
			if(colisores.detectaColisaoCima() && vy < 0) {
				staticBall.py -= vy;
				vy = 0;
				bloqueiaPulo = true;
			}
			
			/* verifica colisao com objetos de springs do cenario */
			for(i = 0; i < objetosSprings.numChildren; i++) {
				objeto = objetosSprings.getChildAt(i);
				
				if(staticBall.hitTestObject(objeto)) {
					vy = - 20;
					staticBall.py -= 2;
				}
				
			}
			
			/* verifica se esta pulando em cima de um inimigo */
			if((objeto = colisores.detectaColisaoInimigoBaixo()) != null) {
				inimigos.removeChild(objeto);
				vy = - 10;
			}
			
			/* verifica se levou dano de um inimigo */
			if(colisores.detectaColisaoInimigoDireita() != null) {
				vy = -10;
				vx = - 5;
			}
			
			if(colisores.detectaColisaoInimigoEsquerda() != null) {
				vy = -10;
				vx = + 5;
			}
			
			staticBall.px += vx*dt/divisorTempo;
			staticBall.py += vy*dt/divisorTempo;	
			
			colisores.updatePhysics(dt);
			
			
			/* update nos inimigos*/
			inimigos.updatePhysics();
			
			
			/* da um update render de novo */
			colisores.colisorMenosBaixo.avanca(vx, vy);
			
						
			
			
			while(colisores.detectaColisaoMenosBaixo()) {
				staticBall.py--;
				colisores.updatePhysics(dt);
				colisores.updateRender(dt);
			}
			colisores.colisorMenosBaixo.retorna();
			
			
			
			/* verifica colisao com os objetos de lixo do cenario */
			for(i = 0; i < objetosLixos.numChildren; i++) {
				objeto = objetosLixos.getChildAt(i);
				
				
				if(staticBall.hitTestObject(objeto)) {
					objetosLixos.removeChild(objeto);
				}
			}
			
			
			
			
			
		}
		
		private function updateRenders(dt : int) {
			staticBall.Render();
			cenario.Render();
			objetosLixos.Render();
			objetosSprings.Render();
			movables.render();
			inimigos.Render();
			colisores.updateRender(dt);
		}
		
		public function update(dt : int) {
			updateRenders(dt);
			updatePhysics(dt);		
			
			
		}

	}
}