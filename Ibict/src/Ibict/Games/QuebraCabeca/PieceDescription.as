package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
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
		private var side_refs	: Array;
		private var side_masks	: Array;
		
		/**
		 * Cria uma nova peça completamente lisa.
		 */
		public function PieceDescription(mode : int)
		{
			this.mode = mode;
			
			this.side_dirs  = new Array();
			this.side_refs  = new Array();
			this.side_masks = new Array();
			
			var sides : Array = [RIGHT, LEFT, TOP, BOTTOM];
			for each (var side : int in sides) {
				side_dirs[side] = NONE;
				side_refs[side] = 0;
				side_masks[side] = null;
			}
		}
		
		/**
		 * Dada outra PieceDescription e a direção da orelha nesta peça, atribui
		 * as direções nos duas peças.
		 * 
		 * @param p2 a outra peça.
		 * @param dir a direção nesta peça.
		 * @param side o lado de referência dessa peça, o da outra será inferido.
		 */
		public function link(p2 : PieceDescription, side : int) {
			var p1 : PieceDescription = this;
			var or1, or2, or_mask : int;
			var side1, side2 : int;
			var masks : Dictionary = EarMasks.getMasks()[mode];
			var lim, ref : int;
			
			
			/* Gera as orientações. */
			or1 = (rand(0, 1) == 0) ? INTERNAL : EXTERNAL;
			or2 = (or1 == INTERNAL) ? EXTERNAL : INTERNAL;
			
			/* Descobre os lados a serem alterados. */
			side1 = side;
			switch (side) {
				case RIGHT:		side2 = LEFT;	break;
				case LEFT:		side2 = RIGHT;	break;
				case TOP:		side2 = BOTTOM;	break;
				default:		side2 = TOP;	break;
			}
			
			/* Descobre a orientação da máscara. */
			or_mask = (or1 == EXTERNAL) ? side1 : side2;
			
			
			/* Seta os valores. */
			
			p1.side_dirs[side1] = or1;
			p2.side_dirs[side2] = or2;
			
			p1.side_masks[side1] = p2.side_masks[side2] = masks[or_mask];
			
			lim = mode - ((side == RIGHT || side == LEFT) ? masks[or_mask].rows : masks[or_mask].cols);
			ref = lim > 0 ? rand(0, lim) : 0;
			p1.side_refs[side1] = p2.side_refs[side2] = ref;
		}
		
		public function createPiece(src : BitmapData, src_ref : Point) : Piece {
			var temp : Object = getSizeAndAnchor();
			var size : Point = temp.size;
			var anchor : Point = temp.anchor;
			
			/* Cria um BitmapData totalmente transparente. */
			var dest : BitmapData = new BitmapData(size.x, size.y, true, 0);
			
			/* Pega as máscaras para o modo atual. */
			var masks : Dictionary = EarMasks.getMasks()[mode];
			
			var sides : Array = [LEFT, TOP, RIGHT, BOTTOM];
			var mask : Matrix;
			var src_start, dest_start : Point;
			var inverse : Boolean;
			var color : uint;
			var mx, my, sx, sy, dx, dy : int;
			
			/* Copia o quadrado central. */
			sx = src_ref.x; dx = !isExternal(LEFT) ? 0 : masks[LEFT].cols;
			sy = src_ref.y; dy = !isExternal(TOP) ? 0 : masks[TOP].rows;
			dest.copyPixels(src, new Rectangle(sx, sy, mode, mode), new Point(dx, dy));
			
			for each (var side : int in sides) {
				if (side_dirs[side] != NONE) {
					/* Pega a máscara. */
					mask = side_masks[side];
					/* Gera as posições. */
					temp = getPositions(side, masks, size, src_ref);
					src_start = temp.src_start;
					dest_start = temp.dest_start;
					
					/* Aplica a máscara. */
					for (my = 0, sy = src_start.y, dy = dest_start.y; my < mask.rows; my++, sy++, dy++) {
						for (mx = 0, sx = src_start.x, dx = dest_start.x; mx < mask.cols; mx++, sx++, dx++) {
							if (mask.data[my][mx]) {
								color = isExternal(side) ? src.getPixel32(sx, sy) : 0;
								dest.setPixel32(dx, dy, color);
							}
						}
					}
				}
			}
			
			return new Piece(anchor, new Bitmap(dest));
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
			if (isExternal(TOP)) {
				ds = EarMasks.getMasks()[mode][TOP].rows;
				size.y += ds;
				anchor.y += ds;
			}
			if (isExternal(BOTTOM)) {
				ds = EarMasks.getMasks()[mode][BOTTOM].rows;
				size.y += ds;
			}
			if (isExternal(RIGHT)) {
				ds = EarMasks.getMasks()[mode][RIGHT].cols;
				size.x += ds;
			}
			if (isExternal(LEFT)) {
				ds = EarMasks.getMasks()[mode][LEFT].cols;
				size.x += ds;
				anchor.x += ds;
			}
			
			return {size : size, anchor : anchor};
		}
		
		private function getPositions(
				side : int,
				masks : Dictionary,
				size : Point,
				src_ref : Point) : Object {
			var sx, sy, dx, dy : int;
			var inter : Boolean = !isExternal(side);
			
			switch (side) {
				case LEFT :
					dx = 0;
					dy = side_refs[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x - (isExternal(LEFT) ? masks[LEFT].cols : 0);
					sy = src_ref.y + side_refs[side];
					break;
					
				case RIGHT :
					dx = mode +
						(isExternal(LEFT) ? masks[LEFT].cols : 0) -
						(isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					dy = side_refs[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x + mode - (isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					sy = src_ref.y + side_refs[side];
					break;
					
				case TOP :
					dx = side_refs[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = 0;
					
					sx = src_ref.x + side_refs[side];
					sy = src_ref.y - (isExternal(TOP) ? masks[TOP].rows : 0);
					break;
					
				default :
					dx = side_refs[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = mode +
						(isExternal(TOP) ? masks[TOP].rows : 0) -
						(isExternal(BOTTOM) ? 0 : masks[BOTTOM].rows);
					
					sx = src_ref.x + side_refs[side];
					sy = src_ref.y + mode - (isExternal(BOTTOM) ? 0 : masks[BOTTOM].rows);
					break;
			}
			
			return {src_start : new Point(sx, sy), dest_start : new Point(dx, dy)};
		}
		
		private function isExternal(side : int) {
			return side_dirs[side] == EXTERNAL;
		}
		
		/**
		 * Retorna um número aleatório entre a e b, inclusive.
		 */
		private static function rand(a : int, b : int) : int {
			return a + Math.round(Math.random() * (b - a));
		}
	}
}
