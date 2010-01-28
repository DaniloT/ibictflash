package Ibict.Games.QuebraCabeca
{
	/**
	 * Uma herdeira de <code>PieceUtility</code> é uma classe que auxilia no trabalho de
	 * construção de uma peça (<code>Piece</code>) do quebra-cabeças.
	 * 
	 * Essa classe genérica serve exclusivamente para compartilhar as constantes utilizadas
	 * por essas classes de utilidade.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Piece
	 * @see EarMasks
	 * @see PieceDescription
	 * @see PieceBuilder
	 */
	public class PieceUtility
	{
		/** A largura do tabuleiro. */
		public static const BOARD_WIDTH  : int = 600;
		/** A altura do tabuleiro. */
		public static const BOARD_HEIGHT : int = 450;
		
		
		/** Modo de grade com 4 peças de largura e 3 de altura. */
		public static const PC_4x3		: int = 150;
		/** Modo de grade com 8 peças de largura e 6 de altura. */
		public static const PC_8x6		: int = 75;
		/** Modo de grade com 12 peças de largura e 9 de altura. */
		public static const PC_12x9		: int = 50;
		/** Modo de grade com 20 peças de largura e 15 de altura. */
		public static const PC_20x15	: int = 30;
		
		
		/** Lado de cima da peça. */
		public static const TOP		: int = 0;
		/** Lado de baixo da peça. */
		public static const BOTTOM	: int = 1;
		/** Lado da esquerda da peça. */
		public static const LEFT	: int = 2;
		/** Lado da direita da peça. */
		public static const RIGHT	: int = 3;
	}
}
