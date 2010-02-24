package Ibict.Games.Erros
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.Message;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * Controla o estado do Jogos dos Sete Erros
	 *
	 * @author Bruno Zumba
	 */
	
	public class ErrosState extends State{
		private var mainInstance : Main;
		
		/* figura onde estara os erros */
		private var cena : Cena;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : errosCursor;
		
		/* Mensagem que eventualmente pode aparecer na tela */
		private var msg : Message; 
				
		public function ErrosState(){
			mainInstance = Main.getInstance();
			
			root = new MovieClip();			
			myCursor =  new errosCursor();
			
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
		}
		
		public override function assume(previousState : State){
			/* Testa se o root já está adicionado no cenário */
			if(!mainInstance.stage.contains(this.root)){
				while(root.numChildren > 0){
					root.removeChildAt(0);
				}
				cena = new Cena();
				/*Adciona os elementos de 'cena' na animacao*/
				root.addChild(cena.cenario);
				
				mainInstance.stage.addChild(this.root);
			}
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor.visible = false;
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			
			root.addChild(myCursor);
		}
		
		public override function leave(){
			root.removeChild(myCursor);
			Mouse.show();
			
		}
		
		public override function reassume(previousState:State){
			myCursor.visible = true;
			Mouse.hide();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			var i:int;
			var pt : Point;
			/* Atualiza a posicao do mouse na tela */
			myCursor.x = input.getMousePoint().x;
			myCursor.y = input.getMousePoint().y;
			
			/* checa cliques do mouse e visibilidade do cursor */
			if (input.mouseClick() || input.mouseUnclick()){
				myCursor.play();
			}
			myCursor.visible = input.isMouseInside();
			
			if(cena.emJogo){
				
				/*Testa se clicou em um erro da cena*/
				if(input.mouseClick()) {
					trace("target: "+input.getMouseTarget());
					for(i=0; i<cena.erros.length; i++){
						if(input.getMouseTarget() == cena.erros[i]){
							trace("clicou no lugar certo");
							
							/*Troca na cena a figura correta com a errada*/
							cena.cenario.addChild(cena.acertos[i]);
							cena.cenario.swapChildren(cena.erros[i], cena.acertos[i]);
							cena.cenario.removeChild(cena.erros[i]);
							
							cena.qtdErros--;
							
							cena.pontos += cena.MAXPTS;
							cena.tempoAtual = getTimer();
							trace("TimeDiff: "+(cena.tempoAtual-cena.tempoInicial));
							if((cena.tempoAtual - cena.tempoInicial) > cena.MAXSECS*1000){
								cena.pontos -= cena.PTSPERSEC * cena.MAXSECS;
							} else {
								cena.pontos -= (cena.tempoAtual - cena.tempoInicial) / 1000 * cena.PTSPERSEC;
							}
							cena.tempoInicial = getTimer();
							cena.cenario.pontos.text = cena.pontos.toString(); 
							
							if(cena.qtdErros <= 0){
								trace("Parabéns, vc ganhou");
								/* var timeout: Timer = new Timer(3000, 1);
								timeout.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutHandler);
								timeout.start(); */
							}
						}
					}
				}
				
				/* Shift + Clique = nova mensagem na tela */
				if(input.kbClick(Keyboard.SHIFT)){
					pt = new Point(150, 150);
					//msg = GameState.getInstance().writeMessage("Mensagem de teste!!", pt, true, "OK", true, "Cancela", true);
				}
				
				if(msg != null){
					if(msg.okPressed()){
						trace("Apertou o botão OK");
					} else if(msg.cancelPressed()){
						trace("Apertou o botão Cancelar");
						msg.destroy();
					}
				}
				
				/*Anda com o cenario qnd o jogador aperta as setas do teclado*/
				if(input.isDown(Keyboard.LEFT)){
					if(cena.cenario.x + cena.cenario.width > Main.WIDTH){
						cena.cenario.x -= 5;
					}
				}
				if(input.isDown(Keyboard.RIGHT)){
					if(cena.cenario.x < 0){
						cena.cenario.x += 5;
					}
				}
				if(input.isDown(Keyboard.UP)){
					if(cena.cenario.y + cena.cenario.height > Main.HEIGHT){
						cena.cenario.y -= 5;
					}
				}
				if(input.isDown(Keyboard.DOWN)){
					if(cena.cenario.y < 0){
						cena.cenario.y += 5;
					}
				}
				
				/* Espaço + Clique = pause/despausa */
				if(input.kbClick(Keyboard.SPACE)){
					//GameState.setState(GameState.ST_PAUSE);
				}
			} else {
				if(input.mouseClick()){
					trace("clicou nos niveis: "+input.getMouseTarget());
					for (i=0; i<cena.MAXNIVEIS; i++){
						if(input.getMouseTarget() == cena.nivel[i].bt){
							root.removeChild(cena.cenario);
							cena.criaCena(i);
							root.addChild(cena.cenario);
							root.swapChildren(cena.cenario, myCursor);
						}
					}
				}
			}
		}
		
		private function timeoutHandler(evt: TimerEvent){
			GameState.setState(GameState.ST_MUNDO);
		}
	}
}