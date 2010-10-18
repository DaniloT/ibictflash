package Ibict.Games.Cooperativa
{
	import Ibict.States.State;
	import Ibict.States.GameState;
	import Ibict.InputManager;
	import Ibict.Main;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.text.TextField;
	import flash.text.TextFormat;
		
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