package Ibict.Games.Memoria
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	import Ibict.Util.Temporizador;
	
	import flash.display.MovieClip;
	import flash.events.Event;
		
	public class MemoriaState extends State
	{
		private var mainInstance : Main;
		
		private var memoria : Memoria;
		
		public var carta1: int;
		public var carta2: int;
		
		public var timer = new Temporizador();
		
		private var gameStateInstance : GameState;

		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : CursorMemoria;	
		
		public function MemoriaState(){
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			memoria = new Memoria(0, 4, 4);
			root = new MovieClip();
			
			//myCursor =  new CursorMemoria();
		}
		
		public override function assume(previousState : State){
			/*Adiciona jogo a animacao.*/
			root.addChild(memoria.fundo);
			carta1 = carta2 = 0;
			/*Adiciona novo cursor a animacao.*/
			//root.addChild(myCursor);
			
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
			
			root.removeChild(memoria.fundo);
			//root.removeChild(myCursor);
			//Mouse.show();
			
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			var viradas: int;
			var viradastot: int;
			
			/* Atualiza a posicao do mouse na tela */
			//myCursor.x = input.getMousePoint().x;
			//myCursor.y = input.getMousePoint().y;
			
			//myCursor.visible = input.isMouseInside();
			
			if (memoria.viradas == 2){
				memoria.viradas = 0;
				if ((memoria.tipos[carta1] == memoria.tipos[carta2]) && (memoria.numeros[carta1] != memoria.numeros[carta2])){
					//acertou, botar uma mensagem e uma firula...
					memoria.viradastot -= 2;
					if(memoria.viradastot <= 0){
						trace("Parabens, vc ganhou!!!11!!1!um!onze!!!dozoito");								
					}
				} else {
					//errou, virar de volta as cartas depois de 0.7 segundo.
				  	timer.start();
				  	while(timer.getCount() < 700);
				  	timer.stop();
				  	
					memoria.fundo.addChild(memoria.cartas[carta1]);
					memoria.fundo.swapChildren(memoria.cartasViradas[carta1],memoria.cartas[carta1]);
					memoria.fundo.removeChild(memoria.cartasViradas[carta1]);
					memoria.fundo.addChild(memoria.cartas[carta2]);
					memoria.fundo.swapChildren(memoria.cartasViradas[carta2],memoria.cartas[carta2]);
					memoria.fundo.removeChild(memoria.cartasViradas[carta2]);
				}
			}
			
			if(input.mouseClick()){
				for(var i:int=0; i<memoria.cartas.length; i++){
					if(input.getMouseTarget() == memoria.cartas[i]){						
						/*Troca na cena a figura fundo da carta com a carta*/
						memoria.fundo.addChild(memoria.cartasViradas[i]);
						memoria.fundo.swapChildren(memoria.cartas[i], memoria.cartasViradas[i]);
						memoria.fundo.removeChild(memoria.cartas[i]);
						memoria.viradas++;
						carta1 = carta2;
						carta2 = i;
					}
				}
			}

			/* checa cliques do mouse e visibilidade do cursor */
			//if (input.mouseClick() || input.mouseUnclick()){
				//myCursor.play();
			//}			
		}
	}
}