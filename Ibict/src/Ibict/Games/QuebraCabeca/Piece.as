package Ibict.Games.QuebraCabeca
{
	import Ibict.InputManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Uma peça do quebra cabeça.
	 * 
	 * Essa classe basicamente armazena a imagem pronta de uma peça, bem como uma
	 * âncora, ou ponto de referência, que é o centro do quadrado principal da peça
	 * (o centro da peça sem orelhas). A melhor maneira de se criar uma peça é por
	 * meio do método <code>createPiece</code> de <code>PieceDescription</code>.
	 * 
	 * Essa peça responde ao mouse sendo arrastada pelo usuário. Ao ser clicada,
	 * a peça lança um evento SELECTED e ao ser solta, lança um evento DROPPED.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see PieceDescription
	 * @see PieceBuilder
	 */
	public class Piece extends Sprite {
		public static var SELECTED : String = "pieceSelected";
		public static var DROPPED  : String = "pieceDropped";
		
		private var container : DisplayObjectContainer;
		
		private var input : InputManager;
		
		private var bitmap : Bitmap;
		
		private var _gridx : int;
		private var _gridy : int;
		private var _anchor : Point;
		
		public var active : Boolean;
		
		private var is_draggin : Boolean;
		
		/**
		 * Cria uma nova Piece.
		 * 
		 * @param bmp a imagem da peça.
		 * @param anchor a âncora.
		 */
		public function Piece(
				bmp : BitmapData,
				anchor : Point,
				gridx : int, gridy : int,
				container : DisplayObjectContainer) {
					
			super ();
			
			this.container = container;
			
			this.input = InputManager.getInstance();
			
			this.bitmap = new Bitmap(bmp, "auto", true);
			this.addChild(bitmap);
			
			this._gridx = gridx;
			this._gridy = gridy;
			this._anchor = anchor;
			
			this.active = true;
			
			this.is_draggin = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		/**
		 * Pega a coluna da peça no quebra-cabeça.
		 */
		public function get gridx() : int {
			return this._gridx;
		}
		
		/**
		 * Pega a linha da peça no quebra-cabeça.
		 */
		public function get gridy() : int {
			return this._gridy;
		}
		
		/**
		 * Pega a âncora da peça.
		 */
		public function get anchor() : Point {
			return this._anchor;
		}
		
		
		
		private function mouseDown(e : MouseEvent) {			
			if (this.active) {
				is_draggin = true;
				
				this.startDrag();
				
				if (container.contains(this))
					container.removeChild(this);
				container.addChild(this);
				
				dispatchEvent(new PieceEvent(this, SELECTED));
			}
		}
		
		private function mouseUp(e : MouseEvent) {
			if (is_draggin) {
				is_draggin = false;
				
				this.stopDrag();
				
				dispatchEvent(new PieceEvent(this, DROPPED));
			}
		}
	}
}
