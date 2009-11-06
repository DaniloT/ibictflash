package Entities
{	
	public class Paper extends Trash
	{
		private static const PAPERWIDTH : Number = 60;
		private static const PAPERHEIGHT : Number = 60;
		
		public function Paper(randomY:Boolean)
		{ 
			/* var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new Paper0();
					break;
				case(1): graph = new Paper1();
					break;
				case(2): graph = new Paper2();
					break;
			}
			graph.width = PAPERWIDTH;
			graph.height = PAPERHEIGHT;
			addChild(graph); */
			
			super(randomY);
			
			velocidadeMax = 5;
		}		
	}
}