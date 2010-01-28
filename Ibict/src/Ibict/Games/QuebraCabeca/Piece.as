package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Uma peça do quebra cabeça.
	 * 
	 * Essa classe basicamente armazena a imagem pronta de uma peça, bem como uma
	 * âncora, ou ponto de referência, que é o centro do quadrado principal da peça
	 * (o centro da peça sem orelhas).
	 * 
	 * A melhor maneira de se criar uma peça é por meio do método <code>createPiece</code>
	 * de <code>PieceDescription</code>.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see PieceDescription
	 * @see PieceBuilder
	 */
	public class Piece extends Bitmap implements Updatable
	{
		public var anchor : Point;
		
		/**
		 * Cria uma nova Piece.
		 * 
		 * @param bmp a imagem da peça.
		 * @param anchor a âncora.
		 */
		public function Piece(bmp : BitmapData, anchor : Point)
		{
			super (bmp);
			
			this.anchor = anchor;
		}
		
		/* Override. */
		public function update(e : Event) {
			
		}
	}
}
