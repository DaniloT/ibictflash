package Ibict.Games.QuebraCabeca
{
	import flash.display.Sprite;

	/**
	 * O "tabuleiro" onde as peças do quebra-cabeças devem ser colocadas.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Piece
	 * @see QuebraCabecaState
	 */
	public class Board extends Sprite
	{
		private var piece_size : int;
		private var cols : int;
		private var rows : int;
		
		/**
		 * Cria uma nova board.
		 */
		public function Board(mode : int)
		{
			super();
			
			piece_size = mode;
			cols = PieceUtility.BOARD_WIDTH / mode;
			rows = PieceUtility.BOARD_HEIGHT / mode;
			
			/* Desenha a borda. */
			this.graphics.lineStyle(2, 0);
			this.graphics.drawRect(0, 0, PieceUtility.BOARD_WIDTH + 4, PieceUtility.BOARD_HEIGHT + 4);
		}
		
		public function isPieceCorrect(p : Piece) : Boolean {
			var centerx = this.x + p.gridx * piece_size + piece_size / 2;
			var centery = this.x + p.gridy * piece_size + piece_size / 2;
			
			return (Math.abs(p.anchor.x + p.x - centerx) < piece_size / 5) &&
				   (Math.abs(p.anchor.y + p.y - centery) < piece_size / 5);
		}
		
		public function attach(p : Piece) {
			p.active = false;
			p.x = piece_size * p.gridx + piece_size / 2 - p.anchor.x + 2;
			p.y = piece_size * p.gridy + piece_size / 2 - p.anchor.y + 2;
			
			this.addChild(p);
		}
	}
}
