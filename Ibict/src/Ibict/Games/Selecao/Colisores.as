package Ibict.Games.Selecao
{
	import Ibict.Texture;
	
	public class Colisores
	{
		var cenario : Texture;
		var colisorBaixo : Colisor;
		var colisorMenosBaixo : Colisor;
		var root : Platformer;

		
		public function Colisores(cenario : Texture, root : Platformer)
		{
			/* colocando variaveis essenciais */
			this.cenario = cenario;
			this.root = root;
			
			/* inicializando detectores de colisao */
			colisorBaixo = new selectDecColisaoHor();
			colisorMenosBaixo = new selectDecColisaoHor();
			
			colisorBaixo.visible = false;
			colisorMenosBaixo.visible = false;
			
			
			addChilds();
		}
		
		public function addChilds() {
			root.addChild(colisorBaixo);
			root.addChild(colisorMenosBaixo);
		}
		
		public function removeChilds() {
			
		}
		
		public function detectaColisaoBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorBaixo.pixelCollidesWith(cenario)) {
				colidiu = true;
				trace("XD1");
			}
			/*
			colisorBaixo.avanca(root.vx, root.vy);
			if(colisorBaixo.pixelCollidesWith(cenario)) {
				colidiu = true;
				trace("XD2");
			}
			colisorBaixo.retorna();
			*/
			
			return colidiu;
			
			
		}
		
		public function detectaColisaoMenosBaixo() : Boolean {
			var colidiu : Boolean;
			
			colidiu = false;
			if(colisorMenosBaixo.pixelCollidesWith(cenario)) {
				colidiu = true;
				trace("XD1");
			}
			
			return colidiu;
		}
		
		
		public function updatePhysics() {
			/* atualiza posicao dos colisores */
			colisorBaixo.posx = root.px;
			colisorBaixo.posy = root.py + 38;
			
			colisorMenosBaixo.posx = root.px;
			colisorMenosBaixo.posy = root.py + 37;
		}
		
		public function updateRender() {
			/* atualiza os renders */
			colisorBaixo.updateRender();
			colisorMenosBaixo.updateRender();
		}

	}
}