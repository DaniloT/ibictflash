package Ibict.Games.CacaPalavras
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CacaPalavrasPontuacao extends MovieClip
	{
		var pontuacao : int;
		var pontuacaoText : TextField;
		var textFormat : TextFormat;
		
		public function addPoints(valor : int) {
			pontuacao += valor;
			pontuacaoText.text = pontuacao.toString();			
		}
		
		public function CacaPalavrasPontuacao(posx : int, posy : int)
		{
			pontuacao = 0;
			
			this.x = posx;
			this.y = posy;
			
			pontuacaoText = new TextField();
			pontuacaoText.x = 0;
			pontuacaoText.y = 0;
			
			textFormat = new TextFormat();
			textFormat.font = "tahoma";
			textFormat.size = 17;
			textFormat.color = 0xFFFFFF;
			
			pontuacaoText.defaultTextFormat = textFormat;
			pontuacaoText.text = pontuacao.toString();
			
			addChild(pontuacaoText);
		}
		
		public function getPoints() : int {
			return pontuacao;
		}

	}
}