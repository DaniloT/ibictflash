package Ibict.Games.Cooperativa
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
		
	public class CooperativaMenuState extends State
	{
		
		/* Fundo do menu. */
		public var fundo : MovieClip;
		
		/* Botoes de brinquedos. */
		public var b1 : MovieClip;
		public var b2 : MovieClip;
		public var b3 : MovieClip;
		public var b4 : MovieClip;
		public var b5 : MovieClip;
		
		/* Estrelas. */
		public var s1 : MovieClip;
		public var s2 : MovieClip;
		public var s3 : MovieClip;
		public var s4 : MovieClip;
		public var s5 : MovieClip;
		
		private var gameStateInstance : GameState;
		private var mainInstance : Main;
		
		private var textFormat2 : TextFormat;
		private var exclamacao : MovieClip;
		private var mensagemMissoes : MovieClip;
		private var descricaoEstrelasFase : TextField;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : errosCursor;
		
		public function CooperativaMenuState(){
			
			fundo = new CooperativaMenuFundo;
			
			b1 = new CooperativaMenuB1;
			b2 = new CooperativaMenuB2;
			b3 = new CooperativaMenuB3;
			b4 = new CooperativaMenuB4;
			b5 = new CooperativaMenuB5;
			
			b1.x = 64.85;
			b1.y = 124.35;
			b2.x = 294.85;
			b2.y = 124.35;
			b3.x = 524.85;
			b3.y = 124.35;
			b4.x = 168.8;
			b4.y = 260.35;
			b5.x = 412.8;
			b5.y = 260.35;
			
			fundo.addChild(b1);
			fundo.addChild(b2);
			fundo.addChild(b3);
			fundo.addChild(b4);
			fundo.addChild(b5);
			
			//myCursor =  new errosCursor();
			
			textFormat2 = new TextFormat();
			textFormat2.font = "tahoma";
			textFormat2.size = 18;
			textFormat2.color = 0x053E05;
			
			mensagemMissoes = new comumMensagemMissoes();
			mensagemMissoes.x = 53;
			mensagemMissoes.y = 400;
			
			descricaoEstrelasFase = new TextField();
			
			descricaoEstrelasFase.x = 53 + 31;
			descricaoEstrelasFase.y = 400 + 37;
			
			descricaoEstrelasFase.defaultTextFormat = textFormat2;
			
			descricaoEstrelasFase.text = "Você ganhará uma estrela para cada brinquedo diferente montado.";
			descricaoEstrelasFase.width = 700;
			
			exclamacao = new comumInfoExclamation();
			
			exclamacao.x = 53 + 5;
			exclamacao.y = 400 + 30;
			
			fundo.addChild(mensagemMissoes);
			fundo.addChild(descricaoEstrelasFase);
			fundo.addChild(exclamacao);
			
		}
		
		public override function assume(previousState : State){
			
			root = new MovieClip();
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
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
			
			if (GameState.profile.cooperativaData.getStar(0)) {
				s1 = new comumStar;
				s1.x = b1.x + 167;
				s1.y = b1.y + 65.85;
				fundo.addChild(s1);
			}
			
			if (GameState.profile.cooperativaData.getStar(1)) {
				s2 = new comumStar;
				s2.x = b2.x + 167;
				s2.y = b2.y + 65.85;
				fundo.addChild(s2);
			}
			
			if (GameState.profile.cooperativaData.getStar(2)) {
				s3 = new comumStar;
				s3.x = b3.x + 167;
				s3.y = b3.y + 65.85;
				fundo.addChild(s3);
			}
			
			if (GameState.profile.cooperativaData.getStar(3)) {
				s4 = new comumStar;
				s4.x = b4.x + 167;
				s4.y = b4.y + 65.85;
				fundo.addChild(s4);
			}
			
			if (GameState.profile.cooperativaData.getStar(4)) {
				s5 = new comumStar;
				s5.x = b5.x + 167;
				s5.y = b5.y + 65.85;
				fundo.addChild(s5);
			}
			
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
							if(input.getMouseTarget() == b4){
								GameState.setCooperativaState(4);
							} else {
								if(input.getMouseTarget() == b5){
									GameState.setCooperativaState(5);
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

	}
}