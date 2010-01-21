﻿package Ibict
{
	import Ibict.States.*;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class Main extends Sprite
	{
		private static var instance : Main;
		private static var input : InputManager;
		private static var currentState : State;
		
		public static var states : Array; /* Conjunto de estados do jogo. */
		
		public static const ST_MENU : int = 0;
		public static const ST_GAME : int = 1;
		public static const ST_PAUSE : int = 2;
		public static const ST_SETEERROS : int = 3;
		public static const ST_LOAD	: int = 4;
		
		public static const WIDTH : int = 800;
		public static const HEIGHT : int = 600;

		public function Main()
		{
			/* Prepara os recursos globais */
			Main.instance = this;
			Main.input = InputManager.getInstance();
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			
			/*ainda nao sei como vai ser organizado cada jogo. Por enquanto so criei um
			estado a mais para o JOGO DOS SETE ERROS e para o estado de load*/
			states[ST_SETEERROS] = new SeteErrosState();
			states[ST_LOAD] = new LoadState();
			
			/* Seta estado inicial. */
			
			//currentState = states[ST_SETEERROS];
			//currentState = states[ST_LOAD];
			currentState = states[ST_GAME];			
			currentState.assume(null);
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public static function getInstance() : Main
		{
			return(instance);
		}
		
		/* Essa funcao nao estava estatica. Eu coloquei ela estatica para podermos
		acessa-la por outros estados para poder trocar de estado. Nao sei se o certo e assim. by Zumba*/
		public static function setState(state : int)
		{
			var prev : State = currentState;
			currentState.leave();	
			currentState = states[state];
			currentState.assume(prev);
		}
		
		private function enterFrameHandler(e:Event)
		{
			currentState.enterFrame(e);			
		}
	}
}