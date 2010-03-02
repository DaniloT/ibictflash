package Ibict.Games.Selecao
{
	import Ibict.Texture;
	
	public class Colisor extends Texture
	{
		// posx e posy são as posicoes reais do Colisor,
		// e nao de renderizacao
		var posx, posy : int;
		
		var vxRet : int;
		var vyRet : int;
		
		public function Colisor()
		{
		}
		
		public function avanca(vx : int, vy : int) {
			this.x += vx;
			this.y += vy;
			vxRet = vx;
			vyRet = vy;
		}
		
		public function retorna() {
			this.x -= vxRet;
			this.y -= vyRet;
		}
		
		public function updateRender() {
			this.x = posx;
			this.y = posy;
		}

	}
}