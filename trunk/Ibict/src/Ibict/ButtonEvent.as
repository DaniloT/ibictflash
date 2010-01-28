package Ibict
{
	import flash.events.Event;

	/**
	 * Evento lançado por um botão.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Button
	 */
	public class ButtonEvent extends Event
	{
		private var _button : Button;
		
		/**
		 * Cria um novo ButtonEvent.
		 * 
		 * @param button o botão que lançou esse evento.
		 */
		public function ButtonEvent(
				button : Button,
				type : String,
				bubbles : Boolean=false,
				cancelable : Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._button = button;
		}
		
		/**
		 * O botão que lançou esse evento.
		 */
		public function get button() : Button {
			return _button;
		}
	}
}
