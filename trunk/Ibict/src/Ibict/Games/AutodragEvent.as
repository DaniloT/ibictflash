package Ibict.Games
{
	import flash.events.Event;

	/**
	 * Evento lançado por uma sprite ao ser arrastada.
	 * 
	 * @author Luciano Santos
	 */
	public class AutodragEvent extends Event
	{
		public static const STARTED_DRAG  : String = "spriteStartedDrag";
		public static const STOPPED_DRAG  : String = "spriteStoppedDrag";
		
		
		private var _source : AutodragSprite;
		
		
		/**
		 * Cria novo evento.
		 */
		public function AutodragEvent(
				source : AutodragSprite,
				type:String,
				bubbles:Boolean=false,
				cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._source = source;
		}
		
		public function get source() : AutodragSprite {
			return this._source;
		}
	}
}
