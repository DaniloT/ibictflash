package Ibict.States{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.Profile.LoadState;
	
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
		 
		private var credits: menuCreditsBt;
		private var creditsPt: Point = new Point(250, 412);
		
		private var loadGame: menuLoadBt;
		private var loadGamePt: Point = new Point(250, 484);
		
		private var logo : logoJogoErres;
		private var logoPt : Point = new Point(55, 60);
		
		private var creditos : telaCreditos;
		
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
		private const TELA_CREDITOS = 2;
		private var tela : int;
		
		/* identificador de animacao */
		private var animando : Boolean;
		
		/* direcao do alpha */
		private var alphaDir : Number;
		
		private var sexo : int;
		private const MASCULINO = 0;
		private const FEMININO = 1;

		private var video : MovieClip;


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
			logo = new logoJogoErres();
			logo.x = logoPt.x;
			logo.y = logoPt.y;
			
			fundoComGlass = new mainMenuFundoComGlass();
			fundoSemGlass = new mainMenuFundoSemGlass();
			fundoEscolheNome = new mainFundoEscolheNome();
			creditos = new telaCreditos();
			
			newGameScreen = new menuNewGameScreen();
			newGameScreen.x = 50;
			newGameScreen.y = 140;
			
			video = null;
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
				
				mostraMenu();
				
				mainInstance.stage.addChild(this.root);
				
			}
			
			
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e:Event){
			if (video != null)  {
				if (video.currentFrame >= video.totalFrames) {
					video.stop();
					root.removeChild(video);
					video = null;
					mainInstance.setState(Main.ST_GAME);
				}
			}
			else {
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
						
						sexo = MASCULINO;
						newGameScreen.meninoButton.gotoAndPlay(2);
						newGameScreen.meninaButton.gotoAndStop(1);
						newGameScreen.charName.text = "";
						
						mainInstance.stage.focus = newGameScreen.charName;
					} else if (inputInstance.getMouseTarget() == loadGame.ldbt){
						mainInstance.setState(Main.ST_LOAD);
					} else if (inputInstance.getMouseTarget() == credits){
						tela = TELA_CREDITOS;
						while(root.numChildren>0){
							root.removeChildAt(0);
						}
						
						root.addChild(creditos);
					}  
					
					
					
					//Define o sexo do jogador
					if(inputInstance.getMouseTarget() == newGameScreen.meninoButton.menino){
						newGameScreen.meninoButton.gotoAndPlay(2);
						newGameScreen.meninaButton.gotoAndStop(1);
						sexo = MASCULINO;
					} else if (inputInstance.getMouseTarget() == newGameScreen.meninaButton.menina){
						newGameScreen.meninoButton.gotoAndStop(1);
						newGameScreen.meninaButton.gotoAndPlay(2);
						sexo = FEMININO;
					} 
					
					if((inputInstance.getMouseTarget() == newGameScreen.confirmBt) || 
						(inputInstance.kbClick(Keyboard.ENTER) && 
							mainInstance.stage.focus == newGameScreen.charName)){
						criaProfile();
						
					} else if (inputInstance.getMouseTarget() == newGameScreen.backBt){
						/* Tela do menu principal */
						newGameScreen.charName.text = "";
						mostraMenu();
						
					} else if (inputInstance.getMouseTarget() == creditos.backBt){
						mostraMenu();
					}
				}
			}
		}
		
		private function mostraMenu(){
			while(root.numChildren>0){
				root.removeChildAt(0);
			}
			
			root.addChild(fundoComGlass);
			
			root.addChild(logo);
			root.addChild(newGame);
			root.addChild(loadGame);
			root.addChild(credits);
			
			if (LoadState.getSaveCount() <= 0){
				loadGame.gotoAndStop(2);
			} else {
				loadGame.gotoAndStop(1);
			}  
			
			root.addChild(fundoSemGlass);
			
			fundoSemGlass.x = 0;
			alpha = 1;
			fundoSemGlass.alpha = 1;
		}
		
		private function criaProfile(){
			if (newGameScreen.charName.text.length > 1) {
				if(sexo == MASCULINO) {
					GameState.profile.create(newGameScreen.charName.text, "M");
					video = new abrFilmeMenino();
				}
				else {
					GameState.profile.create(newGameScreen.charName.text, "F");
					video = new abrFilmeMenina();
				}
				musica.stop(true);
				
				root.addChild(video);
				video.play();
			}
		}	
	}
}
