//Estrelas: 10000 - 12500 - 21000 - 25000 - 34000 - 35500

package Ibict.Games.Memoria
{
	import Ibict.States.State;
	import Ibict.States.GameState;
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
		
	public class MemoriaMenuState extends State
	{
		
		/* Fundo do menu. */
		public var fundo : MovieClip;
		
		/* Botoes de dificuldade. */
		public var dif1 : MovieClip;
		public var dif2 : MovieClip;
		public var dif3 : MovieClip;
		
		private var gameStateInstance : GameState;
		private var mainInstance : Main;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : errosCursor;	
		
		public function MemoriaMenuState(){
			
			fundo = new MemoriaMenuFundo;
			
			dif1 = new MemoriaMenuDif8;
			dif2 = new MemoriaMenuDif16;
			dif3 = new MemoriaMenuDif24;
			
			dif1.x = 307.5;
			dif1.y = 159.35;
			dif2.x = 307.5;
			dif2.y = 281.35;
			dif3.x = 307.5;
			dif3.y = 403.35;
			
			fundo.addChild(dif1);
			fundo.addChild(dif2);
			fundo.addChild(dif3);
			
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
				if(input.getMouseTarget() == dif1){
					GameState.setMemoriaState(1);
				} else {
					if(input.getMouseTarget() == dif2){
						GameState.setMemoriaState(2);
					} else {
						if(input.getMouseTarget() == dif3){
							GameState.setMemoriaState(3);
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