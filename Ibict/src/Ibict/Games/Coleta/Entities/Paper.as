package Ibict.Games.Coleta.Entities
{
	import flash.display.MovieClip;
		
	public class Paper extends Trash
	{
		private static const PAPERWIDTH : Number = 60;
		private static const PAPERHEIGHT : Number = 60;
		
		
		public function Paper(randomY:Boolean)
		{ 
			/*  var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new Paper0();
					break;
				case(1): graph = new Paper0();
					break;
				case(2): graph = new Paper0();
					break;
			} 
			addChild(graph);*/ 
			//this.width = PAPERWIDTH;
			//this.height = PAPERHEIGHT;
			
			
			super(randomY);
			
			velocidadeMax = 4;
		}
		
		public override function getTargetBin() : int {
			return TrashTypesEnum.PAPER;
		}
	}
}
