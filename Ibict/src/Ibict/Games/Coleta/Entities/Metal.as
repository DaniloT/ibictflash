package Ibict.Games.Coleta.Entities
{
	public class Metal extends Trash
	{
		private static const METALWIDTH : Number = 60;
		private static const METALHEIGHT : Number = 60;
		
		public function Metal(randomY:Boolean)
		{ 
			/* var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new Metal0();
					break;
				case(1): graph = new Metal1();
					break;
				case(2): graph = new Metal2();
					break;
			}
			addChild(graph); */
			//this.width = METALWIDTH;
			//this.height = METALHEIGHT;
			
			super(randomY);
			velocidadeMax = 6;
		}
		
		public override function getTargetBin() : int {
			return TrashTypesEnum.METAL;
		}
	}
}
