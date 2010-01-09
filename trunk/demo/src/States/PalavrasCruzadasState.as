package States
{
	import PalavrasCruzadas.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	public class PalavrasCruzadasState extends State
	{
		/* figura onde estara os erros */
		private var palavrasCruzadas : PalavrasCruzadas;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : CursorSeteErros;			
				
		public function PalavrasCruzadasState(){
			
			Mouse.show();
			root = new MovieClip();
			
			palavrasCruzadas = new PalavrasCruzadas(this.root);
			
			
			trace("terminou!!");
	
			
			

		}
		
		public override function assume(previousState : State)
		{
						
			if (previousState != null){
				Main.stage_g.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.stage_g.addChild(this.root);
			
			
		}
		
		public override function enterFrame(e : Event){
			palavrasCruzadas.update();
			
		}
	}
}