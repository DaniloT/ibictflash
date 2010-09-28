package Ibict.Games.Erros
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
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
		
		/** figura onde estara os erros */
		private var cena : Cena;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : errosCursor;
		
		/* Mensagem que eventualmente pode aparecer na tela */
		private var msg : Message; 
		
		private var gameStateInstance : GameState;
		
		/** Animação que aparecerá quando for trocar de cenário. */
		private var anim : MovieClip;
		
		private var musica : Music;
		
		private var parabens : parabensErros;
				
		public function ErrosState(){
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			root = new MovieClip();			
			myCursor =  new errosCursor();
			
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2;
			
			parabens = new parabensErros();
			parabens.x = 400;
			parabens.y = 300;
			parabens.stop();
		}
		
		public override function assume(previousState : State){
			/* Testa se o root já está adicionado no cenário */
			//if(!mainInstance.stage.contains(this.root)){
			if(!gameStateInstance.getGraphicsRoot().contains(this.root)){
				while(root.numChildren > 0){
					root.removeChildAt(0);
				}
				cena = new Cena();
				/*Adciona os elementos de 'cena' na animacao*/
				root.addChild(cena.cenario);
				root.addChild(cena.moldura);
				
				//mainInstance.stage.addChild(this.root);
				gameStateInstance.addGraphics(this.root);
			}
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor.visible = false;
			
			if (previousState != null){
				//mainInstance.stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			//root.addChild(myCursor);
			gameStateInstance.addMouse(myCursor);
			
			musica = new Music(new MusicaCasa, false, 20);
		}
		
		public override function leave(){
			if (musica != null){
				musica.stop(true);
			}
			gameStateInstance.removeMouse();
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
			
			if(cena.emJogo){
				myCursor.visible = input.isMouseInside();
				//Seta o tempo na tela
				cena.tempoAtual = getTimer();
				var timeDiff, minutos, segundos : Number;
				timeDiff = cena.tempoAtual - cena.tempoInicial;
				minutos = Math.floor(timeDiff/60000);
				segundos = Math.floor((timeDiff - (minutos*60000))/1000);
				cena.moldura.minutos.text = minutos.toString();
				cena.moldura.segundos.text = segundos.toString();
				
				//Seta a quantidade de erros que ainda falta encontrar
				cena.moldura.erros.text = cena.qtdErros.toString();
				
				
				/*Testa se clicou em um erro da cena*/
				if(input.mouseClick()) {
					//trace("target: "+input.getMouseTarget()+"erros lenght: "+cena.erros.length);
					for(i=0; i<cena.erros.length; i++){
						if(input.getMouseTarget() == cena.erros[i]){
							//trace("clicou no lugar certo");
							
							/*Troca na cena a figura correta com a errada*/
							cena.cenario.addChild(cena.acertos[i]);
							cena.cenario.swapChildren(cena.erros[i], cena.acertos[i]);
							cena.cenario.removeChild(cena.erros[i]);
							
							cena.qtdErros--;
							pt = new Point(0, 150);
							
							//Se a cena já possuir outra mensagem, a destroi.
							if (msg != null){
								msg.destroy();
							}
							
							//Se for o último erro da cena, a mensagem não desaparece sozinha
							if (cena.qtdErros != 0){
								msg = GameState.getInstance().writeMessage(cena.mensagens[i], pt, true, "OK", false, "", true);
							} else {
								msg = GameState.getInstance().writeMessage(cena.mensagens[i], pt, true, "OK", false, "", false);
							}
							root.addChild(msg);
							//root.swapChildren(msg,myCursor);
							//cena.pontos += cena.MAXPTS; 
							
							if(cena.qtdErros <= 0){
								trace("Parabéns, vc ganhou");
								/* if (cena.nivelAtual++ < cena.MAXNIVEIS) {
									root.removeChild(cena.cenario);
									cena.criaCena(cena.nivelAtual);
									root.addChild(cena.cenario);
									root.addChild(cena.moldura);
									root.swapChildren(cena.moldura, myCursor);
								} */
								/* var timeout: Timer = new Timer(3000, 1);
								timeout.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutHandler);
								timeout.start(); */
							}
						}
					}
				}
				
				/* Shift + Clique = nova mensagem na tela */
				if(input.kbClick(Keyboard.SHIFT)){
					//pt = new Point(150, 150);
					//msg = GameState.getInstance().writeMessage("Mensagem de teste!!", pt, true, "OK", true, "Cancela", true);
					//root.addChild(msg);
					trace("Jah ganhou essa estrela? "+GameState.profile.errosData.getStar());
				}
				
				if(msg != null){
					if(msg.okPressed()){
						msg.destroy();
						if (cena.qtdErros == 0){
							if (cena.nivelAtual == cena.MAXNIVEIS-1){
								acabouJogo();
							} else {
								trocarCenario();
							}
						}
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
			} 
		}
		
		private function trocarCenario(){
			cena.emJogo = false;
			anim = new errosAnimacaoTrocar();
			root.addChild(anim);
			anim.x = 0;
			anim.y = 0;
			anim.play();
			
			var timeout: Timer = new Timer(1300, 1);
			timeout.addEventListener(TimerEvent.TIMER_COMPLETE, animFadeIn);
			timeout.start(); 
			myCursor.visible = false;	
			
			
			
			
		}
		
		private function animFadeIn(evt: TimerEvent){
			root.removeChild(cena.cenario);
					
			cena.criaCena(++cena.nivelAtual);
			root.addChild(cena.cenario);
			
			root.removeChild(anim);
			root.addChild(anim);
			
			
			
			//root.swapChildren(myCursor, anim);
			
			anim.play();
			
			 var timeout: Timer = new Timer(1000, 1);
			timeout.addEventListener(TimerEvent.TIMER_COMPLETE, animFadeOut);
			timeout.start(); 
		}
		
		private function animFadeOut(evt: TimerEvent){
			root.removeChild(anim);
			cena.emJogo = true;
			myCursor.visible = true;
		}
		
		/*Quando o jogador passar de todos os comodos */ 
		private function acabouJogo(){
			var timer:Timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, acabouHandler);
			timer.start();
			
			cena.emJogo = false;
			
			root.addChild(parabens);
			parabens.play();
			musica.stop(true);
			
			GameState.profile.errosData.setStar(true);
		}
		
		private function acabouHandler(evt:TimerEvent){
			GameState.setState(GameState.ST_MUNDO);
		}
	}
}