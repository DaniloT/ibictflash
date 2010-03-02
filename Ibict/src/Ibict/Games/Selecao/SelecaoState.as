package Ibict.Games.Selecao
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SelecaoState extends State
	{
		var platformer : Platformer;
		
		public function SelecaoState()
		{
			// Scene root node...
			root = new MovieClip();
			root.added = false;
			
			platformer = new Platformer();
			this.root.addChild(platformer);
			
			
			
		}
		
		public override function assume(previousState : State)
		{
						
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			
			
			Main.getInstance().stage.addChild(this.root);
			
			
		}
		
		public override function enterFrame(e : Event){
			platformer.update();
			
		}

	}
}