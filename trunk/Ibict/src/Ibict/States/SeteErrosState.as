package Ibict.States
{
	import Ibict.Main;
	import Ibict.InputManager;
	import Ibict.Games.SeteErros.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	
	public class SeteErrosState extends State
	{
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
			
			myCursor =  new CursorSeteErros();
		}
		
		public override function assume(previousState : State){
			/*Adciona os elementos de 'cena' na animacao*/
			root.addChild(cena.fundo);
			root.addChild(myCursor);
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor.visible = false;
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			
			mainInstance.stage.addChild(this.root);
		}
		
		public override function leave(){
			root.removeChild(cena.fundo);
			root.removeChild(myCursor);
			Mouse.show();
			
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			
			/* Atualiza a posicao do mouse na tela */
			myCursor.x = input.getMousePoint().x;
			myCursor.y = input.getMousePoint().y;
			
			myCursor.visible = input.isMouseInside();
			
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
			
			/* checa cliques do mouse e visibilidade do cursor */
			if (input.mouseClick() || input.mouseUnclick()){
				myCursor.play();
			}
					
		}
	}
}