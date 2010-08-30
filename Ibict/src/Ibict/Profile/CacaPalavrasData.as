package Ibict.Profile
{
	public class CacaPalavrasData
	{
		var pontuacao : Array;
		
		public function setPontuacao(points : int) {
			if(points > pontuacao[i]) pontuacao[i] = points;
		}
		
		
		public function getStar(star : int ) {
			return (pontuacao[i] > 0);
		}
		
		public function getStarCount() {
			var count : int;
			var i : int;
			
			count = 0;
			
			for( i = 0; i < 5; i++) {
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