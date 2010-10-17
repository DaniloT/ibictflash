package Ibict.Games.Cooperativa
{
	import Ibict.States.State;
	import Ibict.States.GameState;
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
		
	public class CooperativaMenuState extends State
	{
		
		/* Fundo do menu. */
		public var fundo : MovieClip;
		
		/* Botoes de dificuldade. */
		public var b1 : MovieClip;
		public var b2 : MovieClip;
		public var b3 : MovieClip;
		
		private var gameStateInstance : GameState;
		private var mainInstance : Main;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : errosCursor;
		
		public function CooperativaMenuState(){
			
			fundo = new CooperativaMenuFundo;
			
			b1 = new CooperativaMenuB1;
			b2 = new CooperativaMenuB2;
			b3 = new CooperativaMenuB3;
			
			b1.x = 57.85;
			b1.y = 243;
			b2.x = 285.85;
			b2.y = 243;
			b3.x = 513.85;
			b3.y = 243;
			
			fundo.addChild(b1);
			fundo.addChild(b2);
			fundo.addChild(b3);
			
			//myCursor =  new errosCursor();
			
		}
		
		public override function assume(previousState : State){
			
			root = new MovieClip();
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			root.addChild(fundo);
			
			//gameStateInstance.addMouse(myCursor);
			
			/* esconde o cursor padrao do mouse */
			//Mouse.hide();
			//myCursor.visible = false;
			//myCursor.x = Main.WIDTH/2;
			//myCursor.y = Main.HEIGHT/2;
			
			if (previousState != null){
				//mainInstance.stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			//mainInstance.stage.addChild(this.root);
			gameStateInstance.addGraphics(this.root);
			
		}
		
		public override function leave(){
			root.removeChild(fundo);
			//gameStateInstance.removeMouse();
			//Mouse.show();
		}
		
		public override function reassume(previousState:State){
			//myCursor.visible = true;
			//Mouse.hide();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			
			
			/* Atualiza a posicao do mouse na tela */
			//myCursor.x = input.getMousePoint().x;
			//myCursor.y = input.getMousePoint().y;
			
			//myCursor.visible = input.isMouseInside();
			
			//if (input.mouseClick() || input.mouseUnclick()){
			//	myCursor.play();
			//}
			
			if(input.mouseClick()){
				if(input.getMouseTarget() == b1){
					GameState.setCooperativaState(1);
				} else {
					if(input.getMouseTarget() == b2){
						GameState.setCooperativaState(2);
					} else {
						if(input.getMouseTarget() == b3){
							GameState.setCooperativaState(3);
						} else {
							if(input.getMousePoint().x < 230 && input.getMousePoint().y > 524) {
								GameState.setState(GameState.ST_MUNDO);
							}
						}
					}
				}
			}
			
		}

	}
}