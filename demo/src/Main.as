package
{
	import States.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class Main extends Sprite
	{
		
		public static var input : InputManager;
		
		public static var stage_g : Stage; /* Auxilia os eventos de mouse e teclado. */
		
		public static var menu : MenuState; /* Instância do estado 'Menu' do jogo. */
		public static var game : GameState; /* Instância do estado 'Jogo' do jogo. */
		public static var pause : PauseState; /* Instância do estado 'Pause' do jogo. */
		
		public static var currentState : State;

		public function Main()
		{
			/* Prepara os recursos globais */
			Main.stage_g = this.stage;
			Main.input = InputManager.getInstance();
			
			/* Carrega os estados. */
			menu = new MenuState();
			game = new GameState();
			
			/* Seta estado inicial. */
			currentState = game;
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event)
		{
			currentState.enterFrame(e);			
		}
	}
}
