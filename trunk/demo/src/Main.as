package
{
	import States.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;

	public class Main extends Sprite
	{
		
		public static var input : InputManager;
		
		public static var stage_g : Stage; /* variavel static que auxilia os eventos de mouse e teclado */
		public static var menu : MenuState; /* variavel que gerencia o estado 'Menu' do jogo */
		public static var game : GameState; /* variavel que gerencia o estado 'Jogo' do jogo */
		public static var pause : PauseState; /* variavel que gerencia o estado 'Pause' do jogo */
		public static var currentState : State;

		public function Main()
		{
			Main.stage_g = this.stage;
			Main.input = InputManager.getInstance();
			
			//menu = new MenuState();
			
			game = new GameState();
		}

	}
}