package Ibict.Games.SeletorFases
{
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	
	public class SeletorFasesState
	{
		var fundo : MovieClip;
		var fase : Array;
		var star : Array;
		
		public function SeletorFasesState() extends State
		{
			fase = new Array(5);
			star = new Array(10);
		}
		
		public override function assume(previousState : State) {
			
		}
		
		public override function enterFrame(e : Event) {
			
		}

	}
}