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
		const PALAVRAS_X : int = 550;
		const PALAVRAS_Y : int = 170; 
		
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
	
		
		public function PainelResultados(dicas_param : Array, palavras_param : Array)
		{
			var i : int;
			var pos_dicas_y : int;
			var pos_palavras_y : int;
			var separadorVertical : MovieClip;
			var separadorHorizontal : MovieClip;
 			
			this.dicas = retiraUmaLinha(dicas_param);
			this.palavras = palavras_param;
			
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
						espacamento = 60;
						break;
					default:
						espacamento = 70;
						break;			
				}				
				
				textoAux = new TextField();
				textoAux.text = dicas[i];
				textoAux.x = DICAS_X;
				textoAux.y = pos_dicas_y;
				textoAux.setTextFormat(textFormatDicas);
				textoAux.width = 500;
				textoAux.height = 100;
				dicasTextFields[i] = textoAux;
				
				textoAux = new TextField();
				textoAux.text = palavras[i];
				textoAux.x = PALAVRAS_X;
				textoAux.y = pos_palavras_y;
				textoAux.width = 500;
				textoAux.height = 100;
				textoAux.setTextFormat(textFormatPalavras);
				palavrasTextFields[i] = textoAux;
				
				pos_dicas_y += espacamento;
				pos_palavras_y += espacamento;
				
				separadorHorizontal = new CacaSeparadorHorizontal();
				separadorHorizontal.x = DICAS_X;
				separadorHorizontal.y = pos_dicas_y  - 10;
				
				this.addChild(separadorHorizontal);
				
				
				this.addChild(dicasTextFields[i]);
				this.addChild(palavrasTextFields[i]);				
			}

		}

	}
}