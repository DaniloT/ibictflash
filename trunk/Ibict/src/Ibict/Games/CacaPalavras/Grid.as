package Ibict.Games.CacaPalavras
{
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.URLRequestHeader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Grid extends MovieClip
	{
		var size_x : int;
		var size_y : int;
		var posx, posy : int;
		var palavras : Array;
		var boolpalavras : Array;
		var dicas : Array;
		var espacamento : int;
		var espacamento_barradicas;
		var barradicas_posx : int;
		var barradicas_posy : int;
		
		
		
		
		/* gridArray - array de GridElements */
		var gridArray : Array;
		
		
		/* gridChards - array de text-fields que serao desenhados na tela */
		var gridChars : Array;
		
		var gridChar : TextField;
		
		var textFormatGrid : TextFormat;
		var barFormatInactive : TextFormat;
		var barFormatActive : TextFormat;
		
		var barraDicas : Array;
		var dicaTextField : TextField;
		
		private function ordenarPalavras() 
		{
			var mudou : Boolean;
			var string1 : String, string2 : String;
			var string3 : String, string4 : String;
			var i : int;
			
			mudou = true;
			
			while(mudou == true) {
				mudou = false;
				
				for(i=0; i<palavras.length - 1; i++) 
				{
					string1 = palavras[i];
					string2 = palavras[i+1];
					string3 = dicas[i];
					string4 = dicas[i+1];
					
					if(string1.length > string2.length) 
					{
						palavras[i] = string2;
						palavras[i+1] = string1;
						dicas[i] = string4;
						dicas[i+1] = string3;
						mudou = true;	
					}
				}
			}
			
			
			
		}
		
		public function update() 
		{
			var i : int;
			var j : int;
			var gridElement : GridElement;
			
			for(i = 0; i < size_x; i++) {
				for (j = 0; j < size_y; j++) {
					gridElement = gridArray[i + j*size_y];
					
					gridChar = gridChars[i + j*size_y];
					gridChar.text = gridElement.caractere;
				}
			}
		}

		public function verificaCompleto() : Boolean {
			var i : int;
			for (i=0; i < palavras.length; i++) {
				if(boolpalavras[i] == false) {
					return false;
				}
			}
			
			return true;
		}

		/** 
		 * Insere uma palavra no grid. 1 para horizontal, 0 para vertical e -1 para diagonal.
		 */ 
		private function inserePalavra(nroPalavra : int, posx : int, posy : int, horvert : int) 
		{
			var i : int;
			var palavra : String;
			var gridElement : GridElement;
			
			palavra = palavras[nroPalavra];
			trace("trytwo");
			trace(palavra);
			trace(posx);
			trace(posy);
			
			
			for(i = 0; i < palavra.length; i++) {
				if(horvert == 1) {
					gridElement = gridArray[posx + i + posy*size_y];
				} else if(horvert == 0) {
					gridElement = gridArray[posx + (posy + i)*size_y];
				} else {
					gridElement = gridArray[posx + i + (posy + i)*size_y];
				}
					
				gridElement.caractere = palavra.charAt(i);
				gridElement.usado = true;
				if(i == 0) {
					gridElement.addInicioPalavra(nroPalavra);
				} else if(i == palavra.length - 1) {
					gridElement.addFimPalavra(nroPalavra);
				}
				
			}
			
			
		}
		
		/**
		 * @param horvert 1 para horizontal, 0 para vertical e -1 para diagonal.
		 */
		private function verificaProvaveisPosicoes(nro : int, horvert : int):Array {
			var posicoes : Array;
			var palavra : String;
			
			var gridElement : GridElement;
			
			var rangeX : int;
			var rangeY : int;
			
			var posicaoValida : Boolean;
			
			var i : int;
			var j : int;
			var k : int;
			var counter;
			
			var posicao : int;
			
			counter = 0;
			
			posicoes = new Array();
			
			palavra = palavras[nro];
			
			/* calcula os ranges */
			
			
			if(horvert == 1) {
				rangeX = size_x - palavra.length;
				rangeY = size_y;
			} else if(horvert == 0) {
				rangeY = size_y - palavra.length;
				rangeX = size_x;
			} else {
				rangeX = size_x - palavra.length - 1;
				rangeY = size_y - palavra.length - 1;
			}
			
			/*
			if(horvert == 1) {
				rangeY = Math.round((Math.random()*(size_y - palavra.length)));
				rangeX = Math.round((Math.random()*size_x));
			} else if(horvert == 0) {
				rangeX = Math.round((Math.random()*(size_x - palavra.length)));
				rangeY = Math.round((Math.random()*size_y));
			} else {
				rangeX = Math.round((Math.random()*(size_x - palavra.length)));
				rangeY = Math.round((Math.random()*(size_y - palavra.length)));
			}			
			*/
			
			trace("tryone");
			trace(palavra);
			trace(rangeX, rangeY);
			/* procura as posicoes */
			for(i = 0; i < rangeX; i ++) {
				for(j = 0; j < rangeY; j ++) {
					/* verifica se a posicao é valida */
					posicaoValida = true;
					
					
					for(k = 0; k < palavra.length; k++) {
						if(horvert == 1) {
							gridElement = gridArray[i + k + j*size_y];
						} else if(horvert == 0) {
							gridElement = gridArray[i + (j + k)*size_y];
						} else {
							gridElement = gridArray[i + k + (j + k)*size_y];
						}
						
						if(gridElement == null) {
							posicaoValida = false;
							break;
						}
						
						if(gridElement.usado == true) {
							if(gridElement.caractere != palavra.charAt(k)) {
								posicaoValida = false;
								break;
							}
						}
					}
					
					if(posicaoValida) {
						posicao = i + j*size_y;
						posicoes[counter] = posicao;
						counter++;
					}
					
						
				}
			}
			
			return posicoes;
			
			
			
		}
		
		public function comparaPontos(pontoInicial : Point, pontoFinal : Point):int {
			var i :int;
			var j : int;
			var array1: Array;
			var array2: Array;
			
			var gelement : GridElement;
			
			/* obtendo o primeiro elemento */
			i = ((pontoInicial.x - posx)/(size_x*espacamento))*size_x;
			j = ((pontoInicial.y - posy)/(size_y*espacamento))*size_y;
			if((i<0)||(j<0)||(i>size_x - 1)||(j>size_y -1)) {
				return -1;
			}
			
			gelement = gridArray[i + j*size_y];
			array1 = gelement.palavrastart;
			
			/* obtendo o segundo elemento */
			i = ((pontoFinal.x - posx)/(size_x*espacamento))*size_x;
			j = ((pontoFinal.y - posy)/(size_y*espacamento))*size_y;
			
			if((i<0)||(j<0)||(i>size_x - 1)||(j>size_y -1)) {
				return -1;
			}
			
			gelement = gridArray[i + j*size_y];
			array2 = gelement.palavrafim;
		
			
			for(i = 0; i < array1.length; i++) {
				for(j = 0; j < array1.length; j++) {
					trace(array1[i]);
					trace(array2[j]);
					if(array1[i] == array2[j]) {
						boolpalavras[array1[i]] = true;
						return array1[i];
					}
				}
			}
			
			return -1;

		}
		
		/**
		 * Decide onde ira inserir as palavras e insere.
		 * 
		 */
		private function decideInserePalavras() 
		{
			/* primeiro inserindo a primeira palavra */
			var palavra : String;
			var horvert : int;
			var randomNumber : int;
			var randomPosX : int;
			var randomPosY : int;
			var loopcount : int;
			var posicoes : Array;
			
			palavra = palavras[0];
			
			/* calculando se será horizontal, vertical ou diagonal */
			randomNumber = Math.round((Math.random()*10));
			if((randomNumber >= 0 && randomNumber < 4)) {
				horvert = 1;
				randomPosX = Math.round((Math.random()*(size_x - palavra.length)));
				randomPosY = Math.round((Math.random()*size_y));
			} else if((randomNumber >=4 && randomNumber < 8)) {
				randomPosY = Math.round((Math.random()*(size_y - palavra.length)));
				randomPosX = Math.round((Math.random()*size_x));
				horvert = 0;
			} else {
				randomPosX = Math.round((Math.random()*(size_x - palavra.length)));
				randomPosY = Math.round((Math.random()*(size_y - palavra.length)));
				horvert = -1;
			}
			
			trace("LOL");
			trace(randomPosX);
			trace(randomPosY);
			trace(horvert);
			//inserePalavra(0, 1, 1, -1);
			inserePalavra(0, randomPosX, randomPosY, horvert);
			
			/* inserindo as outras palavras */
			if(palavras.length > 1) {
				for(loopcount = 1; loopcount < palavras.length; loopcount++) {
					trace("entered here!!");
					randomNumber = Math.round((Math.random()*10));
					
					if((randomNumber >= 0 && randomNumber < 4)) {
						horvert = 1;
					} else if((randomNumber >=4 && randomNumber < 8)) {
						horvert = 0;
					} else {
						horvert = -1;
					}
					
					posicoes = verificaProvaveisPosicoes(loopcount, horvert);
					trace("Len:");
					trace(posicoes.length);
					if(posicoes.length == 0) {
						posicoes = verificaProvaveisPosicoes(loopcount, -1);
						horvert = -1;
						if(posicoes.length == 0) {
							posicoes =verificaProvaveisPosicoes(loopcount, 0);
							horvert = 0;
							if(posicoes.length == 0) {
								posicoes = verificaProvaveisPosicoes(loopcount, 1);
								horvert = 1; 
								if(posicoes.length ==0) continue;
							}
						}
					}
					
					
					randomNumber = Math.round((Math.random()*(posicoes.length-1)));
					
					inserePalavra(loopcount, posicoes[randomNumber]%size_y, Math.floor((posicoes[randomNumber]/size_y)), horvert);
					
					trace("LOL");
					trace(posicoes[randomNumber]/size_y);
					trace(posicoes[randomNumber]%size_y);
					trace(horvert);
					
					
				}
			}
			
			
			
				
		}
		
		private function randomizaResto() {
			var i, j : int;
			var gelement : GridElement;
			
			for(i = 0; i < size_x; i++) {
				for (j = 0; j < size_y; j++) {
					gelement = gridArray[i + j*size_y];
					if(gelement.usado == false) {
						gelement.randomizeChar();
					}
				
				}
			}
			
		}
		
		public function pintaElementoBarra(nro : int) {
			var textField : TextField;
			
			textField = barraDicas[nro];
			textField.defaultTextFormat = barFormatActive;
			textField.text = textField.text;
		}
		
		
		public function Grid(size_x : int, size_y : int, palavras : Array, dicas : Array, posx : int, posy : int, bdposx : int, bdposy: int, blurFilter : BlurFilter)
		{
			var i : int;
			var j : int;
			var gelement : GridElement;
			var palavra_string : String;
			
			
			this.espacamento = 20;
			
			
			
			this.size_x = size_x;
			this.size_y = size_y;
			this.posx = posx;
			this.posy = posy;
			this.palavras = palavras;	
			this.dicas = dicas;
			
			/* habilitando o formato de fonte da grid */
			textFormatGrid = new TextFormat();
			textFormatGrid.font = "tahoma";
			textFormatGrid.size = 18;
			
			boolpalavras = new Array(palavras.length);
			
			
			for(i = 0; i < palavras.length; i++ ){
				palavra_string = palavras[i];
				palavras[i] = palavra_string.toUpperCase();
				boolpalavras[i] = false;
			}
			
			ordenarPalavras();
			
			gridArray = new Array(size_x*size_y);
			gridChars = new Array(size_x*size_y);
			
			for(i = 0; i < size_x; i++) {
				for (j = 0; j < size_y; j++) {
					gridArray[i + j*size_y] = new GridElement(null);
					gridChars[i + j*size_y] = new TextField();
					gridChar = gridChars[i + j*size_y];
					gridChar.selectable = false;
					gridChar.defaultTextFormat = textFormatGrid;
					gridChar.x = posx + i*espacamento;
					gridChar.y = posy + j*espacamento;
					gridChar.selectable = false;
					
					gelement = gridArray[i + j*size_y];
					//gelement.randomizeChar();
					gridChar.filters = [blurFilter];
					addChild(gridChar);
					
				}
			}
			
			/* determinando formatos da barra de dicas */
			barFormatInactive = new TextFormat();
			barFormatActive = new TextFormat();
			
			barFormatInactive.font = "tahoma";
			barFormatInactive.size = 11;
			barFormatActive.font = "tahoma";
			barFormatActive.size = 11;
			barFormatActive.color = 0x00FF00;
			
			
			/* criando a barra de dicas */
			barradicas_posx = bdposx;
			barradicas_posy = bdposy;
			
			espacamento_barradicas = 30;
			
			barraDicas = new Array(dicas.length);
			for(i=0; i < dicas.length; i++) {
				dicaTextField = new TextField();
				dicaTextField.defaultTextFormat = barFormatInactive;
				dicaTextField.text = dicas[i];
				dicaTextField.x = barradicas_posx;
				dicaTextField.y = barradicas_posy + espacamento_barradicas*i;
				dicaTextField.selectable = false;
				dicaTextField.width = 200;
				dicaTextField.height = 100;
				barraDicas[i] = dicaTextField;
				dicaTextField.filters = [blurFilter];
				
				addChild(dicaTextField);
				
			}
			
			for(i = 0; i < palavras.length; i++ ){
				trace(palavras[i]);
			}
			
			
			decideInserePalavras();
			randomizaResto();
			
			
			
			
			

			
		}
		
		

	}
}