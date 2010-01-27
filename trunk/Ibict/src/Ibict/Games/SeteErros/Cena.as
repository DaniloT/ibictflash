package Ibict.Games.SeteErros
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Cena extends MovieClip
	{
		/*Figura que contera os erros*/
		public var fundo : MovieClip;
		
		/*Array que contera os movieClips com erros*/
		public var erros : Array;
		/*Array que contera os movieClips com os acertos (para serem trocados qnd o 
		jogador clicar e acertar*/
		public var acertos : Array;
		 
		private var graph1 : Sprite;
		private var graph2 : Sprite;
		public var qtdErros : int;
				
		
		public function Cena(config:int){
			erros = new Array();
			acertos = new Array();
			/*switch(config){
				case(0) : figura = new ErrosFundo0;
						  graph1 = new lampadaAcesa();
						  graph1.x = 50;
						  graph1.y = 50;
						  fundo.addChild(graph1);
						  erros.push(graph1);
						  graph2 = new lampadaApagada();
						  graph2.x = graph1.x + graph1.width - graph2.width;
						  graph2.y = graph1.y + graph1.height - graph2.height;
						  acertos.push(graph2);
						  qtdErros = 1;
						  
					break;
				case(1) : figura = new ErrosFundo;
					break;
			}*/
			fundo = new ErrosFundo0;
			graph1 = new lampadaAcesa();
			graph1.x = 50;
			graph1.y = 50;
			fundo.addChild(graph1);
			erros.push(graph1);
			graph2 = new lampadaApagada();
			graph2.x = graph1.x + (graph1.width - graph2.width)/2;
			graph2.y = graph1.y
			acertos.push(graph2);
			qtdErros = 1;
		}

	}
}