package Ibict.States
{
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class PauseState extends State{
		
		private var mainInstance : Main;
		private var inputInstance : InputManager
		
		/* O pauseState vai ter 2 roots visíveis na tela:
		O root do estado anterior: que ficará "em segundo plano"
		e o root do pauseState, que poderá contar uma tela escrito "Pause"
		ou qualquer outras coisas 
		O "rootPause" estará dentro de "root"*/
		private var rootPause : MovieClip
		
		private var previous : State;
		
		private var pause : pauseScreen;
		
		public function PauseState(){
			root = new MovieClip();
			rootPause = new MovieClip();
			previous = new State();
			pause = new pauseScreen();
			
			mainInstance = Main.getInstance();
			inputInstance = InputManager.getInstance();
		}
		
		public override function assume(previousState : State){
			previous = previousState;
			pause.x = 300;
			pause.y = 100;
			
			if(!mainInstance.stage.contains(this.root)){
				root.addChild(pause);
				mainInstance.stage.addChild(this.root);
			}			
		}
		
		public override function leave(){
			
		}
		
		public override function enterFrame(e : Event){
			if(inputInstance.isDown(Keyboard.SPACE) && inputInstance.mouseClick()){
				/* Sai do pause */
				GameState.setState(GameState.beforePauseConst);
			}
			if(inputInstance.mouseClick()){
				if(inputInstance.getMouseTarget() == pause.pauseReturnBt){
				/* Sai do pause */
				GameState.setState(GameState.beforePauseConst);
				} else if (inputInstance.getMouseTarget() == pause.pauseExitBt){
					/* Retorna pro MundoState */
					/* Retira a arvore de gráficos do estado antes do pause */
					var rootAux : MovieClip = GameState.beforePause.getGraphicsRoot()
					mainInstance.stage.removeChild(rootAux);
					//rootAux.added = false;
					GameState.setState(GameState.ST_MUNDO);
				}
			}			
		}
	}
}