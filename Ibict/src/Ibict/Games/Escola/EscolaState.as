package Ibict.Games.Escola
{
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	import Ibict.InputManager;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class EscolaState extends State
	{
		private var musica : Music;
		private var gameStateInstance : GameState;
		
		private var caca : MovieClip;
		private var mem : MovieClip;
		private var quebra : MovieClip;


		public function EscolaState() {
			super();

			this.root = new MovieClip();
			this.gameStateInstance = GameState.getInstance();
			
			this.root.addChild(new Bitmap(new escFundo(0, 0)));
			
			var f : Font = new fntImgSelector();
			var format : TextFormat = new TextFormat();
			format.font = f.fontName;
			format.align = TextFormatAlign.CENTER;
			format.size = 25;
			format.color = 0xFFFFFF;
			format.bold = true;

			caca = new BotaoEscolaCaca();
			caca.x = 220;
			caca.y = 130;
			this.root.addChild(caca);
			
			mem = new BotaoEscolaJogoMem();
			mem.x = caca.x;
			mem.y = caca.y + 120;
			this.root.addChild(mem);
			
			quebra = new BotaoEscolaQuebra();
			quebra.x = mem.x;
			quebra.y = mem.y + 120;
			this.root.addChild(quebra);
		}

		public override function assume(previousState : State) {
			musica = new Music(new MusicaMemoria, false, 20);

			if (previousState != null){
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}

			gameStateInstance.addGraphics(root);
		}

		public override function leave() {
			musica.stop(true);
		}

		public override function enterFrame(e : Event) {
			var input : InputManager = InputManager.getInstance();
			
			if(input.mouseClick()){
				if(input.getMouseTarget() == caca){
					GameState.setEscolaState(1);
				} else {
					if(input.getMouseTarget() == mem){
						GameState.setEscolaState(2);
					} else {
						if(input.getMouseTarget() == quebra){
							GameState.setEscolaState(3);
						} else {
							if(input.getMousePoint().x < 230 && input.getMousePoint().y > 524) {
								GameState.setState(GameState.ST_MUNDO);
							}
						}
					}
				}
			}
		}
	}
}
