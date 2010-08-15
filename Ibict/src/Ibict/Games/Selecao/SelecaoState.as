package Ibict.Games.Selecao
{
	import Ibict.Main;
	import Ibict.States.GameState;
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
		var first : Boolean;
		
		private var gameStateInstance : GameState;
		
		public function SelecaoState()
		{
			// Scene root node...
			root = new MovieClip();
			root.added = false;
			gameStateInstance = GameState.getInstance();
						
		}
		
		public function setLevel(level : int) {
			platformer = new Platformer(level);
		}
		
		public override function assume(previousState : State)
		{
						
			if (previousState != null){
				//Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			
			//Main.getInstance().stage.addChild(this.root);
			gameStateInstance.addGraphics(this.root);
			
			this.root.addChild(platformer);
			
			/* inicializando timer */
			timer = new Timer(1);
			timer.start();
			atimer = 0;
			
			first = true;
			
			
		}
		
		public override function enterFrame(e : Event){
			
			dt = getTimer() - atimer;
			atimer = getTimer();
			
			if(first) {
				dt = 30;
				first = false;
			}
			
			platformer.update(dt);
			
			
		}

	}
}