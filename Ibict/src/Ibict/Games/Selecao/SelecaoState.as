package Ibict.Games.Selecao
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class SelecaoState extends State
	{
		var platformer : Platformer;
		var timer : Timer;
		var atimer : int;
		var dt : int;
		
		public function SelecaoState()
		{
			// Scene root node...
			root = new MovieClip();
			root.added = false;
			
			platformer = new Platformer();
			this.root.addChild(platformer);
			
			/* inicializando timer */
			timer = new Timer(1);
			timer.start();
			atimer = 0;
			
			
			
		}
		
		public override function assume(previousState : State)
		{
						
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			
			
			Main.getInstance().stage.addChild(this.root);
			
			
		}
		
		public override function enterFrame(e : Event){
			
			dt = getTimer() - atimer;
			atimer = getTimer();
			
			platformer.update(dt);
			
			
		}

	}
}