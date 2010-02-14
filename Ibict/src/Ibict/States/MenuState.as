package Ibict.States{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Profile.Profile;
	
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
		
		private var newGameScreen : menuNewGameScreen;
		
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
			
			newGameScreen = new menuNewGameScreen();
			newGameScreen.x = 100;
			newGameScreen.y = 210;
		}
		
		public override function assume(previousState:State){
			if(!mainInstance.stage.contains(this.root)){
				while(this.root.numChildren > 0){
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
				trace("Target: "+inputInstance.getMouseTarget());
				if(inputInstance.getMouseTarget() == newGame){
					/* Tela que inicia um novo jogo */
					while(root.numChildren>0){
						root.removeChildAt(0);
					}
					
					root.addChild(newGameScreen);
					mainInstance.stage.focus = newGameScreen.charName;
				} else if (inputInstance.getMouseTarget() == loadGame){
					mainInstance.setState(Main.ST_LOAD);
				} else if (inputInstance.getMouseTarget() == credits){
					trace("Mostra os créditos");
				}
				
				if(inputInstance.getMouseTarget() == newGameScreen.confirmBt){
					trace("length: "+newGameScreen.charName.text.length);
					if (newGameScreen.charName.text.length > 1){
						GameState.profile = new Profile(newGameScreen.charName.text);
						GameState.profile.save();
						//mainInstance.setState(Main.ST_GAME);
					}
				} else if (inputInstance.getMouseTarget() == newGameScreen.backBt){
					/* Tela do menu principal */
					newGameScreen.charName.text = "";
					while(root.numChildren>0){
						root.removeChildAt(0);
					}
					
					root.addChild(newGame);
					root.addChild(loadGame);
					root.addChild(credits);
				}
			}
		}
		
		private function startNewGame(){
			
			
			
		}
		
	}
}