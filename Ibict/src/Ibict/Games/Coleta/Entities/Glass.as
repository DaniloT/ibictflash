package Ibict.Games.Coleta.Entities
{
	public class Glass extends Trash
	{
		private static const GLASSWIDTH : Number = 60;
		private static const GLASSHEIGHT : Number = 60;
		
		public function Glass(randomY:Boolean)
		{
			/* var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new Glass0();
					break;
				case(1): graph = new Glass1();
					break;
				case(2): graph = new Glass2();
					break;
			}
			addChild(graph); */
			//this.width = GLASSWIDTH;
			//this.height = GLASSHEIGHT;
			
			super(randomY);
			velocidadeMax = 5;
		}
		
		public override function getTargetBin() : int {
			return TrashTypesEnum.GLASS;
		}
	}
}
