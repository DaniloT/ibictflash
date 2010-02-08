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
		
		private var bmp_index : int;
		private var bmp_regular : Array;
		private var bmp_highlight : Array;
		
		private var _gridx : int;
		private var _gridy : int;
		private var _anchor : Point;
		
		private var _active : Boolean;
		
		private var is_draggin : Boolean;
		
		/**
		 * Cria uma nova Piece.
		 * 
		 * @param bmp a imagem da peça.
		 * @param anchor a âncora.
		 */
		public function Piece(
				reg1 : BitmapData, reg2 : BitmapData,
				high1 : BitmapData, high2 : BitmapData,
				anchor : Point,
				gridx : int, gridy : int,
				container : DisplayObjectContainer) {
					
			super ();
			
			this.container = container;
			
			this.input = InputManager.getInstance();
			
			this.bmp_regular = new Array();
			bmp_regular.push(new Bitmap(reg1, "auto", true), new Bitmap(reg2, "auto", true));
			this.bmp_highlight = new Array();
			bmp_highlight.push(new Bitmap(high1, "auto", true), new Bitmap(high2, "auto", true));
			this.bmp_index = 0;
			
			this.addChild(bmp_regular[bmp_index]);
			
			this._gridx = gridx;
			this._gridy = gridy;
			this._anchor = anchor;
			
			this.active = true;
			
			this.is_draggin = false;
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function get active() : Boolean {
			return _active;
		}
		
		public function set active(value : Boolean) {
			if ((!value) && this.contains(bmp_highlight[bmp_index])) {
				this.removeChild(bmp_highlight[bmp_index]);
				this.addChild(bmp_regular[bmp_index]);
			}
			
			_active = value;
		}
		
		public function swap() {
			var new_index : int = 1 - bmp_index;
			
			if (this.contains(bmp_regular[bmp_index])) {
				this.removeChild(bmp_regular[bmp_index]);
				this.addChild(bmp_regular[new_index]);
			}
			else {
				this.removeChild(bmp_highlight[bmp_index]);
				this.addChild(bmp_highlight[new_index]);
			}
			
			bmp_index = new_index;
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
			return new Point(_anchor.x * scaleX, _anchor.y * scaleY);
		}
		
		
		
		private function mouseOut(e : MouseEvent) {			
			if (this.active) {
				if (this.contains(bmp_highlight[bmp_index])) {
					this.removeChild(bmp_highlight[bmp_index]);
					this.addChild(bmp_regular[bmp_index]);
				}
			}
		}
		
		private function mouseMove(e : MouseEvent) {			
			if (this.active) {
				if (this.contains(bmp_regular[bmp_index])) {
					this.removeChild(bmp_regular[bmp_index]);
					this.addChild(bmp_highlight[bmp_index]);
				}
			}
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
