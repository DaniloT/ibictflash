package Ibict.Games.Memoria
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.Message;
	import Ibict.States.State;
	import Ibict.Util.Temporizador;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
    import flash.utils.getTimer;
		
	public class MemoriaState extends State
	{
		private var mainInstance : Main;
		
		private var memoria : Memoria;
		
		public var carta1: int;
		public var carta2: int;
		
		public var virou: int;
		public var espera: int;
		public var associacao: int;
		
		public var dificuldade: int;
		
		public var parabensImagem : MovieClip;

		public var timer = new Temporizador();
		public var timerTotal = new Temporizador();
		
		private var gameStateInstance : GameState;
		
		private var musica : Music;
		
		private var somOk : Music;
		private var somWrong : Music;
		private var somCarta : Music;
		
		/* Mensagem que eventualmente pode aparecer na tela */
		private var msg : Message; 

		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		//public static var myCursor : errosCursor;	
		
		public function MemoriaState(){
			//myCursor =  new errosCursor();
			
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
			associacao = 0;
			
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			
			/*Adiciona jogo a animacao.*/
			root.addChild(memoria.fundo);
			carta1 = carta2 = -1;
			/*Adiciona novo cursor a animacao.*/
			//root.addChild(myCursor);
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
			
			musica = new Music(new MusicaMemoria, false, 20);
			
			/* carregando os sons */
			somOk = new Music(new ColetaSomOk(), true, -10);
			somWrong = new Music(new ColetaSomWrong(), true, -10);
			somCarta = new Music(new MemoriaSomCarta(), true, -10);
			
			timerTotal.start();
		}
		
		public override function leave(){
			
			root.removeChild(memoria.fundo);
			musica.stop(true);
			timerTotal.stop();
			//root.removeChild(myCursor);
			//gameStateInstance.removeMouse();
			//Mouse.show();
			
		}
		
		public override function reassume(previousState:State){
			//myCursor.visible = true;
			//Mouse.hide();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			var viradas : int;
			var viradastot : int;
			var pt : Point;
			var timerFim : Timer = new Timer(7000, 1);
			
			/* Atualiza a posicao do mouse na tela */
			//myCursor.x = input.getMousePoint().x;
			//myCursor.y = input.getMousePoint().y;
			
			//myCursor.visible = input.isMouseInside();
			
			//if (input.mouseClick() || input.mouseUnclick()){
			//	myCursor.play();
			//}
			
			if (input.mouseClick()) {
				if (input.getMouseTarget() == memoria.lampada) {
					associacao = 1;
					memoria.lampada.play();
					memoria.menuAssociacao.play();
				}
			}
			
			if(msg != null){
				if(msg.okPressed()){
					msg.destroy();
				}
			}
			
			if (!associacao) {
				if (input.mouseClick()) {
					if (input.getMouseTarget() == memoria.voltar) {
						GameState.setState(GameState.ST_SELECAO_MEMORIA);
					} 
				}
				if (!espera) {
					if (!virou) {
						
						if (memoria.viradas == 2){
							memoria.viradas = 0;
							if ((memoria.tipos[carta1] == memoria.tipos[carta2]) && (memoria.numeros[carta1] != memoria.numeros[carta2])){
								//acertou, botar uma mensagem e uma firula...
								pt = new Point(0, 150);
								if (msg != null){
									msg.destroy();
								}
								somOk.play(0);
								msg = gameStateInstance.writeMessage(memoria.mensagens[carta1], pt, true, "OK", false, "", false);
								root.addChild(msg);
								memoria.viradastot -= 2;
								memoria.pontuacao.addPoints(1000);
								if(memoria.viradastot <= 0){
									//todos pares virados, jogador vitorioso.
									root.addChild(parabensImagem);
									parabensImagem.play();
									memoria.pontuacao.addPoints((dificuldade*10000) - (timerTotal.getCount()/10));
									GameState.profile.memoriaData.setStar(memoria.pontuacao.getPoints());
									GameState.profile.save();
									timerTotal.stop();
									 
                    				timerFim.addEventListener(TimerEvent.TIMER_COMPLETE, acabouHandler);
                    				timerFim.start();
								}
							} else {
								//errou, ativar timer pra virar de volta.
								somWrong.play(0);
								memoria.pontuacao.addPoints(-100);
							  	timer.start();
							  	virou = 1;
							}
						}
						
						if(input.mouseClick()){
							for(var i:int=0; i<memoria.cartas.length; i++){
								if(input.getMouseTarget() == memoria.cartas[i]){
									if (!memoria.cartasViradas[i]) {
										/*Vira a carta escolhida.*/
										somCarta.play(0);
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
							somCarta.play(0);
							somCarta.play(0);
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
			
			} else {
				//Menu de associacoes
				if (input.mouseClick()) {
					if(input.getMousePoint().x < 243.40 && input.getMousePoint().x > 29.40 && input.getMousePoint().y < 568.7 && input.getMousePoint().y > 503.7) {
						associacao = 0;
						memoria.menuAssociacao.play();
						memoria.lampada.play();
					}
				}
			}
		}
		
		public function setDificulty(dificuldade : int) {
			this.dificuldade = dificuldade;
		}
		
		private function acabouHandler(evt:TimerEvent){
        	GameState.setState(GameState.ST_MUNDO);
        }

	}
}