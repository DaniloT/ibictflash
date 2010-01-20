package Ibict.Games.Coleta.Entities
{
	public class NotRec extends Trash
	{
		private static const NOTRECWIDTH : Number = 60;
		private static const NOTRECHEIGHT : Number = 60;
		
		public function NotRec(randomY:Boolean)
		{ 
			/* var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new NotRec0();
					break;
				case(1): graph = new NotRec1();
					break;
				case(2): graph = new NotRec2();
					break;
			}
			graph.width = NOTRECWIDTH;
			graph.height = NOTRECHEIGHT;
			addChild(graph); */
			
			super(randomY);
			velocidadeMax = 8;			
		}
		
		public override function getTargetBin() : int {
			return TrashTypesEnum.NOT_REC;
		}		
	}
}
