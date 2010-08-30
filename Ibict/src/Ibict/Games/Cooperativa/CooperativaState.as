/*
B1P1 - X:46.40 Y:78.15
B1P2 - X:72.45 Y:147.5 e X:156.45 Y:147.5
B1P3 - X:73 Y:30
B1P4 - X:5 Y:4.25

B2P1 - X:8.35 Y:139.4
B2P2 - X:30.95 Y:58.35
B3P3 - X:82.95 Y:138.2 e X:166.85 Y:105.2
*/

package Ibict.Games.Cooperativa
{
	import Ibict.Games.CacaPalavras.CacaPalavrasPontuacao;
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	import Ibict.Util.Temporizador;
	
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
			
			imgNum = 1;
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
			
			
		}

	}
}