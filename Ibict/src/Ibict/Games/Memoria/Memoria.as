package Ibict.Games.Memoria
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Memoria extends MovieClip
	{
		/* Fundo do jogo. */
		public var fundo : MovieClip;
		
		/* Array que contera as cartas ainda nao escolhidas. */
		public var cartas : Array;
		/* Array que contera as cartas viradas. */
		public var cartasViradas : Array;
		/* Array dos tipos de cada carta. */
		public var tipos: Array;
		public var numeros: Array;
		 
		private var carta : Sprite;
		
		private var cartaV : Sprite;
		
		public var viradas: int;
		public var viradastot: int;
		
		public var tipo: int;
		public var num: int;
		
		public function Memoria(config:int){
			cartas = new Array();
			cartasViradas = new Array();
			tipos = new Array();
			numeros = new Array();

			fundo = new MemoriaFundo;
			
			carta = new MemoriaCartaFundo();
			carta.x = 375;
			carta.y = 210;
			fundo.addChild(carta);
			cartas.push(carta);
			carta = new MemoriaCartaFundo();
			carta.x = 515;
			carta.y = 210;
			fundo.addChild(carta);
			cartas.push(carta);
			carta = new MemoriaCartaFundo();
			carta.x = 375;
			carta.y = 350;
			fundo.addChild(carta);
			cartas.push(carta);
			carta = new MemoriaCartaFundo();
			carta.x = 515;
			carta.y = 350;
			fundo.addChild(carta);
			cartas.push(carta);
			
			cartaV = new MemoriaCarta1();
			cartaV.x = 375 + (carta.width - cartaV.width)/2;
			cartaV.y = 210;
			tipo = 1;
			num = 1;
			cartasViradas.push(cartaV);
			tipos.push(tipo);
			numeros.push(num);
			cartaV = new MemoriaCarta2();
			cartaV.x = 515 + (carta.width - cartaV.width)/2;
			cartaV.y = 210;
			tipo = 1;
			num = 2;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);
			cartaV = new MemoriaCarta1();
			cartaV.x = 375 + (carta.width - cartaV.width)/2;
			cartaV.y = 350;
			tipo = 1;
			num = 1;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);
			cartaV = new MemoriaCarta2();
			cartaV.x = 515 + (carta.width - cartaV.width)/2;
			cartaV.y = 350;
			tipo = 1;
			num = 2;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);
			
			viradastot = 4;
			viradas = 0;
		}

	}
}