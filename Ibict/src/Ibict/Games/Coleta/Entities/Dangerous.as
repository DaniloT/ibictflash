package Ibict.Games.Coleta.Entities
{
	public class Dangerous extends Trash
	{
		
		private static const ORGANICWIDTH : Number = 60;
		private static const ORGANICHEIGHT : Number = 60;
		
		public function Dangerous(randomY :Boolean)
		{
			//this.width = ORGANICWIDTH;
			//this.height = ORGANICHEIGHT;
			
			super(randomY);
			velocidadeMax = 5;
		}
		
		
		
	
		public override function getTargetBin() : int {
			return TrashTypesEnum.DANGEROUS;
		}

	}
}