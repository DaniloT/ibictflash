package Ibict.Games.QuebraCabeca
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public final class PieceBuilder extends PieceUtility
	{
		/* Definem se a orelha é interna, externa ou se não há orelha. */
		private static const INTERNAL : int = 0;
		private static const EXTERNAL : int = 1;
		private static const NONE 	  : int = 2;
		
		/**
		 * Dada uma imagem, retorna uma lista de peças de quebra-cabeças.
		 * 
		 * A imagem deve ter dimensões exatamente iguais a BOARD_WIDTH e
		 * BOARD_HEIGHT.
		 * 
		 * @param source a imagem.
		 * @param mode o modo de grade do quebra cabeça.
		 * 
		 * @return a matriz de peças (Piece).
		 */
		public static function build(source : BitmapData, mode : int) : Matrix {
			/* Verificação dos parâmetros. */
			//if (source == null) throw new Error("Source null!");
			//if ((source.width != BOARD_WIDTH) || (source.height != BOARD_HEIGHT)) throw new Error("Invalid dimensions!");
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
			
			/* Preencha a matrix com "peças" definindo as conexões. */
			generateLinks(matrix);
			
			showConnections(matrix, mode);
			
			return matrix;
		}
		
		/**
		 * Define as conexões entre as peças.
		 * 
		 * É preenchida, in loco, a matriz de peças com as conexões. Aqui, uma
		 * peça é um <code>Dictionary<code> com quatro chaves RIGHT, LEFT, UP e DOWN,
		 * indicando os quatro lados da peça, o valor para cada chave indica se a
		 * orelha é interna, externa ou se não existe.
		 */
		private static function generateLinks(matrix : Matrix) {
			var data : Array = matrix.data;
			var x, y : int;
			
			/* Caso especial: primeira linha. */
			for (x = 0; x < matrix.cols; x++) {
				/* Cria a peça. */
				data[0][x] = new Dictionary();
				/* Margem superior lisa. */
				data[0][x][UP] = NONE;
			}
			
			/* Caso genérico: linhas do meio. */
			for (y = 0; y < matrix.rows - 1; y++) {
				/* Margem esquerda lisa. */
				data[y][0][LEFT] = NONE;
				
				/* Ligações laterais. */
				for (x = 0; x < matrix.cols - 1; x++) {
					/* Linka atual com a da direita. */
					link (data[y][x], data[y][x + 1], RIGHT);
				}
				/* Margem direita lisa. */
				data[y][x][RIGHT] = NONE;
				
				/* Ligações verticais. */
				for (x = 0; x < matrix.cols; x++) {
					/* Cria a peça de baixo. */
					data[y + 1][x] = new Dictionary();
					/* Linka atual com a de baixo. */
					link (data[y][x], data[y + 1][x], BOTTOM);
				}
			}
			
			/* Caso especial: última linha. */
			y = matrix.rows - 1;
			
			/* Ligações laterais. */
			for (x = 0; x < matrix.cols - 1; x++) {
				link (data[y][x], data[y][x + 1], RIGHT);
			}
			data[y][x][RIGHT] = NONE;
			
			for (x = 0; x < matrix.cols; x++) {
				/* Margem inferior lisa. */
				data[y][x][DOWN] = NONE;
			}
		}
		
		/**
		 * Dada duas "peças", sorteia a uma direção da orelha entre elas e atribui nos
		 * respectivos lados.
		 * 
		 * @param side1 o lado de referência da primeira peça, o da segunda será
		 * automaticamente inferido.
		 */
		private static function link(p1 : Dictionary, p2 : Dictionary, side1 : int) {
			var side2 : int;
			switch (side1) {
				case RIGHT	: side2 = LEFT;   break;
				case LEFT	: side2 = RIGHT;  break;
				case TOP	: side2 = BOTTOM; break;
				default		: side2 = TOP;    break;
			}
			
			if (rand(2) == 0) {
				p1[side1] = INTERNAL;
				p2[side2] = EXTERNAL;
			}
			else {
				p1[side1] = EXTERNAL;
				p2[side2] = INTERNAL;
			}
		}

		/**
		 * Retorna um inteiro x tal que 0 <= x < n.
		 */
		private static function rand(n : int) : int {
			return Math.round(Math.random() * (n - 1));
		}
				
		/**
		 * Calcula o tamanho final da peça e a âncora (o ponto de referência)
		 * da peça, em relação ao canto superior esquerdo da peça.
		 */
		private static function getPieceSize(piece : Dictionary, mode : int) : Array {
			/* Começa com a peça sem orelhas. */
			var size : Point = new Point(mode, mode);
			var anchor : Point = new Point(mode / 2, mode / 2);
			var ds : int;
			
			/* Verifica cada orelha, e ajusta se necessário. */
			if (piece[UP] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][UP].rows;
				size.y += ds;
				anchor.y += ds;
			}
			if (piece[DOWN] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][DOWN].rows;
				size.y += ds;
			}
			if (piece[RIGHT] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][RIGHT].cols;
				size.x += ds;
			}
			if (piece[LEFT] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][LEFT].cols;
				size.x += ds;
				anchor.x += ds;
			}
			
			return [size, anchor];
		}

		
		private static function showConnections(matrix : Matrix, mode : int) {
			var text : String = "";
			var x, y : int;
			var aux : String;
			
			for (y = 0; y < matrix.rows; y++) {
				//primeira linha da peça
				for (x = 0; x < matrix.cols; x++) {
					text += "--";
					switch (matrix.data[y][x][TOP]) {
						case INTERNAL: text += "v"; break;
						case EXTERNAL: text += "^"; break;
						default : text += "-";
					}
					text += "--  ";
				}
				text += "\n";
				
				//segunda linha da peça
				for (x = 0; x < matrix.cols; x++) {
					aux = getPieceSize(matrix.data[y][x], mode)[0].x.toString();
					if (aux.length < 3) aux = " " + aux;
					
					text += "|" + aux + "|  ";
				}
				text += "\n";
				
				//terceira linha da peça
				for (x = 0; x < matrix.cols; x++) {
					switch (matrix.data[y][x][LEFT]) {
						case INTERNAL: text += ">"; break;
						case EXTERNAL: text += "<"; break;
						default : text += "|";
					}
					text += "   ";
					switch (matrix.data[y][x][RIGHT]) {
						case INTERNAL: text += "<"; break;
						case EXTERNAL: text += ">"; break;
						default : text += "|";
					}
					text += "  ";
				}
				text += "\n";
				
				//quarta linha da peça
				for (x = 0; x < matrix.cols; x++) {
					aux = getPieceSize(matrix.data[y][x], mode)[0].y.toString();
					if (aux.length < 3) aux = " " + aux;
					
					text += "|" + aux + "|  ";
				}
				text += "\n";
				
				//quinta linha da peça
				for (x = 0; x < matrix.cols; x++) {
					text += "--";
					switch (matrix.data[y][x][BOTTOM]) {
						case INTERNAL: text += "^"; break;
						case EXTERNAL: text += "v"; break;
						default : text += "-";
					}
					text += "--  ";
				}
				text += "\n";
			}
			
			trace (text);
		}
	}
}
