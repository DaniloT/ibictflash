﻿package Ibict
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class InputManager
	{
		// timer
		var timer: Timer;
		
		private var keys : Array = new Array(220);
		private static var instance : InputManager;
		
		// variáveis do mouse
		// ponto que indica posição do mouse
		var mousePoint, aMousePoint : Point;
		
		// mouseDown - verdadeira quando o mouse estiver sendo pressionado
		var mouseDown : Boolean;
		
		// onceClick - verdadeira em um frame em que ocorre um clique
		var onceClick : Object;
		
		// onceMouseUp - verdadeira em uma frame em que se solta o clique
		var onceMouseUp : Boolean;
		
		// mouseVelocity - armazena a velocidade do mouse
		var mouseVelocity :  Point;
		// n, an e cancelVelocityCount são variáveis para controle de cancelamento de velocidade
		var n: Number = 0;
		var an : Number  = 0;
		var cancelVelocityCount : Number = 0;
		
		// mouseTarget - contém o movieClip no qual o mouse clicou
		var mouseTarget : Object;
				
		//Indica se mouse está dentro do clipe ou não
		var mouseInside : Boolean = false;
				
		var atimer : int;
		public var dt : int;
		
		// variáveis auxiliares
		private var onceClickTrigger : Boolean;
		private var onceMouseUpTrigger : Boolean;
			
		public function InputManager()
		{
			// inicializando objetos necessários
			mousePoint = new Point(-100, -100);
			aMousePoint = new Point(-100, -100);
			mouseVelocity = new Point();
			timer = new Timer(0, 0);
			timer.start();
			atimer = 0;
			mouseInside = true;
			
			
			onceMouseUp = false;
			onceClick = false;
			
			// adicionando os listeners de eventos			
			var mainInstance : Main = Main.getInstance();
			mainInstance.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			mainInstance.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			mainInstance.stage.addEventListener(MouseEvent.MOUSE_MOVE , mouseMoveHandler);
			mainInstance.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			mainInstance.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			mainInstance.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
			mainInstance.addEventListener(Event.ENTER_FRAME, cancelHandler);
		}
		
		public static function getInstance() : InputManager{
			if (instance == null){
				instance = new InputManager();
			}
			
			return instance;
		}
		
		private function keyDownHandler(event:KeyboardEvent){
			keys[event.keyCode] = true;
		}
		
		/** Testa se uma tecla do teclado foi pressionada. Sem pressioná-la continuamente*/
		public function kbClick(code:int):Boolean{
			var aux: Boolean = keys[code];
			keys[code] = false;
			return aux;
		}
		
		private function keyUpHandler(event:KeyboardEvent){
			keys[event.keyCode] = false;
		}
		
		public function isDown(key : int): Boolean{
			return keys[key]
		}
		
		
		
		private function mouseMoveHandler(e : MouseEvent): void {
			mouseInside = true;
			
			n++;
			if(n==3) n=0;
			// a alteração do valor de n é para controle de parar velocidade
			
			mousePoint.x = e.stageX;
			mousePoint.y = e.stageY;
			
			mouseVelocity.x = (mousePoint.x - aMousePoint.x);
			mouseVelocity.y = (mousePoint.y - aMousePoint.y);
			
			aMousePoint.x = mousePoint.x;
			aMousePoint.y = mousePoint.y;
		}
		
		private function mouseDownHandler(e: MouseEvent) : void {
			mouseDown = true;
			onceClick = true;
			onceClickTrigger = false;
			mouseTarget = e.target;
		}
		
		private function mouseUpHandler (e: MouseEvent) : void {
			mouseDown = false;
			onceMouseUp = true;
			onceMouseUpTrigger = false;	
		}
		
		private function cancelHandler(e: Event): void {
			// controle de cancelar velocidade
			if(n== an) {
				cancelVelocityCount++;
				if(cancelVelocityCount == 4) {
					mouseVelocity.x = 0;
					mouseVelocity.y =0 ;
				}
			} else {
				an = n;
				cancelVelocityCount = 0;
			}
			

			if(onceClickTrigger) onceClick = false;
			if(!onceClickTrigger) {
				onceClickTrigger = true;
			}
			
			if(onceMouseUpTrigger) onceMouseUp = false;
			if(!onceMouseUpTrigger) {
				onceMouseUpTrigger = true;
			}
		}
		
		/* faz o cursor do mouse desaparecer quando o mouse sai da tela */
		private function mouseLeaveHandler(e:Event):void
		{
			mouseInside = false;
		}	
		
		public function getMousePoint() : Point {
			return new Point(mousePoint.x, mousePoint.y);
		}
		
		public function isMouseInsideMovieClip(movieClip : MovieClip) : Boolean {
			if(mousePoint.x < movieClip.x + movieClip.width &&
			mousePoint.x > movieClip.x &&
			mousePoint.y < movieClip.y + movieClip.height &&
			mousePoint.y > movieClip.y) {
				return true;
			} else {
				return false;
			}
		}
		
		public function isMouseDown() : Boolean {
			return mouseDown;
		}
		
		public function mouseClick() : Boolean {
			return onceClick;
		}
		
		public function mouseUnclick() : Boolean {
			return onceMouseUp;
		} 
		
		public function getMouseVelocity() : Point {
			return mouseVelocity;
		}
		
		public function getMouseTarget() : Object {
			return mouseTarget;
		}
		
		public function isMouseInside() : Boolean{
			return mouseInside;
		}
	}
}
