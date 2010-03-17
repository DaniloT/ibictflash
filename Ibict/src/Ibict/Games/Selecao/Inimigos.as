package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;

	public class Inimigos extends TextureScrollable
	{
		var angleMoviment : Number;
		
		public function Inimigos()
		{
			angleMoviment = 0;
			super();
		}
		
		public function updatePhysics() {
			angleMoviment += 0.05;
			if(angleMoviment > 2*Math.PI) {
				angleMoviment = 0;
			}			
			
			this.px = Math.sin(angleMoviment)*70 + 70;
			
		}
		
	}
}