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
		
		public var virou: int;
		public var espera: int;
		
		/*public var cartaVira1: MovieClip;
		public var cartaVira2: MovieClip;*/
		
		public var timer = new Temporizador();
		
		/*public var unflip : MovieClip;
		public var flip : MovieClip;*/
		
		private var gameStateInstance : GameState;

		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : CursorMemoria;	
		
		public function MemoriaState(){
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			memoria = new Memoria(0, 3);
			root = new MovieClip();
			
			virou = 0;
			espera = 0;
			
			/*unflip = new CartaUnflip;
			unflip.x = 0;
			unflip.y = 0;
			unflip.stop();
			
			flip = new CartaFlip;
			flip.x = 0;
			flip.y = 0;
			flip.stop();*/
			
			//myCursor =  new CursorMemoria();
		}
		
		public override function assume(previousState : State){
			/*Adiciona jogo a animacao.*/
			root.addChild(memoria.fundo);
			carta1 = carta2 = -1;
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
			
			if (!espera) {
				if (!virou) {
					
					if (memoria.viradas == 2){
						memoria.viradas = 0;
						if ((memoria.tipos[carta1] == memoria.tipos[carta2]) && (memoria.numeros[carta1] != memoria.numeros[carta2])){
							//acertou, botar uma mensagem e uma firula...
							memoria.viradastot -= 2;
							if(memoria.viradastot <= 0){
								trace("Parabens, vc ganhou!!!11!!1!um!onze!!!dozoito");								
							}
						} else {
							//errou, virar de volta as cartas depois de 1 segundo.
						  	timer.start();
						  	virou = 1;
						  	/*while(timer.getCount() < 3000);
						  	timer.stop();
						  	
						  	memoria.cartas[carta1].play();
						  	memoria.cartas[carta2].play();
						  	carta1 = carta2 = -1;*/
						  	//FlipCard(carta1, 1);
						  	//FlipCard(carta2, 1);
						}
					}
					
					if(input.mouseClick()){
						for(var i:int=0; i<memoria.cartas.length; i++){
							if(input.getMouseTarget() == memoria.cartas[i]){
								if (!memoria.cartasViradas[i]) {
									/*Vira a carta escolhida.*/
									//FlipCard(i, 0);
									memoria.cartas[i].play();
									memoria.viradas++;
									carta1 = carta2;
									carta2 = i;
									memoria.cartasViradas[i] = 1;
									
								}
							}
						}
					}
					
				} else {
					if (timer.getCount() > 1000) {
						espera = 1;
						virou = 0;
						memoria.cartas[carta1].play();
						memoria.cartas[carta2].play();
						memoria.cartasViradas[carta1] = 0;
						memoria.cartasViradas[carta2] = 0;
					}
				}
			} else {
				if (timer.getCount() > 1600) {
					timer.stop();
					espera = 0;
				}
			}
			
			

			/* checa cliques do mouse e visibilidade do cursor */
			//if (input.mouseClick() || input.mouseUnclick()){
				//myCursor.play();
			//}			
		}
		
		//private function FlipCard(carta : int, back : int) {
			/*if (back) {
				cartaVira2 = memoria.cartasViradas[carta];
				cartaVira1 = memoria.cartas[carta];
			} else {
				cartaVira1 = memoria.cartasViradas[carta];
				cartaVira2 = memoria.cartas[carta];
			}*/
			
			/*for (var i:int=0; i<10; i++) {
				memoria.fundo.getChildAt(memoria.fundo.getChildIndex(cartaVira2)).width =
				 (memoria.fundo.getChildAt(memoria.fundo.getChildIndex(cartaVira2)).width) - (memoria.tam/10);
			}*/
			//root.addChild(flip);
			//flip.play();
			//cartaVira2.play();
			/*timer.start();
			while(timer.getCount() < 700);
			timer.stop();*/
			//memoria.fundo.addChild(cartaVira1);
			//memoria.fundo.swapChildren(cartaVira2, cartaVira1);
			//memoria.fundo.removeChild(cartaVira2);
			//cartaVira1.play();
			//memoria.cartasViradas[carta].play();
		//}

	}
}