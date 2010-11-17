package Ibict.Profile.Data
{
	import flash.sampler.startSampling;
	
	public class SelecaoColetaData
	{
		
		public var starPoints : Array;
		
		// armazena os pontos de cada uma das fases. Tamanho: 5
		public var points : Array;
		
		// armazena booleanos de cada uma das fases. Tamanho: 5
		public var completed : Array;
		
		public function getPoints(level : int) : int {
			return points[level];
		}
		
		public function getTotalPoints(level : int) : int  {
			var i : int;
			var count : int;
			count = 0;
			
			for (i = 0; i < 5; i++) {
				count += points[i];
			}
			
			return count;
		}
		
		
		public function getStarCount() : int {
			var i, j, count : int;
			
			count = 0;
			
			for(i = 0; i < 5; i++) {
				for(j = 0; j < 2; j++) {
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
					trace("verdadeiro?");
					return (points[level] >= starPoints[level]);				
				break;
			}
			
			return false;
		}
		
		public function getGeneralStarCount() {
			
		}
		
		public function setPoints(level : int, points : int) {
			if(points > this.points[level-1]) this.points[level - 1] = points;
		}
		
		public function SelecaoColetaData()
		{
			var i : int;
			points = new Array(5);
			completed = new Array(5);
			starPoints = new Array(5);
			
			starPoints[0] = 480;
			starPoints[1] = 480;
			starPoints[2] = 700;
			starPoints[3] = 900;
			starPoints[4] = 600;
			
			for(i = 0; i < 5; i++) {
				points[i] = 0;
				completed[i] = false;
			}
			
			
			
		}

	}
}