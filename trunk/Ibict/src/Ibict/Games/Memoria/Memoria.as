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
		//private var fimRetX: int;
		//private var fimRetY: int;
		private var distX: int;
		private var distY: int;
		private var tam: int;
		private var numCartasX: int;
		private var numCartasY: int;
		
		public function Memoria(config:int, dif:int){
			cartas = new Array();
			cartasViradas = new Array();
			tipos = new Array();
			numeros = new Array();
			
			todasCartas = new Array();
			todosTipos = new Array();
			todosNumeros = new Array();

			fundo = new MemoriaFundo;
			
			viradas = 0;
			
			/* Prepara o grid de acordo com a dificuldade. */
			if (dif == 1){
				/* facil */
				/*inicioRetX = 380;
				inicioRetY = 210;
				distX = 140;
				distY = 140;
				tam = 100;*/
				inicioRetX = 155;
				inicioRetY = 205;
				distX = 140;
				distY = 130;
				tam = 100;
				viradastot = 8;
				numCartasX = 4;
				numCartasY = 2;
			} else {
				if (dif == 2) {
					/* medio */
					inicioRetX = 190;
					inicioRetY = 130;
					distX = 103;
					distY = 110;
					tam = 85;
					viradastot = 16;
					numCartasX = 4;
					numCartasY = 4;
				} else {
					if (dif == 3){
						/* dificil */
						inicioRetX = 92;
						inicioRetY = 130;
						distX = 102;
						distY = 106;
						tam = 85;
						viradastot = 24;
						numCartasX = 6;
						numCartasY = 4;
					}
				}
			}
			
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
			cartaV = new MemoriaCarta91();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta92();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta101();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta102();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta111();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta112();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta121();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta122();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			
			for (var i : int = 0; i < numCartasX; i++) { 
				for (var j : int = 0; j < numCartasY; j++) {
					carta = new MemoriaCartaFundo();
					carta.x = cartax;
					carta.y = cartay;
					carta.width = tam;
					carta.height = tam;
					fundo.addChild(carta);
					cartas.push(carta);
					
					cartaV = todasCartas[i + numCartasX*(j)];
					cartaV.width = tam;
					cartaV.height = tam;
					cartaV.x = cartax;
					cartaV.y = cartay;
					tipo = todosTipos[i + numCartasX*(j)];
					num = todosNumeros[i + numCartasX*(j)];
					tipos.push(tipo);
					numeros.push(num);
					cartasViradas.push(cartaV);
					
					cartay += distX;
				}
				cartay = inicioRetY;
				cartax += distY;
			}
		}
	}
}