package Ibict.Games
{
	import flash.events.Event;

	/**
	 * Evento lançado quando o estado de uma ActivatableSprite se altera.
	 */
	public class ActivationEvent extends Event
	{
		public static const ACTIVATED 	: String = "spriteActivated";
		public static const DEACTIVATED : String = "spriteDeactivated";
		
		
		private var _source : ActivatableSprite;
		
		/**
		 * Mesmo construtor de flash.event.Event.
		 */
		public function ActivationEvent(
				source : ActivatableSprite,
				type:String,
				bubbles:Boolean=false,
				cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._source = source;
		}
		
		/**
		 * A ActivatableSprite que lançou o evento.
		 */
		public function get source() : ActivatableSprite {
			return this._source;
		}
	}
}
