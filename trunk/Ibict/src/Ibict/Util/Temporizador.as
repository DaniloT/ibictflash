package Ibict.Util
{
	import flash.utils.getTimer;
	
	public class Temporizador
	{
		var started : Boolean;
		
		var tempoInicial : int;
		var pauseTime : int;
		
		
		public function Temporizador()
		{
			started = false;
			pauseTime = 0;
			tempoInicial = 0;
		}
		
		public function getCount() : int {
			if(started) {
				return (getTimer() - tempoInicial);
			} else {
				return (pauseTime - tempoInicial);
			}
				
		}
		

		public function start() {
			if(started == false) {
				started = true;
				tempoInicial = getTimer() - pauseTime;
			} 		
		}
		
		public function stop() {
			pauseTime = 0;
			if(started == true) {
				started = false;
				
			}
		}
		
		public function pause() {
			pauseTime = getTimer();
			if(started == true) {
				started = false;
			}
		}

	}
}