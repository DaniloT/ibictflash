package Ibict.Games.SeteErros
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	
	public class SeteErrosState extends State{
		private var mainInstance : Main;
		
		/* figura onde estara os erros */
		private var cena : Cena;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : CursorSeteErros;
				
		public function SeteErrosState(){
			mainInstance = Main.getInstance();
			
			cena = new Cena(0);
			root = new MovieClip();
			root.added = false;
			
			myCursor =  new CursorSeteErros();
			
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
		}
		
		public override function assume(previousState : State){
			trace("voltando ao sete erros. Before pause const: "+GameState.beforePauseConst);
			if (!root.added){
				/*Adciona os elementos de 'cena' na animacao*/
				root.addChild(cena.fundo);
				root.added = true;
				
				mainInstance.stage.addChild(this.root);
			}
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor.visible = false;
			
			if (previousState != null){
				var rootAux:MovieClip;
				rootAux = previousState.getGraphicsRoot();
				mainInstance.stage.removeChild(rootAux);
				rootAux.added = false;
			}
			root.addChild(myCursor);
			
		}
		
		public override function leave(){
			//myCursor.visible = false;
			root.removeChild(myCursor);
			Mouse.show();
			
		}
		
		public override function reassume(previousState:State){
			myCursor.visible = true;
			Mouse.hide();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			
			/* Atualiza a posicao do mouse na tela */
			myCursor.x = input.getMousePoint().x;
			myCursor.y = input.getMousePoint().y;
			
			/*Testa se clicou em um erro da cena*/
			if(input.mouseClick()) {
				for(var i:int=0; i<cena.erros.length; i++){
					if(input.getMouseTarget() == cena.erros[i]){
						trace("clicou no lugar certo");
						
						/*Troca na cena a figura correta com a errada*/
						cena.fundo.addChild(cena.acertos[i]);
						cena.fundo.swapChildren(cena.erros[i], cena.acertos[i]);
						cena.fundo.removeChild(cena.erros[i]);
						
						cena.qtdErros--;
						
						if(cena.qtdErros <= 0){
							trace("Parabéns, vc ganhou");
							Main.getInstance().setState(Main.ST_GAME);
						}
					}
				}
			}
			
			/*Anda com o cenario qnd o jogador aperta as setas do teclado*/
			if(input.isDown(Keyboard.LEFT)){
				if(cena.fundo.x + cena.fundo.width > Main.WIDTH){
					cena.fundo.x -= 5;
				}
			}
			if(input.isDown(Keyboard.SHIFT)){
				if(root.visible == true){
					root.visible = false;
					trace("setou como false");
				} else {
					root.visible = true;
					trace("setou como true");
				}
			}
			if(input.isDown(Keyboard.RIGHT)){
				if(cena.fundo.x < 0){
					cena.fundo.x += 5;
				}
			}
			if(input.isDown(Keyboard.UP)){
				if(cena.fundo.y + cena.fundo.height > Main.HEIGHT){
					cena.fundo.y -= 5;
				}
			}
			if(input.isDown(Keyboard.DOWN)){
				if(cena.fundo.y < 0){
					cena.fundo.y += 5;
				}
			}
			if(input.isDown(Keyboard.SPACE)){
				GameState.setState(GameState.ST_PAUSE);
			}
			
			/* checa cliques do mouse e visibilidade do cursor */
			if (input.mouseClick() || input.mouseUnclick()){
				myCursor.play();
			}
			myCursor.visible = input.isMouseInside();
					
		}
	}
}