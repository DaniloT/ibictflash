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
		const DICAS_Y : int = 200;
		const PALAVRAS_X : int = 450;
		const PALAVRAS_Y : int = 200; 
	
		
		public function PainelResultados(dicas : Array, palavras : Array)
		{
			var i : int;
			var pos_dicas_y : int;
			var pos_palavras_y : int;
 			
			this.dicas = dicas;
			this.palavras = palavras;
			
			dicasTextFields = new Array(dicas.length);
			palavrasTextFields = new Array(dicas.length);
			
			pos_dicas_y = DICAS_Y;
			pos_palavras_y = PALAVRAS_Y;
			
			textFormatDicas = new TextFormat();
			textFormatPalavras = new TextFormat();
			
			textFormatDicas.font = "tahoma";
			textFormatDicas.size = 17;
			
			textFormatPalavras.font = "tahoma";
			textFormatPalavras.size = 17;
			
			
			
			for(i = 0; i < dicas.length; i++) {
				var espacamento, nro_linhas : int;
				
				/* calculando o espaçamento */
				nro_linhas = Grid.contaLinhas(dicas[i]);
				switch(nro_linhas) {
					case 0:
						espacamento = 20;
						break;
					case 1:
						espacamento = 30;
						break;
					case 2:
						espacamento = 40;
						break;
					default:
						espacamento = 50;
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
				
				this.addChild(dicasTextFields[i]);
				this.addChild(palavrasTextFields[i]);				
			}

		}

	}
}