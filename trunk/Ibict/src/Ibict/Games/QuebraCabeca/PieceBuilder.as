package Ibict.Games.QuebraCabeca
{
	import Ibict.Util.Matrix;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * Um construtor de quebra-cabeças.
	 * 
	 * Dada uma imagem qualquer de dimensões <code>BOARD_WIDTH</code>,
	 * <code>BOARD_HEIGHT</code> e um modo de grade, gera todas as peças
	 * do quebra-cabeças e as retorna em uma matriz.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Piece
	 * @see PieceDescription
	 * @see Matrix
	 */
	public final class PieceBuilder extends PieceUtility
	{
		/**
		 * Dada uma imagem, retorna uma lista de peças de quebra-cabeças.
		 * 
		 * A imagem deve ter dimensões exatamente iguais a BOARD_WIDTH e
		 * BOARD_HEIGHT.
		 * 
		 * @param src a imagem.
		 * @param mode o modo de grade do quebra cabeça.
		 * 
		 * @return a matriz de peças (Piece).
		 */
		public static function build(src : BitmapData, mode : int) : Matrix {
			/* Verificação dos parâmetros. */
			if (src == null) throw new Error("Source null!");
			if ((src.width != BOARD_WIDTH) || (src.height != BOARD_HEIGHT)) throw new Error("Invalid dimensions!");
			switch (mode) {
				case PC_4x3:
				case PC_8x6:
				case PC_12x9:
				case PC_20x15:
					break;
				default:
					throw new Error("Invalid grid mode!");
			}
			
			EarMasks.prepare();
			
			/* Cria a matriz de saída. O modo é também o tamanho da peça. */
			var matrix : Matrix = new Matrix(BOARD_HEIGHT / mode, BOARD_WIDTH / mode);
			
			/* Preencha a matrix com PieceDescription definindo as conexões. */
			generateLinks(matrix, mode);
			
			/* Cria as peças de fato. */
			for (var y : int = 0; y < matrix.rows; y++) {
				for (var x : int = 0; x < matrix.cols; x++) {
					matrix.data[y][x] =
						matrix.data[y][x].createPiece(src, new Point(x * mode, y * mode), x, y);
				}
			}
			
			return matrix;
		}
		
		/**
		 * Define as conexões entre as peças.
		 * 
		 * É preenchida, in loco, a matriz de peças com as descrições de peças.
		 * 
		 * Aqui, uma peça é uma instância de PieceDescripion.
		 */
		private static function generateLinks(matrix : Matrix, mode : int) {
			var data : Array = matrix.data;
			var x, y : int;
			
			/* Caso especial: primeira linha. */
			for (x = 0; x < matrix.cols; x++) {
				data[0][x] = new PieceDescription(mode);
			}
			
			/* Caso genérico: linhas do meio. */
			for (y = 0; y < matrix.rows - 1; y++) {
				/* Ligações laterais. */
				for (x = 0; x < matrix.cols - 1; x++) {
					/* Linka atual com a da direita. */
					data[y][x].link(data[y][x + 1], RIGHT);
				}
				
				/* Ligações verticais. */
				for (x = 0; x < matrix.cols; x++) {
					/* Cria a peça de baixo. */
					data[y + 1][x] = new PieceDescription(mode);
					/* Linka atual com a de baixo. */
					data[y][x].link(data[y + 1][x], BOTTOM);
				}
			}
			
			/* Caso especial: última linha. */
			y = matrix.rows - 1;
			
			/* Ligações laterais. */
			for (x = 0; x < matrix.cols - 1; x++) {
				data[y][x].link(data[y][x + 1], RIGHT);
			}
		}
	}
}
