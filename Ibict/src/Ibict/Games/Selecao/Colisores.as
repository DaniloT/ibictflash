package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;
	
	public class Colisores
	{
		var cenario : TextureScrollable;
		var inimigos : Inimigos;
		var colisorBaixo : Colisor;
		var colisorMenosBaixo : Colisor;
		var colisorDireita : Colisor;
		var colisorEsquerda : Colisor;
		var colisorCima : Colisor;
		var root : Platformer;

		
		public function Colisores(cenario : TextureScrollable, inimigos : Inimigos, root : Platformer)
		{
			/* colocando variaveis essenciais */
			this.cenario = cenario;
			this.root = root;
			
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
		
		public function detectaColisaoCima() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorCima.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		public function detectaColisaoEsq() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorEsquerda.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		public function detectaColisaoDir() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorDireita.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		public function detectaColisaoBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorBaixo.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
			
			
		}
		
		public function detectaColisaoMenosBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorMenosBaixo.pixelScrollCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		
		
		
		public function updatePhysics(dt : int) {
			/* atualiza posicao dos colisores */
			colisorMenosBaixo.px = root.staticBall.px + 15;
			colisorMenosBaixo.py = root.staticBall.py + 37;
			
			colisorBaixo.px = root.staticBall.px + 15;
			colisorBaixo.py = root.staticBall.py + 38;
			
			colisorDireita.px = root.staticBall.px + 50;
			colisorDireita.py = root.staticBall.py + 6;
			
			colisorEsquerda.px = root.staticBall.px + 2;
			colisorEsquerda.py = root.staticBall.py + 6;
			
			colisorCima.px = root.staticBall.px + 6;
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