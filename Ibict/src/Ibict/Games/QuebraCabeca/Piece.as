package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Uma peça do quebra cabeça.
	 */
	public class Piece extends DisplayObject implements Updatable
	{
		private var size : Point;
		private var anchor : Point;
		private var bitmap : Bitmap;
		
		public function Piece(desc : PieceDescription, mode : int)
		{
			
		}
		
		public function update(e : Event) {
			
		}
	}
}
