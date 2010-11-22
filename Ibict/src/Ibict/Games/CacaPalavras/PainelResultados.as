package Ibict.Games.CacaPalavras
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PainelResultados extends MovieClip
	{
		var dicas : Array;
		var palavras : Array;
		var fundo : MovieClip;
		
		var textoAux : TextField;
		var textFormatDicas : TextFormat;
		var textFormatPalavras : TextFormat;
		
		var dicasTextFields : Array;
		var palavrasTextFields : Array;
		
		const DICAS_X : int = 110;
		const DICAS_Y : int = 170;
		const PALAVRAS_X : int = 9550;
		const PALAVRAS_Y : int = 9170; 
		
		private function retiraUmaLinha(dicas : Array) : Array {
			var newDicas : Array;
			var i, j : int;
			var stringAux : String;
			var stringAux2 : String;
			
			
			
			newDicas = new Array(dicas.length);
			
			for(i = 0; i < dicas.length; i++) {
				var toggle : int;
				
				
				stringAux = dicas[i];
				stringAux2 = new String("");
				
				toggle = 0;
				for(j = 0; j < stringAux.length; j++) {
					if(stringAux.charAt(j) == "\n" && ((toggle%2) == 0)) {
						toggle++;
						stringAux2 = stringAux2.concat(" ");
					} else {
						stringAux2 = stringAux2.concat(stringAux.charAt(j));
					}
				}
				
				newDicas[i] = stringAux2;
				
			}
			
			return newDicas;
		}
		
		private function retiraLinhas(string : String) : String {
			var i : int;
			var espaco : String = " ";
			
			for(i = 0; i < string.length; i++) {
				if(string.charAt(i) == "\n") {
					string = string.slice(0, i).concat(espaco.concat(string.slice(i+1, string.length)));	
				}
			}
			
			return string;
		}
		
		public function adicionaLinhasDicas(jump : int) {
			var i, j, k : int;
			var string : String;
			var troca : Boolean;
			var linha : String = "\n";
			
			troca = false;
			
			for(i = 0; i < dicas.length; i++) {
				string = retiraLinhas(dicas[i]);
				
				j = jump;
				while(j < string.length) {
					troca = false;
					
					k = j;
					do {
						if(string.charAt(k) == " ") {
							troca = true;
							string = string.slice(0, k).concat(linha.concat(string.slice(k+1, string.length)));
						}
						k--;
					} while(k > 0 && !troca);
					j = k + jump;
				}
				
				dicas[i] = string;
			}
		}
	
		
		public function PainelResultados(dicas_param : Array, palavras_param : Array)
		{
			var i : int;
			var pos_dicas_y : int;
			var pos_palavras_y : int;
			var separadorVertical : MovieClip;
			var separadorHorizontal : MovieClip;
 			
			this.dicas = retiraUmaLinha(dicas_param);
			this.palavras = palavras_param;
			
			adicionaLinhasDicas(50);
			
			dicasTextFields = new Array(dicas.length);
			palavrasTextFields = new Array(dicas.length);
			
			fundo = new CacaPainelRespostas();
			
			this.addChild(fundo);
			
			pos_dicas_y = DICAS_Y;
			pos_palavras_y = PALAVRAS_Y;
			
			textFormatDicas = new TextFormat();
			textFormatPalavras = new TextFormat();
			
			textFormatDicas.font = "tahoma";
			textFormatDicas.size = 17;
			
			textFormatPalavras.font = "tahoma";
			textFormatPalavras.size = 17;
			
			separadorVertical = new CacaSeparadorVertical();
			
			separadorVertical.x = PALAVRAS_X - 10;
			separadorVertical.y = PALAVRAS_Y;
			
			this.addChild(separadorVertical);
			
			
			
			
			
			for(i = 0; i < dicas.length; i++) {
				var espacamento, nro_linhas : int;
				
				/* calculando o espaçamento */
				nro_linhas = Grid.contaLinhas(dicas[i]);
				switch(nro_linhas) {
					case 0:
						espacamento = 30;
						break;
					case 1:
						espacamento = 50;
						break;
					case 2:
						espacamento = 65;
						break;
					default:
						espacamento = 75;
						break;			
				}				
				
				textoAux = new TextField();
				textoAux.text = dicas[i];
				textoAux.x = DICAS_X;
				textoAux.y = pos_dicas_y;
				textoAux.setTextFormat(textFormatDicas);
				textoAux.width = 500;
				textoAux.height = 100;
				textoAux.selectable = false;
				dicasTextFields[i] = textoAux;
				
				textoAux = new TextField();
				textoAux.text = palavras[i];
				textoAux.x = PALAVRAS_X;
				textoAux.y = pos_palavras_y;
				textoAux.width = 500;
				textoAux.height = 100;
				textoAux.setTextFormat(textFormatPalavras);
				textoAux.selectable = false;
				palavrasTextFields[i] = textoAux;
				
				pos_dicas_y += espacamento;
				pos_palavras_y += espacamento;
				
				separadorHorizontal = new CacaSeparadorHorizontal();
				separadorHorizontal.x = DICAS_X - 4;
				separadorHorizontal.y = pos_dicas_y  - 10;
				
				this.addChild(separadorHorizontal);
				
				
				this.addChild(dicasTextFields[i]);
				this.addChild(palavrasTextFields[i]);				
			}

		}

	}
}