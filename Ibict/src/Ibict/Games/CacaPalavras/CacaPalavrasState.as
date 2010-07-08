package Ibict.Games.CacaPalavras
{	
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class CacaPalavrasState extends State
	{
		/* figura onde estara os erros */
		private var palavrasCruzadas : CacaPalavras;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : errosCursor;			
				
		public function CacaPalavrasState(){
			
			Mouse.show();
			root = new MovieClip();
			var lineDraw: MovieClip = new MovieClip();
									
			trace("terminou!!");
			
			

		}
		
		public override function assume(previousState : State)
		{
						
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			
			palavrasCruzadas = new CacaPalavras(this.root);
			Main.getInstance().stage.addChild(this.root);
			
			
		}
	
		
		public override function enterFrame(e : Event){
			palavrasCruzadas.update();
			
		}
	}
}