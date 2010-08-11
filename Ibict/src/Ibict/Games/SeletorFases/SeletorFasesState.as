package Ibict.Games.SeletorFases
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	public class SeletorFasesState  extends State
	{
		var fundo : MovieClip;
		var fase : Array;
		var star : Array;
		var selecionado : Array;
		var inputManager : InputManager;
		var glowFilter : Array;
		
		public function SeletorFasesState()
		{
			var i : int;
			fase = new Array(5);
			selecionado = new Array(5);
			star = new Array(10);
			fundo = new selecaoFasesFundo();
			glowFilter = new Array(5);
			
			root = new MovieClip();
			inputManager = InputManager.getInstance();
			
			for(i = 0; i < 5; i++) {
				glowFilter[i] = new GlowFilter(0x0D8E0D, .75, 0, 0, 2, 2);
			}

			
		}
		
		public override function assume(previousState : State) {
			var i : int;
			var mclip : MovieClip;

			
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
			
			fase[0].x = 80;
			fase[0].y = 140;
			fase[1].x  = 310;
			fase[1].y = 140;
			fase[2].x = 540;
			fase[2].y = 140;
			fase[3].x = 195;
			fase[3].y = 265;
			fase[4].x = 425;
			fase[4].y = 265;
			
			
			
			
			for(i = 0; i < 5; i++) {
				this.root.addChild(fase[i]);
				selecionado[i] = false;
				mclip = fase[i];
				mclip.filters = [glowFilter[i]];
			}
			
			for(i = 0; i < 10; i++) {
				
			}
		}
		
		public override function enterFrame(e : Event) {
			var mclip : MovieClip;
			var i : int;
			
			if(inputManager.getMousePoint().x < 230 &&
				inputManager.getMousePoint().y > 524 &&
				inputManager.mouseClick()) {
					GameState.setState(GameState.ST_MUNDO);
				}
				
				
			for(i = 0; i < 5; i++) {
				mclip = fase[i];
				if(inputManager.isMouseInsideMovieClip(fase[i])) {
					selecionado[i] = true;
					if(inputManager.mouseClick()) {
						GameState.setSelecaoLevelState(i + 1);
					}
				} else {
					selecionado[i] = false;
				}
	
				if(selecionado[i]) {
					glowFilter[i].blurX += 3;
					if(glowFilter[i].blurX > 25) glowFilter[i].blurX = 25;
					mclip.filters = [glowFilter[i]];
				} else {
					glowFilter[i].blurX -= 3;
					if(glowFilter[i].blurX < 0) glowFilter[i].blurX = 0;
					mclip.filters = [glowFilter[i]];
				}
				
				
				
			}
			
		}

	}
}