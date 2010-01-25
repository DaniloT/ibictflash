package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * Descreve as orientações (interna, externa, inexistente) das
	 * orelhas em cada lado de uma peça.
	 */
	public class PieceDescription extends PieceUtility
	{
		/** Definem a direção, ou seja, se a orelha é interna, externa ou se não há orelha. */
		public static const INTERNAL : int = 0;
		public static const EXTERNAL : int = 1;
		public static const NONE	 : int = 2;
		
		private var mode		: int;
		private var side_dirs	: Array;
		
		/**
		 * Cria uma nova peça completamente lisa.
		 */
		public function PieceDescription(mode : int)
		{
			this.mode = mode;
			
			side_dirs = new Array();
			side_dirs[RIGHT] = side_dirs[LEFT] = side_dirs[TOP] = side_dirs[BOTTOM] = NONE;
		}
		
		/**
		 * Dada outra PieceDescription e a direção da orelha nesta peça, atribui
		 * as direções nos duas peças.
		 * 
		 * @param p2 a outra peça.
		 * @param dir a direção nesta peça.
		 * @param side o lado de referência dessa peça, o da outra será inferido.
		 */
		public function link(p2 : PieceDescription, dir : int, side : int) {
			var or1, or2 : int;
			
			if (dir == EXTERNAL || dir == INTERNAL) {
				//ATENÇÃO! Só funciona porque INTERNAL = 0 e EXTERNAL = 1,
				//cuidado ao alterar essas constantes!!
				or1 = dir;
				or2 = 1 - or1;
			}
			else
				or1 = or2 = NONE;
			
			switch (side) {
				case RIGHT	:
					this.side_dirs[RIGHT] = or1;
					p2.side_dirs[LEFT]    = or2;
					break;
				case LEFT	:
					this.side_dirs[LEFT] = or1;
					p2.side_dirs[RIGHT]  = or2;
					break;
				case TOP	:
					this.side_dirs[TOP]  = or1;
					p2.side_dirs[BOTTOM] = or2;
					break;
				default		:
					this.side_dirs[BOTTOM] = or1;
					p2.side_dirs[TOP]      = or2;
					break;
			}
		}
		
		public function createPiece(src : BitmapData, src_start : Point) : Piece {
			var temp : Object = getSizeAndAnchor();
			var size : Point = temp.size;
			var anchor : Point = temp.anchor;
			var bitmap : Bitmap = createBitmap(src, src_start, size);
			
			return null;
		}
		
		public static function showConnectionsAndSize(matrix : Matrix) {
			var text : String = "";
			var x, y : int;
			var aux : String;
			
			for (y = 0; y < matrix.rows; y++) {
				//primeira linha da peça
				for (x = 0; x < matrix.cols; x++) {
					text += "--";
					switch (matrix.data[y][x].side_dirs[TOP]) {
						case INTERNAL: text += "v"; break;
						case EXTERNAL: text += "^"; break;
						default : text += "-";
					}
					text += "--  ";
				}
				text += "\n";
				
				//segunda linha da peça
				for (x = 0; x < matrix.cols; x++) {
					aux = matrix.data[y][x].getSizeAndAnchor().size.x.toString();
					if (aux.length < 3) aux = " " + aux;
					
					text += "|" + aux + "|  ";
				}
				text += "\n";
				
				//terceira linha da peça
				for (x = 0; x < matrix.cols; x++) {
					switch (matrix.data[y][x].side_dirs[LEFT]) {
						case INTERNAL: text += ">"; break;
						case EXTERNAL: text += "<"; break;
						default : text += "|";
					}
					text += "   ";
					switch (matrix.data[y][x].side_dirs[RIGHT]) {
						case INTERNAL: text += "<"; break;
						case EXTERNAL: text += ">"; break;
						default : text += "|";
					}
					text += "  ";
				}
				text += "\n";
				
				//quarta linha da peça
				for (x = 0; x < matrix.cols; x++) {
					aux = matrix.data[y][x].getSizeAndAnchor().size.y.toString();
					if (aux.length < 3) aux = " " + aux;
					
					text += "|" + aux + "|  ";
				}
				text += "\n";
				
				//quinta linha da peça
				for (x = 0; x < matrix.cols; x++) {
					text += "--";
					switch (matrix.data[y][x].side_dirs[BOTTOM]) {
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
		
		/**
		 * Calcula o tamanho final e a âncora (o ponto de referência), em relação
		 * ao canto superior esquerdo da peça.
		 * 
		 * @return um objeto {size : tamanho, anchor : âncora} ambos do tipo Point.
		 */
		private function getSizeAndAnchor() : Object {
			/* Começa com a peça sem orelhas. */
			var size : Point = new Point(mode, mode);
			var anchor : Point = new Point(mode / 2, mode / 2);
			var ds : int;
			
			/* Verifica cada orelha, e ajusta se necessário. */
			if (side_dirs[TOP] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][TOP].rows;
				size.y += ds;
				anchor.y += ds;
			}
			if (side_dirs[BOTTOM] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][BOTTOM].rows;
				size.y += ds;
			}
			if (side_dirs[RIGHT] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][RIGHT].cols;
				size.x += ds;
			}
			if (side_dirs[LEFT] == EXTERNAL) {
				ds = EarMasks.getMasks()[mode][LEFT].cols;
				size.x += ds;
				anchor.x += ds;
			}
			
			return {size : size, anchor : anchor};
		}
		
		private function createBitmap(
				src : BitmapData,
				src_start : Point,
				size : Point) : Bitmap {
			
			/* Cria um BitmapData totalmente transparente. */
			var dest : BitmapData = new BitmapData(size.x, size.y, true, 0);
			
			/* Pega as máscaras para o modo atual. */
			var masks : Array = EarMasks.getMasks()[mode];
			
			var sides : Array = [RIGHT, LEFT, TOP, BOTTOM];
			var mask : Matrix;
			var dest_start : Point;
			var inverse : Boolean;
			var color : uint;
			var mx, my, sx, sy, dx, dy : int;
			
			for each (var side : int in sides) {
				/* Descobre a máscara e gera a posição e a inversão da máscara na peça. */
				var temp = getMask(side, masks, size);
				mask = temp.mask;
				dest_start = temp.pos;
				inverse = temp.inverse;
				
				/* Aplica a máscara. */
				for (my = 0, sy = src_start.y, dy = dest_start.y; my < mask.rows; my++, sy++, dy++) {
					for (mx = 0, sx = src_start.x, dx = dest_start.x; mx < mask.cols; mx++, sx++, dx++) {
						if (mask.data[my][mx] && (!inverse)) {
							color = src.getPixel32(sx, sy);
							dest.setPixel32(dx, dy, color);
						}
					}
				}
			}
			
			return new Bitmap(dest);
		}
		
		private function getMask(side : int, masks : Array, size : Point) : Object {
			var mask : Matrix;
			var x, y : int;
			var inter : Boolean = isInternal(side);
			var base_size : int = mode;
			
			switch (side) {
				case RIGHT :
					mask = inter ? masks[LEFT] : masks[RIGHT];
					
					x = 0;
					y = isInternal(TOP) ? 0 : masks[TOP].rows;
					if (mask.rows < base_size) {
						y = rand(y, size.y - mask.rows);
					}
					break;
					
				case LEFT :
					mask = inter ? masks[RIGHT] : masks[LEFT];
					
					x = base_size + (isInternal(RIGHT) ? 0 : masks[RIGHT].cols);
					y = isInternal(TOP) ? 0 : masks[TOP].rows;
					if (mask.rows < base_size) {
						y = rand(y, size.y - mask.rows);
					}
					break;
					
				case TOP :
					mask = inter ? masks[BOTTOM] : masks[TOP];
					
					x = isInternal(RIGHT) ? 0 : masks[RIGHT].cols;
					y = 0;
					if (mask.cols < base_size) { 
						x = rand(x, size.x - mask.cols);
					}
					break;
					
				default :
					mask = inter ? masks[TOP] : masks[BOTTOM];
					
					x = isInternal(RIGHT) ? 0 : masks[RIGHT].cols;
					y = base_size + (isInternal(RIGHT) ? 0 : masks[RIGHT].cols);
					if (mask.cols < base_size) { 
						x = rand(x, size.x - mask.cols);
					}
					break;
			}
			
			return {mask : mask, pos : new Point(x, y), inverse : inter};
		}
		
		private function isInternal(side : int) {
			return side_dirs[side] == INTERNAL;
		}
		
		/**
		 * Retorna um número aleatório entre a e b, inclusive.
		 */
		private static function rand(a : int, b : int) : int {
			return a + Math.round(Math.random() * (b - a));
		}
	}
}
