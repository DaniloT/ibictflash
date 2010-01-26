package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Uma peça do quebra cabeça.
	 */
	public class Piece extends MovieClip implements Updatable
	{
		public var anchor : Point;
		public var bitmap : Bitmap;
		
		public function Piece(anchor : Point, bitmap : Bitmap)
		{
			this.anchor = anchor;
			this.bitmap = bitmap;
			
			this.addChild(bitmap);
		}
		
		public function update(e : Event) {
			
		}
	}
}
