package Ibict.Games.Selecao
{
	import Ibict.Util.Temporizador;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Relogio extends MovieClip
	{
		var seg : int, min : int;
		var countInicial : int;
		var segAtual : int, minAtual : int;
		var timer : Temporizador;
		
		var text : TextField;
		var textFormat : TextFormat;
		var hud : MovieClip;
		
		
		public function Relogio(min : int, seg : int)
		{
			this.min = min;
			this.seg = seg;
			
			countInicial = (min*60 + seg)*1000;
			
			timer = new Temporizador();
			
			textFormat = new TextFormat();
			textFormat.font = "tahoma";
			textFormat.size = 14;
			
			hud = new selectHudTempo();
			this.addChild(hud);
			
			text = new TextField();
			text.defaultTextFormat = textFormat;
			text.text = "X";
			text.x = 104;
			text.y = 17;
			this.addChild(text);
		}
		
		public function start() {
			timer.start();
		}
		
		public function isZero() : Boolean {
			var tempo : int;
			tempo = countInicial - timer.getCount();
			if(tempo < 0)
				return true;
			else
				return false;
		}
		
		public function update() {
			var tempo : int;
			var countAtual : int;
			
			tempo = timer.getCount();
			countAtual = countInicial - tempo;
			if(countAtual < 0) countAtual = 0;
			
			segAtual = (countAtual/1000)%60;
			minAtual = countAtual/60000;
			
			
			text.text = "";
			if((minAtual) < 10) {
				text.appendText("0");
			}
			text.appendText((minAtual).toString());
			text.appendText(":");
			if((segAtual) < 10) {
				text.appendText("0");
			}
			text.appendText((segAtual).toString());
			
		}
		
		
	}
}