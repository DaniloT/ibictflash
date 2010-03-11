package Ibict.Util
{
	import flash.utils.getTimer;
	
	public class Temporizador
	{
		var started : Boolean;
		
		var tempoInicial : int;
		
		
		public function Temporizador()
		{
		}
		
		public function getCount() : int {
			return (getTimer() - tempoInicial);
		}
		
		public function start() {
			if(started == false) {
				started = true;
				tempoInicial = getTimer();
			}			
		}
		
		public function stop() {
			if(started == true) {
				started = false;
			}
		}

	}
}