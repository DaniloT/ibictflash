package Ibict.States {
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Estado que controla o a criação do avatar
	 * 
	 * @author Bruno Zumba
	 */
	public class AvatarCreationState extends State{
		
		/** Posição na tela do Menu. */
		private static const POSICAO_MENU : Point = new Point(25,125);
		/** Posição do avatar na tela. */
		private static const POSICAO_AVATAR : Point = new Point(320,120);  
		
		private var mainInstance : Main;
		private var inputInstance : InputManager
		
		/** Menu Lateral que controla a criação do avatar */
		private var menuLateral : perfilMenuEscolha;
		/** Avatar do jogador */
		private var avatar : MovieClip;
		
		private var fundo : MovieClip;
		private var fundoCima : MovieClip;
		
		private var alpha : Number;
		
		
		
		
		public function AvatarCreationState(){
			root = new MovieClip();
			menuLateral = new perfilMenuEscolha();
			menuLateral.x = POSICAO_MENU.x;
			menuLateral.y = POSICAO_MENU.y;

			
			fundo = new fundoTelaAvatar();
			fundoCima = new mainMenuFundoSemGlass();
			
			
			
			mainInstance = Main.getInstance();
			inputInstance = InputManager.getInstance();
		}
		
		public override function assume(previousState : State){
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			
			if(!mainInstance.stage.contains(this.root)){
				while(this.root.numChildren > 0){
					root.removeChildAt(0);
				}
				
				alpha = 1;
				fundoCima.x = 0;
				fundoCima.alpha = 1;
				
				root.addChild(fundo);
				root.addChild(menuLateral);
				
				/* Testa o sexo que o jogador escolheu e 
				põe o modelo de avatar equivalente na tela */
				if(GameState.profile.sexo == "M"){
					avatar = new avatarMenino();
				} else {
					avatar = new avatarMenina();
				}
				
				avatar.x = POSICAO_AVATAR.x;
				avatar.y = POSICAO_AVATAR.y;
				root.addChild(avatar);
				
				root.addChild(fundoCima);
				
				mainInstance.stage.addChild(this.root);
			}	
		}
		
		public override function enterFrame(e : Event){
			
			alpha -= 0.1;
			fundoCima.alpha = alpha;
			if(alpha < 0) {
				alpha = 0;
				fundoCima.x = 1200;
			}
			
			if(inputInstance.mouseClick()){
				
				testaCliqueMenu(inputInstance.getMouseTarget());
				
				/*Se o jogador clica em "Confirma" salva no 
				perfil um id para os itens escolhidos do avatar. */
				if (inputInstance.getMouseTarget() == menuLateral.confirmaBt){
					GameState.profile.setCabeca(avatar.cabecaFrente.currentFrame);
					GameState.profile.setCabelo(avatar.cabeloFrente.currentFrame);
					GameState.profile.setOculos(avatar.oculosFrente.currentFrame);
					GameState.profile.setOlho(avatar.olhoFrente.currentFrame);
					GameState.profile.setRoupa(avatar.roupaFrente.currentFrame);
					GameState.profile.setSapato(avatar.sapatoFrente.currentFrame);
					
					GameState.profile.save();
					
					mainInstance.setState(Main.ST_GAME);
				} 
			}
		}
		
		//Checa o clique do jogador com o menu
		private function testaCliqueMenu(target:Object){
			
			//cabelo direita
			if(target == menuLateral.cabeloDirBt){
				if (avatar.cabeloFrente.currentFrame == avatar.cabeloFrente.totalFrames) {
					avatar.cabeloFrente.gotoAndStop(1);
					avatar.cabeloLado.gotoAndStop(1);
				} else {
					avatar.cabeloFrente.nextFrame();
					avatar.cabeloLado.nextFrame();
				}
			//cabelo esquerda
			} else if(target == menuLateral.cabeloEsqBt){
				if (avatar.cabeloFrente.currentFrame == 1) {
					avatar.cabeloFrente.gotoAndStop(avatar.cabeloFrente.totalFrames);
					avatar.cabeloLado.gotoAndStop(avatar.cabeloLado.totalFrames);
				} else {
					avatar.cabeloFrente.prevFrame();
					avatar.cabeloLado.prevFrame();
				}
			//oculos direita
			} else if(target == menuLateral.oculosDirBt){
				if (avatar.oculosFrente.currentFrame == avatar.oculosFrente.totalFrames) {
					avatar.oculosFrente.gotoAndStop(1);
					avatar.oculosLado.gotoAndStop(1);
				} else {
					avatar.oculosFrente.nextFrame();
					avatar.oculosLado.nextFrame();
				}
			//oculos esquerda
			} else if(target == menuLateral.oculosEsqBt){
				if (avatar.oculosFrente.currentFrame == 1) {
					avatar.oculosFrente.gotoAndStop(avatar.oculosFrente.totalFrames);
					avatar.oculosLado.gotoAndStop(avatar.oculosLado.totalFrames);
				} else {
					avatar.oculosFrente.prevFrame();
					avatar.oculosLado.prevFrame();
				}
			//olho direita
			} else if(target == menuLateral.olhoDirBt){
				if (avatar.olhoFrente.currentFrame == avatar.olhoFrente.totalFrames) {
					avatar.olhoFrente.gotoAndStop(1);
					avatar.olhoLado.gotoAndStop(1);
				} else {
					avatar.olhoFrente.nextFrame();
					avatar.olhoLado.nextFrame();
				}
			//oculos esquerda
			} else if(target == menuLateral.olhoEsqBt){
				if (avatar.olhoFrente.currentFrame == 1) {
					avatar.olhoFrente.gotoAndStop(avatar.olhoFrente.totalFrames);
					avatar.olhoLado.gotoAndStop(avatar.olhoLado.totalFrames);
				} else {
					avatar.olhoFrente.prevFrame();
					avatar.olhoLado.prevFrame();
				}
			//cabeca direita
			} else if(target == menuLateral.cabecaDirBt){
				if (avatar.cabecaFrente.currentFrame == avatar.cabecaFrente.totalFrames) {
					avatar.cabecaFrente.gotoAndStop(1);
					avatar.cabecaLado.gotoAndStop(1);
				} else {
					avatar.cabecaFrente.nextFrame();
					avatar.cabecaLado.nextFrame();
				}
			//cabeca esquerda
			} else if(target == menuLateral.cabecaEsqBt){
				if (avatar.cabecaFrente.currentFrame == 1) {
					avatar.cabecaFrente.gotoAndStop(avatar.cabecaFrente.totalFrames);
					avatar.cabecaLado.gotoAndStop(avatar.cabecaLado.totalFrames);
				} else {
					avatar.cabecaFrente.prevFrame();
					avatar.cabecaLado.prevFrame();
				}
			//roupa direita
			} else if(target == menuLateral.roupaDirBt){
				if (avatar.roupaFrente.currentFrame == avatar.roupaFrente.totalFrames) {
					avatar.roupaFrente.gotoAndStop(1);
					avatar.roupaLado.gotoAndStop(1);
				} else {
					avatar.roupaFrente.nextFrame();
					avatar.roupaLado.nextFrame();
				}
			//roupa esquerda
			} else if(target == menuLateral.roupaEsqBt){
				if (avatar.roupaFrente.currentFrame == 1) {
					avatar.roupaFrente.gotoAndStop(avatar.roupaFrente.totalFrames);
					avatar.roupaLado.gotoAndStop(avatar.roupaLado.totalFrames);
				} else {
					avatar.roupaFrente.prevFrame();
					avatar.roupaLado.prevFrame();
				}
			//sapatodireita
			} else if(target == menuLateral.sapatoDirBt){
				if (avatar.sapatoFrente.currentFrame == avatar.sapatoFrente.totalFrames) {
					avatar.sapatoFrente.gotoAndStop(1);
					avatar.sapatoLado.gotoAndStop(1);
				} else {
					avatar.sapatoFrente.nextFrame();
					avatar.sapatoLado.nextFrame();
				}
			//sapato esquerda
			} else if(target == menuLateral.sapatoEsqBt){
				if (avatar.sapatoFrente.currentFrame == 1) {
					avatar.sapatoFrente.gotoAndStop(avatar.sapatoFrente.totalFrames);
					avatar.sapatoLado.gotoAndStop(avatar.sapatoLado.totalFrames);
				} else {
					avatar.sapatoFrente.prevFrame();
					avatar.sapatoLado.prevFrame();
				}
			}
		}
		
	}
}