package Ibict.Profile
{
	import flash.sampler.startSampling;
	
	public class SelecaoColetaData
	{
		
		private var starPoints : Array;
		
		// armazena os pontos de cada uma das fases. Tamanho: 5
		public var points : Array;
		
		// armazena booleanos de cada uma das fases. Tamanho: 5
		public var completed : Array;
		
		
		public function getStarCount(level : int) {
			
		}
		
		public function getGeneralStarCount() {
			
		}
		
		public function SelecaoColetaData()
		{
			var i : int;
			points = new Array(5);
			completed = new Array(5);
			starPoints = new Array(5);
			
			for(i = 0; i < 5; i++) {
				points[i] = 0;
				completed[i] = false;
			}
			
			
			
		}

	}
}