package
{
	import flash.events.KeyboardEvent;
	
	public class InputManager
	{
		private var keys : Array = new Array(220);
		private static var instance : InputManager;
			
		public function InputManager()
		{
			Main.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Main.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		public static function getInstance() : InputManager{
			if (instance == null){
				instance = new InputManager();
			}
			return(instance);
		}
		
		private function keyDownHandler(event:KeyboardEvent){
			

		}
		
		private function keyUpHandler(event:KeyboardEvent){
			keys[event.keyCode] = false;
		}
		
		public function isDown(key : int): Boolean{
			return (keys[key])
		}

	}
}