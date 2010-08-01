package Ibict
{
	import Ibict.Music.MusicController;
	import Ibict.Profile.LoadState;
	import Ibict.States.*;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Mouse;

	/**
	 * Classe principal do jogo, DisplayObject principal do Flash.
	 * 
	 * Essa classe é também a máquina de estados principal do jogo.
	 */
	public class Main extends MovieClip implements GraphicsHolder {
		
		/** Estado do Menu. */
		public static const ST_MENU			: int = 0;
		/** Estado "Em Jogo". */
		public static const ST_GAME			: int = 1;
		/** Estado "Em Pausa". */
		public static const ST_PAUSE		: int = 2;
		/** Estado de loading. */
		public static const ST_LOAD			: int = 3;
		/** Estado de criação do avatar */
		public static const ST_CREATE		: int = 4;
		
		
		
		
		/** Largura da tela. */
		public static const WIDTH : int = 800;
		/** Altura da tela. */
		public static const HEIGHT : int = 600;
		
		/* Guarda a instância única desse singleton. */
		private static var instance : Main;
		
		/* Conjunto de estados do jogo. */
		private static var states : Array;
		
		/* Estado atual. */
		private var currentState : State;
		
		
		private var input : InputManager;
		private var musController : MusicController = new MusicController();
		private var graphics_root : DisplayObjectContainer;
		private var icon_holder : Sprite;

		
		/**
		 * Cria uma nova instância de Main.
		 * 
		 * Lembre-se: essa classe é um singleton, instanciado automaticamente pelo
		 * Flash, tentar instanciá-la novamente causará um erro.
		 */
		public function Main() {			
			addEventListener(Event.ADDED_TO_STAGE, iniciaMain);
		}
		
		public function iniciaMain(evt:Event){
			if (instance != null)
				throw new Error("Tried to reinstantiate singleton!");
			
			/* Prepara os recursos globais */
			Main.instance = this;
				
			this.input = InputManager.getInstance();
			
			this.graphics_root = new MovieClip();
			this.icon_holder = new Sprite();
			this.addChild(graphics_root);
			this.addChild(icon_holder);
			
			this.setIcon(null);
			
			
			
			
			/* Carrega os estados. */
			states = new Array();
			states[ST_MENU] = new MenuState();
			states[ST_GAME] = new GameState();
			states[ST_PAUSE] = new PauseState();
			states[ST_LOAD] = new LoadState();
			states[ST_CREATE] = new AvatarCreationState();
			
			/* Seta estado inicial. */
			//setState(ST_LOAD);
			//setState(ST_GAME);
			setState(ST_MENU);
			
			/* Seta os eventos. */
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * Retorna a instância única deste singleton.
		 */
		public static function getInstance() : Main
		{
			return instance;
		}
		
		/**
		 * Altera o estado atual para o estado dado.
		 * 
		 * @param state o novo estado, que dever ser uma das constantes
		 * de estado.
		 */
		public function setState(state : int){
			var prev : State = currentState;
			
			if (prev != null) {
				prev.leave();
			}
			currentState = states[state];
			currentState.assume(prev);
		}
		
		/**
		 * Define o ícone do Mouse como o DisplayObject dado.
		 * 
		 * @param icon o ícone a ser definido, se for null, será o ícone
		 * padrão do SO.
		 */
		public function setIcon(icon : DisplayObject) {
			if (icon_holder.numChildren > 0)
				icon_holder.removeChildAt(0);
			
			if (icon != null) {
				Mouse.hide();
				icon_holder.addChild(icon);
			}
			else
				Mouse.show();
		}
		
		private function enterFrameHandler(e:Event)	{
			var p : Point = input.getMousePoint();
			icon_holder.x = p.x; 
			icon_holder.y = p.y;
			icon_holder.visible = input.isMouseInside();
			
			currentState.enterFrame(e);
		}
		
		
		
		
		/* Override. */
		public function addGraphics(g : DisplayObject) {
			if (!graphics_root.contains(g))
				graphics_root.addChild(g);
		}
		
		/* Override. */
		public function removeGraphics(g : DisplayObject) {
			if (graphics_root.contains(g))
				graphics_root.removeChild(g);
		}
	}
}
