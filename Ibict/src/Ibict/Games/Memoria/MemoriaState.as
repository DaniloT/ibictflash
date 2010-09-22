//Estrelas: 10000 - 12500 - 21000 - 25000 - 34000 - 35500
//Botao lampada: x 481.75 y 21.75

package Ibict.Games.Memoria
{
	import Ibict.Games.CacaPalavras.CacaPalavrasPontuacao;
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	import Ibict.Util.Temporizador;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
		
	public class MemoriaState extends State
	{
		private var mainInstance : Main;
		
		private var memoria : Memoria;
		
		public var carta1: int;
		public var carta2: int;
		
		public var virou: int;
		public var espera: int;
		
		public var dificuldade: int;
		
		public var pontuacao: CacaPalavrasPontuacao;
		
		public var parabensImagem : MovieClip;

		public var timer = new Temporizador();
		public var timerTotal = new Temporizador();
		
		private var gameStateInstance : GameState;
		
		private var musica : Music;

		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : errosCursor;	
		
		public function MemoriaState(){
			myCursor =  new errosCursor();
			
			dificuldade = 1;
		}
		
		public override function assume(previousState : State){
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			//dificuldade = 3;
			memoria = new Memoria(dificuldade);
			root = new MovieClip();
			
			virou = 0;
			espera = 0;
			
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			
			pontuacao = new CacaPalavrasPontuacao(675, 55);
			
			/*Adiciona jogo a animacao.*/
			root.addChild(memoria.fundo);
			root.addChild(pontuacao);
			carta1 = carta2 = -1;
			/*Adiciona novo cursor a animacao.*/
			//root.addChild(myCursor);
			gameStateInstance.addMouse(myCursor);
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor.visible = false;
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
			
			if (previousState != null){
				//mainInstance.stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			//mainInstance.stage.addChild(this.root);
			gameStateInstance.addGraphics(this.root);
			
			musica = new Music(new MusicaCasa, false, 20);
			
			timerTotal.start();
		}
		
		public override function leave(){
			
			root.removeChild(memoria.fundo);
			musica.stop(true);
			timerTotal.stop();
			//root.removeChild(myCursor);
			gameStateInstance.removeMouse();
			Mouse.show();
			
		}
		
		public override function reassume(previousState:State){
			myCursor.visible = true;
			Mouse.hide();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			var viradas: int;
			var viradastot: int;
			
			/* Atualiza a posicao do mouse na tela */
			myCursor.x = input.getMousePoint().x;
			myCursor.y = input.getMousePoint().y;
			
			myCursor.visible = input.isMouseInside();
			
			if (input.mouseClick() || input.mouseUnclick()){
				myCursor.play();
			}
			
			if (!espera) {
				if (!virou) {
					
					if (memoria.viradas == 2){
						memoria.viradas = 0;
						if ((memoria.tipos[carta1] == memoria.tipos[carta2]) && (memoria.numeros[carta1] != memoria.numeros[carta2])){
							//acertou, botar uma mensagem e uma firula...
							memoria.viradastot -= 2;
							pontuacao.addPoints(1000);
							if(memoria.viradastot <= 0){
								//todos pares virados, jogador vitorioso.
								root.addChild(parabensImagem);
								parabensImagem.play();
								pontuacao.addPoints((dificuldade*10000) - (timerTotal.getCount()/10));
								timerTotal.stop();
							}
						} else {
							//errou, ativar timer pra virar de volta.
							pontuacao.addPoints(-100);
						  	timer.start();
						  	virou = 1;
						}
					}
					
					if(input.mouseClick()){
						for(var i:int=0; i<memoria.cartas.length; i++){
							if(input.getMouseTarget() == memoria.cartas[i]){
								if (!memoria.cartasViradas[i]) {
									/*Vira a carta escolhida.*/
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
					// Quando der 1 segundo que as cartas tao viradas, desvira elas.
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
				// Quando der 0.6 segundos as cartas terminaram de virar de volta.
				if (timer.getCount() > 1600) {
					timer.stop();
					espera = 0;
				}
			}
		
		}
		
		public function setDificulty(dificuldade : int) {
			this.dificuldade = dificuldade;
		}

	}
}