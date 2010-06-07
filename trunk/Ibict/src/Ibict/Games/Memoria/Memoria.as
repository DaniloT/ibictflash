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
		/* Array contendo todas as cartas. */
		public var todasCartas : Array;
		/* Array dos tipos de todas carta. */
		public var todosTipos: Array;
		public var todosNumeros: Array;
		 
		private var carta : Sprite;
		
		private var cartaV : Sprite;
		
		public var viradas: int;
		public var viradastot: int;
		
		public var tipo: int;
		public var num: int;
		
		private var cartax: int;
		private var cartay: int;
		
		private var inicioRetX: int;
		private var inicioRetY: int;
		private var fimRetX: int;
		private var fimRetY: int;
		private var dist: int;
		
		public function Memoria(config:int, numCartasX:int, numCartasY:int){
			cartas = new Array();
			cartasViradas = new Array();
			tipos = new Array();
			numeros = new Array();
			
			todasCartas = new Array();
			todosTipos = new Array();
			todosNumeros = new Array();

			fundo = new MemoriaFundo;
			
			inicioRetX = 375;
			inicioRetY = 210;
			fimRetX = 515;
			fimRetY = 350;
			dist = 140;
			
			cartax = inicioRetX;
			cartay = inicioRetY;
			
			cartaV = new MemoriaCarta11();
			todasCartas.push(cartaV);
			tipo = 1;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta12();
			todasCartas.push(cartaV);
			tipo = 1;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta21();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta22();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta31();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta32();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta41();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta42();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta51();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta52();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta61();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta62();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta71();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta72();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta81();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta82();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			
			for (var i : int = 0; i < numCartasX; i++) { 
				for (var j : int = 0; j < numCartasY; j++) {
					carta = new MemoriaCartaFundo();
					carta.x = cartax;
					carta.y = cartay;
					fundo.addChild(carta);
					cartas.push(carta);
					
					cartaV = todasCartas[i + numCartasY*(j)];
					cartaV.x = cartax + (carta.width - cartaV.width)/2;
					cartaV.y = cartay;
					tipo = todosTipos[i + numCartasY*(j)];
					num = todosNumeros[i + numCartasY*(j)];
					tipos.push(tipo);
					numeros.push(num);
					cartasViradas.push(cartaV);
					
					cartay += dist;
				}
				cartay = inicioRetY;
				cartax += dist;
			}
			
			viradastot = 4;
			viradas = 0;
						
			/*carta = new MemoriaCartaFundo();
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
			cartas.push(carta);*/
			
			/*cartaV = new MemoriaCarta11();
			cartaV.x = 375 + (carta.width - cartaV.width)/2;
			cartaV.y = 210;
			tipo = 1;
			num = 1;
			cartasViradas.push(cartaV);
			tipos.push(tipo);
			numeros.push(num);
			cartaV = new MemoriaCarta12();
			cartaV.x = 515 + (carta.width - cartaV.width)/2;
			cartaV.y = 210;
			tipo = 1;
			num = 2;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);
			cartaV = new MemoriaCarta21();
			cartaV.x = 375 + (carta.width - cartaV.width)/2;
			cartaV.y = 350;
			tipo = 2;
			num = 1;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);
			cartaV = new MemoriaCarta22();
			cartaV.x = 515 + (carta.width - cartaV.width)/2;
			cartaV.y = 350;
			tipo = 2;
			num = 2;
			tipos.push(tipo);
			numeros.push(num);
			cartasViradas.push(cartaV);*/
			
		}

	}
}