package Ibict.Games.Cooperativa
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
		
	public class CooperativaState extends State
	{
		private var mainInstance : Main;
		
		private var cooperativa : Cooperativa;
		
		public var parabensImagem : MovieClip;
		
		public var imgNum : int;
		
		private var gameStateInstance : GameState;
		
		public function CooperativaState(){
		}
		
		public override function assume(previousState : State){
			
			mainInstance = Main.getInstance();
			gameStateInstance = GameState.getInstance();
			
			imgNum = 2;
			cooperativa = new Cooperativa(imgNum);
			root = new MovieClip();
			
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
		}
		
		public override function enterFrame(e : Event){
			var input : InputManager = InputManager.getInstance();
			
			if (input.mouseClick()) {
				for (var i:int = 0; i < cooperativa.partes.length; i++) {
					
					
				}
			}
			
		}

	}
}