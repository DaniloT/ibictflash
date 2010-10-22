package Ibict.Games.Memoria
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
		
	public class MemoriaMenuState extends State
	{
		
		/* Fundo do menu. */
		public var fundo : MovieClip;
		
		/* Botoes de dificuldade. */
		public var dif1 : MovieClip;
		public var dif2 : MovieClip;
		public var dif3 : MovieClip;
		
		/* Estrelas. */
		public var s1 : MovieClip;
		public var s2 : MovieClip;
		public var s3 : MovieClip;
		public var s4 : MovieClip;
		public var s5 : MovieClip;
		public var s6 : MovieClip;
		
		private var gameStateInstance : GameState;
		private var mainInstance : Main;
		
		private var textFormat2 : TextFormat;
		private var exclamacao : MovieClip;
		private var mensagemMissoes : MovieClip;
		private var descricaoEstrelasFase : TextField;
		private var descricaoPontuacao : TextField;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : errosCursor;	
		
		public function MemoriaMenuState(){
			
			fundo = new MemoriaMenuFundo;
			
			dif1 = new MemoriaMenuDif8;
			dif2 = new MemoriaMenuDif16;
			dif3 = new MemoriaMenuDif24;
			
			dif1.x = 62.85;
			dif1.y = 203.35;
			dif2.x = 295.8;
			dif2.y = 203.35;
			dif3.x = 527.8;
			dif3.y = 203.35;
			
//			dif1.x = 307.5;
//			dif1.y = 159.35;
//			dif2.x = 307.5;
//			dif2.y = 281.35;
//			dif3.x = 307.5;
//			dif3.y = 403.35;
			
			fundo.addChild(dif1);
			fundo.addChild(dif2);
			fundo.addChild(dif3);
			
			//myCursor =  new errosCursor();
			
			textFormat2 = new TextFormat();
			textFormat2.font = "tahoma";
			textFormat2.size = 18;
			textFormat2.color = 0x053E05;
			
			mensagemMissoes = new comumMensagemMissoes();
			mensagemMissoes.x = 53;
			mensagemMissoes.y = 400;
			
			exclamacao = new comumInfoExclamation();
			
			exclamacao.x = 53 + 5;
			exclamacao.y = 400 + 40;
			
			fundo.addChild(mensagemMissoes);
			fundo.addChild(exclamacao);
			
		}
		
		public override function assume(previousState : State){
			var prox : String;
			var proxNum : int;
			
			root = new MovieClip();
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			if (descricaoEstrelasFase != null) {
				fundo.removeChild(descricaoEstrelasFase);
			}
			if (s1 != null) {
				fundo.removeChild(s1);
			}
			if (s2 != null) {
				fundo.removeChild(s2);
			}
			if (s3 != null) {
				fundo.removeChild(s3);
			}
			if (s4 != null) {
				fundo.removeChild(s4);
			}
			if (s5 != null) {
				fundo.removeChild(s5);
			}
			if (s6 != null) {
				fundo.removeChild(s6);
			}
			if (descricaoPontuacao != null) {
				fundo.removeChild(descricaoPontuacao);
			}
			
			descricaoEstrelasFase = new TextField();
			
			descricaoEstrelasFase.x = 53 + 31;
			descricaoEstrelasFase.y = 400 + 37;
			
			descricaoEstrelasFase.defaultTextFormat = textFormat2;
			
			proxNum = GameState.profile.memoriaData.getStarCount();
			if (proxNum == 0) {
				prox = "Ganhe qualquer pontuação positiva.";
			} else {
				s1 = new comumStar;
				s1.x = 269;
				s1.y = 337.8;
				fundo.addChild(s1);
				if (proxNum == 1) {
					prox = "12500 Pontos.";
				} else {
					s2 = new comumStar;
					s2.x = 313.95;
					s2.y = 337.8;
					fundo.addChild(s2);
					if (proxNum == 2) {
						prox = "21000 Pontos.";
					} else {
						s3 = new comumStar;
						s3.x = 358.95;
						s3.y = 337.8;
						fundo.addChild(s3);
						if (proxNum == 3) {
							prox = "25000 Pontos.";
						} else {
							s4 = new comumStar;
							s4.x = 403.95;
							s4.y = 337.8;
							fundo.addChild(s4);
							if (proxNum == 4) {
								prox = "34000 Pontos.";
							} else {
								s5 = new comumStar;
								s5.x = 449.95;
								s5.y = 337.8;
								fundo.addChild(s5);
								if (proxNum == 5) {
									prox = "35500 Pontos.";
								} else {
									s6 = new comumStar;
									s6.x = 495.95;
									s6.y = 337.8;
									fundo.addChild(s6);
									if (proxNum == 6) {
										prox = "Você obteve todas as estrelas!";
									} else {
										prox = "Você obteve mais estrelas que possível! Cheater!";
									}
								}
							}
						}
					}
				}
			}
			
			descricaoEstrelasFase.text = "As estrelas serão dadas de acordo com a sua pontuação.\nPróxima estrela: " + prox;
			descricaoEstrelasFase.width = 700;
			
			descricaoPontuacao = new TextField();
			descricaoPontuacao.x = 430;
			descricaoPontuacao.y = 70;
			descricaoPontuacao.defaultTextFormat = textFormat2;
			descricaoPontuacao.text = "Pontuação Máxima Obtida: " + GameState.profile.memoriaData.getPont().toString();
			descricaoPontuacao.width = 700;
			
			fundo.addChild(descricaoEstrelasFase);
			
			fundo.addChild(descricaoPontuacao);
			
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