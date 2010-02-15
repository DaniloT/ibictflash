package Ibict.Games.Selecao
{
	import flash.display.MovieClip;
	
	public class Platformer : MovieClip
	{
		var px, py;
		var vx, vy;
		var cenario : MovieClip;
		var gravidade : int;
		var staticBall : MovieClip;
		
		
				
		public function Platformer()
		{
			gravidade = 3;
			staticBall = new selectSB();
		}
				
		private function detectaColisao(): Boolean {
			
			return false;
		}
		
		private function updatePhysics() {
			var count : int;
			
			/* aplica a gravidade */
			vy += gravidade;
			
			px += vx;
			py += vy;
			
			
		}
		
		private function updateRenders() {
			
		}
		
		public function update() {
			updatePhysics();
			
		}

	}
}