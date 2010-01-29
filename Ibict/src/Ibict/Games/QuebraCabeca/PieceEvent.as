package Ibict.Games.QuebraCabeca
{
	import flash.events.Event;

	/**
	 * Evento lançado por uma peça.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Piece
	 */
	public class PieceEvent extends Event
	{
		private var _piece : Piece;
		
		/**
		 * Cria novo PieceEvent.
		 */
		public function PieceEvent(
				piece : Piece,
				type:String,
				bubbles:Boolean=false,
				cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._piece = piece;
		}
		
		
		public function get piece() : Piece {
			return this._piece;
		}
	}
}
