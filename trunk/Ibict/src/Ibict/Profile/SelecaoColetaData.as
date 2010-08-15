package Ibict.Profile
{
	import flash.sampler.startSampling;
	
	public class SelecaoColetaData
	{
		
		public var starPoints : Array;
		
		// armazena os pontos de cada uma das fases. Tamanho: 5
		public var points : Array;
		
		// armazena booleanos de cada uma das fases. Tamanho: 5
		public var completed : Array;
		
		
		public function getStarCount(level : int) {
			var i, j, count : int;
			
			count = 0;
			
			for(i = 0; i < 5; i++) {
				for(j = 0; j < 1; j++) {
					if(getStar(i, j)) count++;
				}
			}
			
			return count;
			
		}
		
		public function getStar(level : int, star : int) : Boolean {
			if(level > 4) return false;
			
			switch(star) {
				case 0:
					return completed[level];
				break;
				case 1:
					return (points[level] >= starPoints[level]);				
				break;
			}
			
			return false;
		}
		
		public function getGeneralStarCount() {
			
		}
		
		public function setPoints(level : int, points : int) {
			this.points[level - 1] = points;
		}
		
		public function SelecaoColetaData()
		{
			var i : int;
			points = new Array(5);
			completed = new Array(5);
			starPoints = new Array(5);
			
			starPoints[0] = 480;
			starPoints[1] = 0;
			starPoints[2] = 0;
			starPoints[3] = 0;
			starPoints[4] = 0;
			
			for(i = 0; i < 5; i++) {
				points[i] = 0;
				completed[i] = false;
			}
			
			
			
		}

	}
}