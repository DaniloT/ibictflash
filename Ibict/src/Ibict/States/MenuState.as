package Ibict.States{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * Controla o Menu Principal do jogo (Splash Screen)
	 * 
	 * @author Bruno Zumba
	 */
	public class MenuState extends State{			
		
		private var mainInstance : Main = Main.getInstance();
		private var inputInstance :InputManager = InputManager.getInstance();
		
		private var musica : Music;
		
		/* Parte de Layout do menu */
		private var newGame: menuNewGameBt;
		private var newGamePt: Point = new Point(250, 340);
		
		private var loadGame: menuLoadBt;
		private var loadGamePt: Point = new Point(250, 412);
		 
		private var credits: menuCreditsBt;
		private var creditsPt: Point = new Point(250, 484);
		
		/* alpha do fundo */
		private var alpha : Number;
		
		private var newGameScreen : menuNewGameScreen;
		
		/* fundos */
		private var fundoSemGlass : MovieClip;
		private var fundoComGlass : MovieClip;
		private var fundoEscolheNome : MovieClip;
		
		/* identificador de tela */
		private const TELA_PRINCIPAL = 0;
		private const TELA_ESCOLHA_NOME = 1;
		private var tela : int;
		
		/* identificador de animacao */
		private var animando : Boolean;
		
		/* direcao do alpha */
		private var alphaDir : Number;
		
		private var sexo : int;
		private const MASCULINO = 0;
		private const FEMININO = 1;
		
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
			
			fundoComGlass = new mainMenuFundoComGlass();
			fundoSemGlass = new mainMenuFundoSemGlass();
			fundoEscolheNome = new mainFundoEscolheNome();
			
			newGameScreen = new menuNewGameScreen();
			newGameScreen.x = 50;
			newGameScreen.y = 140;
		}
		
		public override function assume(previousState:State){
			musica = new Music(new MusicaMundo, false, 20);
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			
			alpha = 1;
			fundoSemGlass.x = 0;
			fundoSemGlass.alpha = 1;
			
			if(!mainInstance.stage.contains(this.root)){
				tela = TELA_PRINCIPAL;
				while(this.root.numChildren > 0){
					root.removeChildAt(0);
				}
				
				root.addChild(fundoComGlass);
				
				
				root.addChild(newGame);
				root.addChild(loadGame);
				root.addChild(credits);
				
				root.addChild(fundoSemGlass);
				
				mainInstance.stage.addChild(this.root);
				
			}
			
			
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e:Event){
			alpha -= 0.1;
			if(alpha < 0) {
				alpha = 0;
				fundoSemGlass.x = 1200;
			} 
			fundoSemGlass.alpha = alpha;
			
			
			if(inputInstance.mouseClick()){
				//trace("Target: "+inputInstance.getMouseTarget());
				if(inputInstance.getMouseTarget() == newGame){
					/* Tela que inicia um novo jogo */
					tela = TELA_ESCOLHA_NOME;
					while(root.numChildren>0){
						root.removeChildAt(0);
					}
					
					root.addChild(fundoEscolheNome);
					root.addChild(newGameScreen);
					root.addChild(fundoSemGlass);
					
					fundoSemGlass.x = 0;
					alpha = 1;
					fundoSemGlass.alpha = 1;
					
					newGameScreen.sexom.visible = true;
					newGameScreen.sexof.visible = false;
					sexo = MASCULINO;
					newGameScreen.charName.text = "";
					
					mainInstance.stage.focus = newGameScreen.charName;
				} else if (inputInstance.getMouseTarget() == loadGame){
					mainInstance.setState(Main.ST_LOAD);
				} else if (inputInstance.getMouseTarget() == credits){
					trace("Mostra os créditos");
				}
				
				
				
				//Define o sexo do jogador
				if(inputInstance.getMouseTarget() == newGameScreen.meninoButton){
					newGameScreen.sexom.visible = true;
					newGameScreen.sexof.visible = false;
					sexo = MASCULINO;
				} else if (inputInstance.getMouseTarget() == newGameScreen.meninaButton){
					newGameScreen.sexom.visible = false;
					newGameScreen.sexof.visible = true;
					sexo = FEMININO;
				} 
				
				if((inputInstance.getMouseTarget() == newGameScreen.confirmBt) || 
					(inputInstance.kbClick(Keyboard.ENTER) && 
						mainInstance.stage.focus == newGameScreen.charName)){
					criaProfile();
					
				} else if (inputInstance.getMouseTarget() == newGameScreen.backBt){
					/* Tela do menu principal */
					newGameScreen.charName.text = "";
					while(root.numChildren>0){
						root.removeChildAt(0);
					}
					
					root.addChild(fundoComGlass);
					
					root.addChild(newGame);
					root.addChild(loadGame);
					root.addChild(credits);
					
					
					root.addChild(fundoSemGlass);
					
					fundoSemGlass.x = 0;
					alpha = 1;
					fundoSemGlass.alpha = 1;
				}
			}
		}
		
		private function criaProfile(){
			if (newGameScreen.charName.text.length > 1){
				if(sexo == MASCULINO)
					GameState.profile.create(newGameScreen.charName.text, "M");
				else 
					GameState.profile.create(newGameScreen.charName.text, "F");
				musica.stop(true);
				
				mainInstance.setState(Main.ST_CREATE);
			}
		}	
	}
}