package Ibict.States
{
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	/**
	 * Estado que controla o jogo quando ele está pausado
	 * 
	 * @author Bruno Zumba
	 */
	public class PauseState extends State{
		
		private var mainInstance : Main;
		private var inputInstance : InputManager
		
		private var rootPause : MovieClip
		
		/* Estado anterior ao pause (que o chamou)*/
		private var previous : State;
		
		/* Tela que aparecerá quando o jogo for pausado */
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
					mainInstance.stage.removeChild(GameState.beforePause.getGraphicsRoot());
					GameState.setState(GameState.ST_MUNDO);
				}
			}			
		}
	}
}