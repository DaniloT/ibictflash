package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;

	public class Main extends Sprite
	{
		public static var stage_g : Stage; /* variavel static que auxilia os eventos de mouse e teclado */
		public static var menuState : State; /* variavel que gerencia o estado 'Menu' do jogo */
		public static var gameState : State; /* variavel que gerencia o estado 'Jogo' do jogo */

		public function Main()
		{
			Main.stage = this.stage;
			jogo = new Jogo();
			addChild(jogo);		
		}

	}
}