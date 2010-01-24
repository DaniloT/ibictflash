package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * Uma peça do quebra cabeça.
	 */
	public class Piece extends Bitmap implements Updatable
	{
		public function Piece(bmp : BitmapData)
		{
			super(bmp);
		}
	}
}
