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
		public var tipos : Array;
		public var numeros : Array;
		/* Array contendo todas as cartas. */
		public var todasCartas : Array;
		/* Array dos tipos de todas carta. */
		public var todosTipos : Array;
		public var todosNumeros : Array;
		/* Array com o preenchimento do grid. */
		public var grid : Array;
		 
		private var carta : MovieClip;
		
		private var cartaV : MovieClip;
		
		public var viradas : int;
		public var viradastot : int;
		
		public var tipo : int;
		public var num : int;
		
		private var cartax : int;
		private var cartay : int;
		
		private var inicioRetX : int;
		private var inicioRetY : int;
		private var distX : int;
		private var distY : int;
		public var tam : int;
		private var numCartasX : int;
		private var numCartasY : int;
		
		private var cartaTipo : int;
		private var randNum : int;
		private var tentativa : int;
		
		private var i : int;
		private var j : int;
		private var k : int;
		
		public function Memoria(config:int, dif:int){
			cartas = new Array();
			cartasViradas = new Array();
			tipos = new Array();
			numeros = new Array();
			
			todasCartas = new Array();
			todosTipos = new Array();
			todosNumeros = new Array();
			
			grid = new Array();

			fundo = new MemoriaFundo;
			
			viradas = 0;
			
			/* Prepara o grid de acordo com a dificuldade. */
			if (dif == 1){
				/* facil */
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
			
			num = 0;
			for (i = 0; i < viradastot; i++) {
				grid.push(num);
				cartasViradas.push(num);
			}
			
			cartax = inicioRetX;
			cartay = inicioRetY;
			
			cartaV = new MemoriaCarta11;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 1;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta12;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 1;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta21;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta22;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta31;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta32;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta41;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta42;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta51;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta52;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta61;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta62;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta71;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta72;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta81;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta82;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta91;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta92;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta101;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta102;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta111;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta112;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta121;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta122;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta131;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 13;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta132;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 13;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta141;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 14;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta142;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 14;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta151;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 15;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta152;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 15;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta161;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 16;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			cartaV = new MemoriaCarta162;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 16;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			
			for (j = 0; j < (viradastot/2); j++) {
				cartaTipo = Math.floor(Math.random()*todasCartas.length);
				k = 0;
				tentativa = 0;
				while (k < viradastot) {
					if (cartaTipo != grid[k]) {
						k++;
					} else {
						k = 0;
						tentativa++;
						cartaTipo = Math.floor(Math.random()*todasCartas.length);
						if (tentativa == 10) {
							i = 0;
							while (k < viradastot) {
								if (cartaTipo != grid[k]) {
									k++;
								} else {
									cartaTipo = i;
									i++;
									k = 0;
								}
							}
						}
					}
				}
				randNum = Math.floor(Math.random()*viradastot);
				tentativa = 0;
				while (grid[randNum] != 0) {
					randNum = Math.floor(Math.random()*viradastot);
					tentativa++;
					if (tentativa == 10) {
						i = 0;
						while (grid[i] != 0) {
							i++;
						}
						randNum = i;
					}
				}
				grid[randNum] = cartaTipo;
				if ((cartaTipo%2) == 0) {
					cartaTipo++;
				} else {
					cartaTipo--;
				}
				
				randNum = Math.floor(Math.random()*viradastot);
				tentativa = 0;
				while (grid[randNum] != 0) {
					randNum = Math.floor(Math.random()*viradastot);
					tentativa++;
					if (tentativa == 10) {
						i = 0;
						while (grid[i] != 0) {
							i++;
						}
						randNum = i;
					}
				}
				grid[randNum] = cartaTipo;
			}
			
			
			
			for (i = 0; i < numCartasX; i++) { 
				for (j = 0; j < numCartasY; j++) {
					
					cartaV = todasCartas[grid[i+numCartasX*j]];
					cartaV.width = tam;
					cartaV.height = tam;
					cartaV.x = cartax;
					cartaV.y = cartay;
					cartaV.stop();
					tipo = todosTipos[grid[i+numCartasX*j]];
					num = todosNumeros[grid[i+numCartasX*j]];
					tipos.push(tipo);
					numeros.push(num);
					
					cartas.push(cartaV);
					fundo.addChild(cartaV);
					cartay += distX;
				}
				cartay = inicioRetY;
				cartax += distY;
			}
			
			
		}
	}
}