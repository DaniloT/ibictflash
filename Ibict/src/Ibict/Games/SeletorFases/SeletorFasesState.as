package Ibict.Games.SeletorFases
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SeletorFasesState  extends State
	{
		var fundo : MovieClip;
		var fase : Array;
		var star : Array;
		
		public function SeletorFasesState()
		{
			fase = new Array(5);
			star = new Array(10);
			fundo = new selecaoFasesFundo();
			
			root = new MovieClip();
			
		}
		
		public override function assume(previousState : State) {
			var i : int;
			
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.getInstance().stage.addChild(this.root);
			
			this.root.addChild(fundo);
			
			fase[0] = new selecaoFasesFase01();
			fase[1] = new selecaoFasesFase02desativado();
			fase[2] = new selecaoFasesFase03desativado();
			fase[3] = new selecaoFasesFase04desativado();
			fase[4] = new selecaoFasesFase05desativado();
			
			
			for(i = 0; i < 5; i++) {
				this.root.addChild(fase[i]);
			}
			
			for(i = 0; i < 10; i++) {
				
			}
		}
		
		public override function enterFrame(e : Event) {
			
		}

	}
}