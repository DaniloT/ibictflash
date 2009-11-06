package Entities
{
	public class Plastic extends Trash
	{
		private static const PLASTICWIDTH : Number = 60;
		private static const PLASTICHEIGHT : Number = 60;
		
		public function Plastic(randomY:Boolean)
		{ 
			/* var i:int;
			i = Math.floor(Math.random() * 2);
			switch(i){
				case(0): graph = new Plastic0();
					break;
				case(1): graph = new Plastic1();
					break;
				case(2): graph = new Plastic2();
					break;
			}
			graph.width = PLASTICWIDTH;
			graph.height = PLASTICHEIGHT;
			addChild(graph); */
			
			super(randomY);
			velocidadeMax = 5;
		}
		
	}
}