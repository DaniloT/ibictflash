package Ibict.Games.QuebraCabeca
{
	import Ibict.InputManager;
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
	public class Piece extends Bitmap implements Updatable
	{
		public static var SELECTED : String = "pieceSelected";
		public static var DROPPED  : String = "pieceDropped";
		
		
		private var input : InputManager;
		
		private var _gridx : int;
		private var _gridy : int;
		private var _anchor : Point;
		
		private var isDragging : Boolean;
		
		private var myInitPos : Point;
		private var mouseInitPos : Point;
		
		/**
		 * Cria uma nova Piece.
		 * 
		 * @param bmp a imagem da peça.
		 * @param anchor a âncora.
		 */
		public function Piece(bmp : BitmapData, anchor : Point, gridx : int, gridy : int)
		{
			super (bmp, "auto", true);
			
			this.input = InputManager.getInstance();
			
			this._gridx = gridx;
			this._gridy = gridy;
			this._anchor = anchor;
			
			this.isDragging = false;
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
		
		/* Override. */
		public function update(e : Event) {
			var lastMousePos : Point = input.getMousePoint();
			
			/* Se estava arrastando a peça. */
			if (isDragging) {
				/* E continua arrastanto, atualiza a posição. */
				if (input.isMouseDown()) {
					this.x = this.myInitPos.x + lastMousePos.x - mouseInitPos.x;
					this.y = this.myInitPos.y + lastMousePos.y - mouseInitPos.y;
				}
				/* E não está mais, soltou. */
				else {
					isDragging = false;
					dispatchEvent(new PieceEvent(this, DROPPED));
				}
			}
			/* Se não estava arrastando a peça. */
			else {
				/* E clicou dentro da peça, selecionou. */
				if (input.isMouseDown() && this.hitTestPoint(lastMousePos.x, lastMousePos.y)) {
					isDragging = true;
					this.myInitPos = new Point(this.x, this.y);
					this.mouseInitPos = lastMousePos;
					dispatchEvent(new PieceEvent(this, SELECTED));
				}
			}
		}
	}
}
