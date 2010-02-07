package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	import Ibict.Util.Matrix;
	import Ibict.Util.Random;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Controla o modo "Em Jogo" do quebra cabeça.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see QuebraCabecaState
	 */
	public class QuebraCabecaInGame extends Sprite implements Updatable
	{
		public static const BOUNDS : Rectangle = new Rectangle(
			50, 50,
			PieceUtility.BOARD_WIDTH - 50, PieceUtility.BOARD_HEIGHT - 50);
			
		var pieces : Matrix;
		var board : Board;
		
		/**
		 * Inicia um novo jogo de quebra-cabeça.
		 * 
		 * @param mode o modo de grade.
		 * @param img a imagem a ser utilizada.
		 */
		public function QuebraCabecaInGame(mode : int, img : BitmapData)
		{
			var i, j : int;
			var p : Piece;
			
			/* Cria e adiciona o "tabuleiro". */
			board = new Board(mode);
			board.x = 190;
			board.y = 100;
			this.addChild(board);
			
			/* Cria as peças do quebra-cabeças. */
			var lim_rect : Rectangle = new Rectangle(0, 0, 150, PieceUtility.BOARD_HEIGHT - mode);
			pieces = PieceBuilder.build(img, mode, this);
			for (i = 0; i < pieces.rows; i++) {
				for (j = 0; j < pieces.cols; j++) {
					var pt : Point = Random.randpos(lim_rect);
					
					p = pieces.data[i][j];
					p.x = pt.x;
					p.y = pt.y;
					p.addEventListener(Piece.SELECTED, selectedHandler);
					p.addEventListener(Piece.DROPPED, droppedHandler);
					this.addChild(p);
				}
			}
		}
		
		
		
		private function selectedHandler(e : PieceEvent) {}
		
		private function droppedHandler(e : PieceEvent) {
			if (board.isPieceCorrect(e.piece)) {
				this.removeChild(e.piece);
				board.attach(e.piece);
			}
		}


		/* Override */
		public function update(e : Event)
		{
		}
	}
}
