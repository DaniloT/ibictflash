package Ibict.Games.Selecao
{
	public class Life
	{
		var life : int;
		var total : int;
		
		public function Life(lifeTotal : int)
		{
			life = lifeTotal;
			total = lifeTotal;
		}
		
		public function machuca() 
		{
			life--;
		}
		
		public function update() {
			
		}

	}
}