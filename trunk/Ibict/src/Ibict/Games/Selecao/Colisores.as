package Ibict.Games.Selecao
{
	import Ibict.Texture;
	
	public class Colisores
	{
		var cenario : Texture;
		var colisorBaixo : Colisor;
		var colisorMenosBaixo : Colisor;
		var colisorDireita : Colisor;
		var colisorEsquerda : Colisor;
		var colisorCima : Colisor;
		var root : Platformer;

		
		public function Colisores(cenario : Texture, root : Platformer)
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
			if(colisorCima.pixelCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		public function detectaColisaoEsq() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorEsquerda.pixelCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		public function detectaColisaoDir() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorDireita.pixelCollidesWith(cenario)) {
				colidiu = true;
				trace("dir");
			}
			
			return colidiu;
		}
		
		public function detectaColisaoBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorBaixo.pixelCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
			
			
		}
		
		public function detectaColisaoMenosBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorMenosBaixo.pixelCollidesWith(cenario)) {
				colidiu = true;
			}
			
			return colidiu;
		}
		
		
		public function updatePhysics() {
			/* atualiza posicao dos colisores */
			colisorMenosBaixo.posx = root.px + 15;
			colisorMenosBaixo.posy = root.py + 37;
			
			colisorBaixo.posx = root.px + 15;
			colisorBaixo.posy = root.py + 38;
			
			colisorDireita.posx = root.px + 50;
			colisorDireita.posy = root.py + 6;
			
			colisorEsquerda.posx = root.px + 2;
			colisorEsquerda.posy = root.py + 6;
			
			colisorCima.posx = root.px + 6;
			colisorCima.posy = root.py;
		}
		
		public function updateRender() {
			/* atualiza os renders */
			colisorBaixo.updateRender();
			colisorMenosBaixo.updateRender();
			colisorDireita.updateRender();
			colisorEsquerda.updateRender();
			colisorCima.updateRender();
		}

	}
}