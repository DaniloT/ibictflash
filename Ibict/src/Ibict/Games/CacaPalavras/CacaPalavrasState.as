package Ibict.Games.CacaPalavras
{	
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class CacaPalavrasState extends State
	{
		/* figura onde estara os erros */
		private var palavrasCruzadas : CacaPalavras;
		private var gameStateInstance : GameState;
		private var dificuldade : int;
		
		private var musica : Music;
		
		public static const SUPERFACIL = 0;
		public static const FACIL = 1;
		public static const MEDIO = 2;
		public static const DIFICIL = 3;
		public static const SUPERDIFICIL = 4; 
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : errosCursor;			
				
		public function CacaPalavrasState(){
			dificuldade = 0;
			Mouse.show();
			root = new MovieClip();
			var lineDraw: MovieClip = new MovieClip();
									
			//trace("terminou!!");
			gameStateInstance = GameState.getInstance();
			
			

		}
		
		public override function assume(previousState : State)
		{
						
			musica = new Music(new MusicaMemoria, false, 20);
			
			if (previousState != null){
				//Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			palavrasCruzadas = new CacaPalavras(this.root, dificuldade);
			//Main.getInstance().stage.addChild(this.root);
			gameStateInstance.addGraphics(this.root);
			
			
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public function setDificulty(dificuldade : int) {
			this.dificuldade = dificuldade;
			
		}
	
		
		public override function enterFrame(e : Event){
			palavrasCruzadas.update();
			
		}
	}
}