package Ibict.Profile
{
	public class CacaPalavrasData
	{
		var pontuacao : Array;
		
		public function setPontuacao(points : int) {
			var i : int;
			if(points > pontuacao[i]) pontuacao[i] = points;
		}
		
		public function getPoints(dificuldade : int) : int {
			return pontuacao[dificuldade];
		}
		
		public function getTotalPoints() : int {
			var i : int;
			var count : int;
			count = 0;
			
			for(i = 0; i < 5; i++) {
				count += pontuacao[i];
			}
			
			
			
			return count;
		}
		
		
		public function getStar(star : int ) : Boolean {
			if(star != 5)
				return (pontuacao[star] > 0);
			else {
				return (getTotalPoints() >= 30000);		
			}
		}
		
		public function getStarCount() : int {
			var count : int;
			var i : int;
			
			count = 0;
			
			for( i = 0; i < 6; i++) {
				if(getStar(i)) count++;
			}
			
			return count;
		}
		
		public function CacaPalavrasData()
		{
			var i : int;
			pontuacao = new Array(5);
			
			for(i = 0; i < 5; i++) {
				pontuacao[i] = 0;
			}
			
		}

	}
}