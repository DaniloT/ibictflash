package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;
	
	public class Colisor extends TextureScrollable
	{
		// posx e posy são as posicoes reais do Colisor,
		// e nao de renderizacao
		
		var vxRet : int;
		var vyRet : int;
		
		var dx, dy : int;
		
		public function Colisor()
		{
			dx = this.width;
			dy = this.height;
			trace("colisor:");
			trace(dx);
			trace(dy);
		}
		
		public function avanca(vx : int, vy : int) {
			this.px += vx;
			this.py += vy;
			vxRet = vx;
			vyRet = vy;
		}
		
		public function retorna() {
			this.px -= vxRet;
			this.py -= vyRet;
		}
		
		public function updateRender() {
			Render();
		}

	}
}