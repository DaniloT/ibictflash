package Ibict.Games.CacaPalavras
{
	import Ibict.Util.Temporizador;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Relogio extends MovieClip
	{
		var seg : int, min : int;
		var segAtual : int, minAtual : int;
		var timer : Temporizador;
		
		var text : TextField;
		var textFormat : TextFormat;
		var hud : MovieClip;
		
		
		public function Relogio(min : int, seg : int)
		{
			this.min = min;
			this.seg = seg;
			
			timer = new Temporizador();
			
			textFormat = new TextFormat();
			textFormat.font = "tahoma";
			textFormat.size = 14;
			
			hud = new selectHudTempo();
			this.addChild(hud);
			
			text = new TextField();
			text.defaultTextFormat = textFormat;
			text.text = "X";
			text.x = 100;
			text.y = 20;
			this.addChild(text);
		}
		
		public function start() {
			timer.start();
		}
		
		public function update() {
			var tempo : int;
			tempo = timer.getCount();
			
			segAtual = (tempo/1000)%60;
			minAtual = tempo/60000;
			
			
			text.text = "";
			if((min - minAtual) < 10) {
				text.appendText("0");
			}
			text.appendText((min - minAtual).toString());
			text.appendText(":");
			if((seg - segAtual) < 10) {
				text.appendText("0");
			}
			text.appendText((seg - segAtual).toString());
			
		}
		
		
	}
}