package SeteErros
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Cena extends MovieClip
	{
		public var figura : Sprite;
		
		
		public function Cena(tipo:int){
			/*switch(tipo){
				case(0) : figura = new ErrosFundo0;
					break;
				case(1) : figura = new ErrosFundo;
					break;
			}*/
			figura = new ErrosFundo0;
		
		}

	}
}