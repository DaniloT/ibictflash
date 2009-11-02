package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import States.*;

	public class Main extends Sprite
	{
		public static var stage_g : Stage; /* variavel static que auxilia os eventos de mouse e teclado */
		public static var menu : MenuState; /* variavel que gerencia o estado 'Menu' do jogo */
		public static var game : GameState; /* variavel que gerencia o estado 'Jogo' do jogo */

		public function Main()
		{
			Main.stage_g = this.stage;
			menuState = new MenuState();
			addChild(jogo);		
		}

	}
}