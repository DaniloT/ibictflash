package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;
	
	public class Colisor extends TextureScrollable
	{
		// posx e posy são as posicoes reais do Colisor,
		// e nao de renderizacao
		
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
			Render();
		}

	}
}