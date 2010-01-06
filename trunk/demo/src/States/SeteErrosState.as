package States
{
	import SeteErros.*;
	
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.events.Event;
	
	
	public class SeteErrosState extends State
	{
		/* figura onde estara os erros */
		private var cena : Cena;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : MyCursorClass;
		
		public function SeteErrosState()
		{
			cena = new Cena(0);
			root = new MovieClip();
			root.addChild(cena.figura);
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor =  new MyCursorClass();
			myCursor.gotoAndStop(5);
			root.addChild(myCursor);
			GameState.myCursor.visible = false;
		}
		
		public override function assume(previousState : State)
		{
						
			Main.stage_g.addChild(this.root);
			
			
		}
		
		public override function enterFrame(e : Event)
		{
		}

	}
	
	
}