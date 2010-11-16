package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;
	
	import flash.display.DisplayObject;
	
	public class Colisores
	{
		var cenario : TextureScrollable;
		var collisionMap : Array;
		var inimigos : Inimigos;
		var colisorBaixo : Colisor;
		var colisorMenosBaixo : Colisor;
		var colisorDireita : Colisor;
		var colisorEsquerda : Colisor;
		var colisorCima : Colisor;
		var root : Platformer;
		var cenarioWidth, cenarioHeight : int;

		
		public function Colisores(cenario : TextureScrollable, inimigos : Inimigos, root : Platformer, collisionMap : Array, cenarioWidth : int, cenarioHeight : int)
		{
			/* colocando variaveis essenciais */
			this.cenario = cenario;
			this.root = root;
			this.inimigos = inimigos;
			
			/* inicializando detectores de colisao */
			colisorBaixo = new selectDecColisaoHor();
			colisorMenosBaixo = new selectDecColisaoHor();
			colisorDireita = new selectDecColisaoVer();
			colisorEsquerda = new selectDecColisaoVer();
			colisorCima = new selectDecColisaoHor();
			
			
			colisorBaixo.visible = false;
			colisorMenosBaixo.visible = false;
			colisorDireita.visible = false;
			colisorEsquerda.visible = false;
			colisorCima.visible = false;
			
			
			this.cenarioHeight = cenarioHeight;
			this.cenarioWidth = cenarioWidth;
			this.collisionMap = collisionMap;

			
			addChilds();
		}
		
		public function addChilds() {
			root.addChild(colisorBaixo);
			root.addChild(colisorMenosBaixo);
			root.addChild(colisorDireita);
			root.addChild(colisorEsquerda);
			root.addChild(colisorCima);
		}
		
		public function removeChilds() {
			
		}

		
		private function detectaColisao(colisor : Colisor) : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			var i, j : int;
			
			/*
			for(i = 0; i < cenario.numChildren; i++) {
				if(colisor.pixelCollidesWith(cenario.getChildAt(i))) 
					colidiu = true;
			}
			*/
			
			try {
				if(collisionMap[Math.floor(colisor.py / 50)][Math.floor(colisor.px / 50)] ||
				collisionMap[Math.floor((colisor.py + colisor.dy) / 50)][Math.floor(colisor.px / 50)] ||
				collisionMap[Math.floor(colisor.py / 50)][Math.floor((colisor.px + colisor.dx) / 50)] ||
				collisionMap[Math.floor((colisor.py + colisor.dy) / 50)][Math.floor((colisor.px + colisor.dx) / 50)]) {
					return true;
				}
			} catch(errObject:Error) {
				return false;
			}
			
			
			/*
			if(colisor.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			*/
			
		
			
			
			return colidiu;
		}
		
		public function detectaColisaoCima() : Boolean {
			return detectaColisao(colisorCima);
		}
		
		public function detectaColisaoEsq() : Boolean {
			return detectaColisao(colisorEsquerda);
		}
		
		public function detectaColisaoDir() : Boolean {
			return detectaColisao(colisorDireita);
		}
		
		public function detectaColisaoBaixo() : Boolean {
			return detectaColisao(colisorBaixo);
			
			
		}
		
		public function detectaColisaoMenosBaixo() : Boolean {
			return detectaColisao(colisorMenosBaixo);
		}
		
		public function corrigeColisaoPorBaixo(vx : Number, vy : Number) : int {
			var acumulador : Number;
			var py_inicial : int;
			
			py_inicial = colisorMenosBaixo.py;
			
			if(vx > 50) {
				for(var i = 0; i < vx; i += 50) {
					colisorMenosBaixo.py = py_inicial + i;
					if(detectaColisao(colisorMenosBaixo)) {
						colisorMenosBaixo.py = py_inicial;
						return i;
					}
				}
				
				
			} 
			
			colisorMenosBaixo.py = py_inicial;
			
			return -1;
			
		}
		
		private function detectaColisaoInimigo(colisor : Colisor) : DisplayObject {
			var colidiu : Boolean;
			var objeto : DisplayObject;
			var i : int;
			
			
			for(i = 0; i < inimigos.numChildren; i++) {
				objeto = inimigos.getChildAt(i);
				
				
				
				
				if(colisor.hitTestObject(objeto)) {
					return objeto;
				}
				
			}
			
			return null;
		}
		
		public function detectaColisaoInimigoBaixo() : DisplayObject {
			return detectaColisaoInimigo(colisorBaixo);
			
		}
		
		public function detectaColisaoInimigoDireita() :DisplayObject {
			return detectaColisaoInimigo(colisorDireita);
		}
		
		public function detectaColisaoInimigoEsquerda() :DisplayObject {
			return detectaColisaoInimigo(colisorEsquerda);
		}
		
		
		public function updatePhysics(dt : int) {
			/* atualiza posicao dos colisores */
			colisorMenosBaixo.px = root.staticBall.px + 8;
			colisorMenosBaixo.py = root.staticBall.py + 37;
			
			colisorBaixo.px = root.staticBall.px + 8;
			colisorBaixo.py = root.staticBall.py + 38;
			
			colisorDireita.px = root.staticBall.px + 50;
			colisorDireita.py = root.staticBall.py + 6;
			
			colisorEsquerda.px = root.staticBall.px + 2;
			colisorEsquerda.py = root.staticBall.py + 6;
			
			colisorCima.px = root.staticBall.px + 8;
			colisorCima.py = root.staticBall.py;
		}
		
		public function updateRender(dt : int) {
			/* atualiza os renders */
			colisorBaixo.updateRender();
			colisorMenosBaixo.updateRender();
			colisorDireita.updateRender();
			colisorEsquerda.updateRender();
			colisorCima.updateRender();
		}
		
		public function setCentro(center : TextureScrollable) {
			colisorBaixo.setCenter(center);
			colisorCima.setCenter(center);
			colisorDireita.setCenter(center);
			colisorEsquerda.setCenter(center);
			colisorMenosBaixo.setCenter(center);
		}

	}
}