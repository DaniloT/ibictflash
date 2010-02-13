package Ibict.States{
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Controla o Menu Principal do jogo (Splash Screen)
	 * 
	 * @author Bruno Zumba
	 */
	public class MenuState extends State{
		
		private var mainInstance : Main = Main.getInstance();
		private var inputInstance :InputManager = InputManager.getInstance();
		
		/* Parte de Layout do menu */
		private var newGame: menuNewGameBt;
		private var newGamePt: Point = new Point(195, 161);
		
		private var loadGame: menuLoadBt;
		private var loadGamePt: Point = new Point(195, 261);
		 
		private var credits: menuCreditsBt;
		private var creditsPt: Point = new Point(195, 361);
		
		public function MenuState(){
			root = new MovieClip();
			
			newGame = new menuNewGameBt();
			newGame.x = newGamePt.x;
			newGame.y = newGamePt.y;
			loadGame = new menuLoadBt();
			loadGame.x = loadGamePt.x;
			loadGame.y = loadGamePt.y;
			credits = new menuCreditsBt();
			credits.x = creditsPt.x;
			credits.y = creditsPt.y;
		}
		
		public override function assume(previousState:State){
			if(!mainInstance.stage.contains(this.root)){
				while(root.numChildren > 0){
					root.removeChildAt(0);
				}
				
				root.addChild(newGame);
				root.addChild(loadGame);
				root.addChild(credits);
				
				mainInstance.stage.addChild(this.root);
			}
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
		}
		
		public override function enterFrame(e:Event){
			if(inputInstance.mouseClick()){
				if(inputInstance.getMouseTarget() == newGame){
					trace("vai pra new game");
				} else if (inputInstance.getMouseTarget() == loadGame){
					trace("vai pra loadstate");
				} else if (inputInstance.getMouseTarget() == credits){
					trace("Mostra os créditos");
				}
			}
		}
		
	}
}