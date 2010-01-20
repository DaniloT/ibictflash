package Ibict.States
{
	import Ibict.Main;
	import Ibict.Games.SeteErros.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	
	public class SeteErrosState extends State
	{
		/* figura onde estara os erros */
		private var cena : Cena;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : CursorSeteErros;			
				
		public function SeteErrosState(){
			
			cena = new Cena(0);
			root = new MovieClip();
			
			/*Adciona os elementos de 'cena' na animacao*/
			root.addChild(cena.fundo);
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			
			myCursor =  new CursorSeteErros();
			root.addChild(myCursor);
			myCursor.visible = false;
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
		}
		
		public override function assume(previousState : State){
						
			if (previousState != null){
				Main.stage_g.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.stage_g.addChild(this.root);
			
			
		}
		
		public override function enterFrame(e : Event){
			
			/*Testa se clicou em um erro da cena*/
			if(Main.input.mouseClick()) {
				for(var i:int=0; i<cena.erros.length; i++){
					if(Main.input.getMouseTarget() == cena.erros[i]){
						trace("clicou no lugar certo");
						
						/*Troca na cena a figura correta com a errada*/
						cena.fundo.addChild(cena.acertos[i]);
						cena.fundo.swapChildren(cena.erros[i], cena.acertos[i]);
						cena.fundo.removeChild(cena.erros[i]);
					}
				}
			}
			
			/*Anda com o cenario qnd o jogador aperta as setas do teclado*/
			if(Main.input.isDown(Keyboard.LEFT)){
				if(cena.fundo.x + cena.fundo.width > Main.WIDTH){
					cena.fundo.x -= 5;
				}
			}
			if(Main.input.isDown(Keyboard.RIGHT)){
				if(cena.fundo.x < 0){
					cena.fundo.x += 5;
				}
			}
			if(Main.input.isDown(Keyboard.UP)){
				if(cena.fundo.y + cena.fundo.height > Main.HEIGHT){
					cena.fundo.y -= 5;
				}
			}
			if(Main.input.isDown(Keyboard.DOWN)){
				if(cena.fundo.y < 0){
					cena.fundo.y += 5;
				}
			}

			
			/* Atualiza a posicao do mouse na tela */
			myCursor.x = Main.input.getMousePoint().x;
			myCursor.y = Main.input.getMousePoint().y;
			
			/* checa cliques do mouse e visibilidade do cursor */
			if (Main.input.mouseClick() || Main.input.mouseUnclick()){
				trace("plaaaaay");
				myCursor.play();
			}
			if (Main.input.isCursorVisible()){
				myCursor.visible = true;
			}else{
				myCursor.visible = false;
			}
		}
	}
}