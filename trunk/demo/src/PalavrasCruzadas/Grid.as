package PalavrasCruzadas
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Grid
	{
		var size_x : int;
		var size_y : int;
		var palavras : Array;
		
		/* gridArray - array de GridElements */
		var gridArray : Array;
		
		
		/* gridChards - array de text-fields que serao desenhados na tela */
		var gridChars : Array;
		var root : MovieClip;
		
		var gridChar : TextField;
		
		private function ordenarPalavras() 
		{
			var mudou : Boolean;
			var string1 : String, string2 : String;
			var i : int;
			
			mudou = true;
			
			while(mudou == true) {
				mudou = false;
				
				for(i=0; i<palavras.length - 1; i++) 
				{
					string1 = palavras[i];
					string2 = palavras[i+1];
					
					if(string1.length > string2.length) 
					{
						palavras[i] = string2;
						palavras[i+1] = string1;
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
		
		/** 
		 * Insere uma palavra no grid. 1 para horizontal, 0 para vertical e -1 para diagonal.
		 */ 
		private function inserePalavra(nroPalavra : int, posx : int, posy : int, horvert : int) 
		{
			var i : int;
			var palavra : String;
			var gridElement : GridElement;
			
			palavra = palavras[nroPalavra];
			
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
						if(posicoes.length == 0) {
							posicoes =verificaProvaveisPosicoes(loopcount, 0);
							if(posicoes.length == 0) {
								posicoes = verificaProvaveisPosicoes(loopcount, 1);
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
		
		public function Grid(size_x : int, size_y : int, palavras : Array, posx : int, posy : int, root : MovieClip)
		{
			var i : int;
			var j : int;
			var gelement : GridElement;
			var palavra_string : String;
			
			this.root = root;
			
			
			this.size_x = size_x;
			this.size_y = size_y;
			this.palavras = palavras;	
			
			for(i = 0; i < palavras.length; i++ ){
				palavra_string = palavras[i];
				palavras[i] = palavra_string.toUpperCase();
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
					gridChar.x = posx + i*17;
					gridChar.y = posy + j*17;
					gridChar.selectable = false;
					
					gelement = gridArray[i + j*size_y];
					//gelement.randomizeChar();
					root.addChild(gridChar);
					
				}
			}
			
			for(i = 0; i < palavras.length; i++ ){
				trace(palavras[i]);
			}
			
			
			decideInserePalavras();
			randomizaResto();
			
			
			

			
		}
		
		

	}
}