package Ibict.Games.QuebraCabeca
{
	import Ibict.Updatable;
	import Ibict.Util.Matrix;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * Controla o modo "Em Jogo" do quebra cabeça.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see QuebraCabecaState
	 */
	public class QuebraCabecaInGame extends Sprite implements Updatable
	{
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
			board.x = 100;
			board.y = 100;
			this.addChild(board);
			
			/* Cria as peças do quebra-cabeças. */
			pieces = PieceBuilder.build(img, mode, this);
			for (i = 0; i < pieces.rows; i++) {
				for (j = 0; j < pieces.cols; j++) {
					p = pieces.data[i][j];
					
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
