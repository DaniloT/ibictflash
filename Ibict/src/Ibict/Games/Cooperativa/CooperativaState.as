package Ibict.Games.Cooperativa
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
		
	public class CooperativaState extends State
	{
		private var mainInstance : Main;
		
		private var cooperativa : Cooperativa;
		
		public var parabensImagem : MovieClip;
		
		public var imgNum : int;
		
		private var gameStateInstance : GameState;
		
		private var i : int;
		private var clicou : int;
		private static const TOLERANCIA : int = 15;
		private var offsetX : int;
		private var offsetY : int;
		
		public function CooperativaState(){
		}
		
		public override function assume(previousState : State){
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			imgNum = 1;
			cooperativa = new Cooperativa(imgNum);
			root = new MovieClip();
			
			clicou = 0;
			offsetX = 0;
			offsetY = 0;
			
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			
			/*Adiciona jogo a animacao.*/
			root.addChild(cooperativa.fundo);

			if (previousState != null){
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}

			gameStateInstance.addGraphics(this.root);
		}
		
		public override function leave(){
			root.removeChild(cooperativa.fundo);
			Mouse.show();
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			
			if (input.mouseClick()) {
				for (i = 0; i < cooperativa.partes.length; i++) {
					if (input.isMouseInsideMovieClip(cooperativa.partes[i]) && (!cooperativa.trava[i])){
						break;
					}
				}
				if (i < cooperativa.partes.length) {
					clicou = 1;
					offsetX = input.getMousePoint().x - cooperativa.partes[i].x;
					offsetY = input.getMousePoint().y - cooperativa.partes[i].y;
					Mouse.hide();
				}
			}
			
			if (clicou) {
				if (input.isMouseDown()) {
					if (input.isMouseInside()) {
						cooperativa.partes[i].x = (input.getMousePoint().x - offsetX);
						cooperativa.partes[i].y = (input.getMousePoint().y - offsetY);
					}
				} else {
					if ((cooperativa.partes[i].x <= (cooperativa.sombra.x + cooperativa.partesX[i] + TOLERANCIA)) &&
					 (cooperativa.partes[i].x >= (cooperativa.sombra.x + cooperativa.partesX[i] - TOLERANCIA)) &&
					 (cooperativa.partes[i].y <= (cooperativa.sombra.y + cooperativa.partesY[i] + TOLERANCIA)) &&
					 (cooperativa.partes[i].y >= (cooperativa.sombra.y + cooperativa.partesY[i] - TOLERANCIA))) {
					 	cooperativa.trava[i] = 1;
					 	cooperativa.partes[i].x = (cooperativa.sombra.x + cooperativa.partesX[i]);
					 	cooperativa.partes[i].y = (cooperativa.sombra.y + cooperativa.partesY[i]);
					} else {
						if ((!cooperativa.trava[i+cooperativa.duplicado[i]]) && (cooperativa.duplicado[i] != 0)) {
							if ((cooperativa.partes[i].x <= (cooperativa.sombra.x + cooperativa.partesX[i+cooperativa.duplicado[i]] + TOLERANCIA)) &&
							 (cooperativa.partes[i].x >= (cooperativa.sombra.x + cooperativa.partesX[i+cooperativa.duplicado[i]] - TOLERANCIA)) &&
							 (cooperativa.partes[i].y <= (cooperativa.sombra.y + cooperativa.partesY[i+cooperativa.duplicado[i]] + TOLERANCIA)) &&
							 (cooperativa.partes[i].y >= (cooperativa.sombra.y + cooperativa.partesY[i+cooperativa.duplicado[i]] - TOLERANCIA))) {
							 	cooperativa.trava[i+cooperativa.duplicado[i]] = 1;
							 	cooperativa.partes[i].x = cooperativa.partes[i+cooperativa.duplicado[i]].x;
							 	cooperativa.partes[i].y = cooperativa.partes[i+cooperativa.duplicado[i]].y;
							 	cooperativa.partes[i+cooperativa.duplicado[i]].x = (cooperativa.sombra.x + cooperativa.partesX[i+cooperativa.duplicado[i]]);
							 	cooperativa.partes[i+cooperativa.duplicado[i]].y = (cooperativa.sombra.y + cooperativa.partesY[i+cooperativa.duplicado[i]]);
							 	
							}
						}
					}
					for (i = 0; i < cooperativa.partes.length; i++) {
						if (!cooperativa.trava[i]) {
							break;
						}
					}
					if (i >= cooperativa.partes.length) {
						//Ganhou o jogo
						root.addChild(parabensImagem);
						parabensImagem.play();
					}
					clicou = 0;
					offsetX = 0;
					offsetY = 0;
					Mouse.show();
				}
			}
			
		}

	}
}