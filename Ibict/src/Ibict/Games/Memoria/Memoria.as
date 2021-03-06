﻿package Ibict.Games.Memoria
{
	import Ibict.Games.CacaPalavras.CacaPalavrasPontuacao;
	
	import flash.display.MovieClip;
	
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
		/* Array com as mensagens que a coruja dirá. */
		public var mensagens : Array;
		public var todasMensagens : Array;
		 
		private var carta : MovieClip;
		
		private var cartaV : MovieClip;
		
		public var viradas : int;
		public var viradastot : int;
		
		public var tipo : int;
		public var num : int;
		public var mensagem : String;
		
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
		
		public var voltar : MovieClip;
		public var lampada : MovieClip;
		public var menuAssociacao : MovieClip;
		//public var voltarAssociacao : MovieClip;
		
		public var pontuacao: CacaPalavrasPontuacao;
		
		public function Memoria(dif:int){
			cartas = new Array();
			cartasViradas = new Array();
			tipos = new Array();
			numeros = new Array();
			mensagens = new Array();
			
			todasCartas = new Array();
			todosTipos = new Array();
			todosNumeros = new Array();
			todasMensagens = new Array();
			
			grid = new Array();

			fundo = new MemoriaFundo;
			
			viradas = 0;
			
			voltar = new MiniBotaoVoltar;
			lampada = new MemoriaLamp;
			menuAssociacao = new MemoriaAssociacao;
			//voltarAssociacao = new MiniBotaoVoltar;
			
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
			todasMensagens.push("Um dos produtos feitos da árvore é o papel e ele é facilmente reciclado.");
			cartaV = new MemoriaCarta12;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 1;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("Um dos produtos feitos da árvore é o papel e ele é facilmente reciclado.");
			cartaV = new MemoriaCarta21;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("As Garrafas PET vêm do petróleo, são 100% recicláveis e delas podemos fazer muitos produtos diferentes, como novas garrafas, calçados, roupas esportivas, bolsas e bijuterias.");
			cartaV = new MemoriaCarta22;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 2;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("As Garrafas PET vêm do petróleo, são 100% recicláveis e delas podemos fazer muitos produtos diferentes, como novas garrafas, calçados, roupas esportivas, bolsas e bijuterias.");
			cartaV = new MemoriaCarta31;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O alumínio é retirado das rochas. As latas de alumínio podem ser recicladas quantas vezes quisermos e são conhecidas como “amigas do meio ambiente”.");
			cartaV = new MemoriaCarta32;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 3;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O alumínio é retirado das rochas. As latas de alumínio podem ser recicladas quantas vezes quisermos e são conhecidas como “amigas do meio ambiente”.");
			cartaV = new MemoriaCarta41;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia eólica é a força que vem do vento e pode ser usada para gerar energia elétrica.");
			cartaV = new MemoriaCarta42;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 4;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia eólica é a força que vem do vento e pode ser usada para gerar energia elétrica.");
			cartaV = new MemoriaCarta51;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O barro é encontrado nas margens dos rios e é usado para fazer vasos, pratos, copos e enfeites, chamados de cerâmicas.");
			cartaV = new MemoriaCarta52;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 5;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O barro é encontrado nas margens dos rios e é usado para fazer vasos, pratos, copos e enfeites, chamados de cerâmicas.");
			cartaV = new MemoriaCarta61;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia elétrica vem das usinas hidrelétricas que usam somente a força da água nos rios. No Brasil as usinas hidrelétricas são a principal forma de produção de energia.");
			cartaV = new MemoriaCarta62;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 6;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia elétrica vem das usinas hidrelétricas que usam somente a força da água nos rios. No Brasil as usinas hidrelétricas são a principal forma de produção de energia.");
			cartaV = new MemoriaCarta71;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O sal é extraído das águas do mar. Além de ser usado nos alimentos, o sal também pode ser usado na limpeza da casa e de várias outras maneiras.");
			cartaV = new MemoriaCarta72;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 7;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O sal é extraído das águas do mar. Além de ser usado nos alimentos, o sal também pode ser usado na limpeza da casa e de várias outras maneiras.");
			cartaV = new MemoriaCarta81;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia solar é a energia que vêm do sol. Serve para esquentar a água ou o ar. As placas solares transformam em energia entre 40% e 60% do calor solar recebido. O sol dá a vida para todo o planeta.");
			cartaV = new MemoriaCarta82;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 8;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A energia solar é a energia que vêm do sol. Serve para esquentar a água ou o ar. As placas solares transformam em energia entre 40% e 60% do calor solar recebido. O sol dá a vida para todo o planeta.");
			cartaV = new MemoriaCarta91;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O vidro é feito da areia e de uma mistura de matérias-primas naturais e é 100% reciclável. Mesmo os vidros quebrados podem ser transformados em novos produtos.");
			cartaV = new MemoriaCarta92;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 9;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O vidro é feito da areia e de uma mistura de matérias-primas naturais e é 100% reciclável. Mesmo os vidros quebrados podem ser transformados em novos produtos.");
			cartaV = new MemoriaCarta101;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O lápis é feito do pinheiro e o Brasil é o maior produtor dele, que é o objeto mais utilizado em qualquer canto do globo.");
			cartaV = new MemoriaCarta102;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 10;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O lápis é feito do pinheiro e o Brasil é o maior produtor dele, que é o objeto mais utilizado em qualquer canto do globo.");
			cartaV = new MemoriaCarta111;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A seringueira só começa a gerar látex a partir do sétimo ano. O látex é a principal matéria-prima da borracha.");
			cartaV = new MemoriaCarta112;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 11;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("A seringueira só começa a gerar látex a partir do sétimo ano. O látex é a principal matéria-prima da borracha.");
			cartaV = new MemoriaCarta121;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O açúcar é retirado da planta da cana-de-açúcar. Ele também pode ser usado em vários alimentos que não têm nada de doce.");
			cartaV = new MemoriaCarta122;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 12;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O açúcar é retirado da planta da cana-de-açúcar. Ele também pode ser usado em vários alimentos que não têm nada de doce.");
			cartaV = new MemoriaCarta131;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 13;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("Os peixes podem ser de água doce ou água salgada. A carne de peixe faz muito bem a saúde.");
			cartaV = new MemoriaCarta132;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 13;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("Os peixes podem ser de água doce ou água salgada. A carne de peixe faz muito bem a saúde.");
			cartaV = new MemoriaCarta141;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 14;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("Os tecidos feitos de algodão levam de 1 a 5 meses para se decompor no meio do lixo. O algodão é considerado a mais importante das fibras têxteis.");
			cartaV = new MemoriaCarta142;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 14;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("Os tecidos feitos de algodão levam de 1 a 5 meses para se decompor no meio do lixo. O algodão é considerado a mais importante das fibras têxteis.");
			cartaV = new MemoriaCarta151;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 15;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O carvão vegetal é obtido a partir da queima de madeira. O carvão vegetal é uma fonte de energia.");
			cartaV = new MemoriaCarta152;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 15;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("O carvão vegetal é obtido a partir da queima de madeira. O carvão vegetal é uma fonte de energia.");
			cartaV = new MemoriaCarta161;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 16;
			num = 1;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("É do cacau que se faz o chocolate. O estado da Bahia é o maior produtor de cacau do Brasil.");
			cartaV = new MemoriaCarta162;
			cartaV.stop();
			todasCartas.push(cartaV);
			tipo = 16;
			num = 2;
			todosTipos.push(tipo);
			todosNumeros.push(num);
			todasMensagens.push("É do cacau que se faz o chocolate. O estado da Bahia é o maior produtor de cacau do Brasil.");
			
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
			
			voltar.x = 707.95;
			voltar.y = 500.95;
			voltar.stop();
			fundo.addChild(voltar);
			
			lampada.x = 481.75;
			lampada.y = 21.75;
			lampada.stop();
			fundo.addChild(lampada);
			
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
					mensagem = todasMensagens[grid[i+numCartasX*j]];
					tipos.push(tipo);
					numeros.push(num);
					mensagens.push(mensagem);
					
					cartas.push(cartaV);
					fundo.addChild(cartaV);
					cartay += distX;
				}
				cartay = inicioRetY;
				cartax += distY;
			}
			
			pontuacao = new CacaPalavrasPontuacao(675, 55);
			fundo.addChild(pontuacao);
			
			menuAssociacao.stop();
			fundo.addChild(menuAssociacao);
			
		}
	}
}