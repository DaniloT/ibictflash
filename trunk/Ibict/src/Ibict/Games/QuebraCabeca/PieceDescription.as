package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * Descreve as orientações (interna, externa, inexistente) bem como as posições das
	 * orelhas em cada lado de uma peça.
	 * <br>
	 * Ao ser criada, uma <code>PieceDescription</code> descreve uma peça totalmente lisa,
	 * sem relacionamento com outras peças. A única forma de alterar a configuração de uma
	 * descrição de peça é fazer um <i>link</i> com outras peças.
	 * <br>
	 * Isso faz sentido por dois motivos: mantem a consistência entre duas ou mais peças,
	 * impedindo que o usuário inadivertidamente dê valores incorretos para duas peças
	 * conectadas; e porque o quebra-cabeça é criado todo de uma vez, e não por partes.
	 * <br>
	 * Uma vez encerradas as ligações e terminada a definição da peça, PieceDescription
	 * permite a geração de uma nova instância de Piece, criando a imagem final da peça.
	 * <br>
	 * Um ciclo típico de utilização de PieceDescription seria:<br>
	 * - cria uma nova <code>PieceDescription</code>, gerando uma peça totalmente lisa.<br>
	 * - uma ou mais chamadas a <code>link</code> estabelece as conexões e altera os lados
	 * da peça<br>
	 * - uma chamada a <code>createPiece</code> gera a imagem final da peça.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see Piece
	 * @see PieceBuilder
	 */
	public class PieceDescription extends PieceUtility
	{
		/* Definem a direção, ou seja, se a orelha é interna, externa ou se não há orelha. */
		private static const INTERNAL : int = 0;
		private static const EXTERNAL : int = 1;
		private static const NONE	  : int = 2;
		
		/* O modo de grade. */
		private var mode		: int;
		
		/*--
		 * Guardam, respectivamente, as direções, as posições e as máscaras para os lados
		 * (LEFT, RIGHT, TOP e BOTTOM) da peça. Todos são arrays indexados pelo lado.
		 */ 
		private var side_dirs	: Array;
		private var side_pos	: Array;
		private var side_masks	: Array;
		
		/**
		 * Cria uma nova peça completamente lisa.
		 * 
		 * @param mode o modo de grade.
		 */
		public function PieceDescription(mode : int)
		{
			this.mode = mode;
			
			this.side_dirs  = new Array();
			this.side_pos   = new Array();
			this.side_masks = new Array();
			
			var sides : Array = [RIGHT, LEFT, TOP, BOTTOM];
			for each (var side : int in sides) {
				side_dirs[side] = NONE;
				side_pos[side] = 0;
				side_masks[side] = null;
			}
		}
		
		/**
		 * Dado um lado nessa peça e outra PieceDescription, sorteia uma direção e
		 * uma posição da orelha e atribui as direções corretas nas duas peças.
		 * 
		 * @param p2 a outra peça.
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
			p1.side_pos[side1] = p2.side_pos[side2] = ref;
		}
		
		/**
		 * Cria uma nova peça a partir dessa descrição.
		 * 
		 * @param src a imagem de origem.
		 * @param src_ref a posição, na imagem de origem, do quadrado principal (sem orelhas) da peça.
		 * 
		 * @return a peça criada.
		 */
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
			
			return new Piece(dest, anchor);
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
		
		/**
		 * Calcula a posição da máscara de orelha tanto na imagem de origem quanto
		 * na imagem de destino.
		 * 
		 * @param side o lado onde a máscara será aplicada.
		 * @param masks o conjunto de máscarad para o modo atual.
		 * @param size o tamanho total da peça.
		 * @param src_ref a posição, na imagem de origem, do quadrado principal (sem orelhas) da peça.
		 * 
		 * @return um objeto {src_start : posição na origem, dest_start : posição no destino} ambos os
		 * campos do tipo Point.
		 */
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
					dy = side_pos[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x - (isExternal(LEFT) ? masks[LEFT].cols : 0);
					sy = src_ref.y + side_pos[side];
					break;
					
				case RIGHT :
					dx = mode +
						(isExternal(LEFT) ? masks[LEFT].cols : 0) -
						(isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					dy = side_pos[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x + mode - (isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					sy = src_ref.y + side_pos[side];
					break;
					
				case TOP :
					dx = side_pos[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = 0;
					
					sx = src_ref.x + side_pos[side];
					sy = src_ref.y - (isExternal(TOP) ? masks[TOP].rows : 0);
					break;
					
				default :
					dx = side_pos[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = mode +
						(isExternal(TOP) ? masks[TOP].rows : 0) -
						(isExternal(BOTTOM) ? 0 : masks[BOTTOM].rows);
					
					sx = src_ref.x + side_pos[side];
					sy = src_ref.y + mode - (isExternal(BOTTOM) ? 0 : masks[BOTTOM].rows);
					break;
			}
			
			return {src_start : new Point(sx, sy), dest_start : new Point(dx, dy)};
		}
		
		/**
		 * Define se o lado <code>side</code> dessa peça é externo, ou seja, se tem
		 * uma orelha para fora.
		 * 
		 * @return true se o lado for externo, false caso contrário.
		 */
		private function isExternal(side : int) {
			return side_dirs[side] == EXTERNAL;
		}
		
		/**
		 * Retorna um número aleatório entre a e b, inclusive.
		 */
		private static function rand(a : int, b : int) : int {
			return a + Math.round(Math.random() * (b - a));
		}
		
		/**
		 * Dada uma matriz de PieceDescription, mostra, usando <code>trace</code>,
		 * a disposição das orelhas e o tamanho de cada peça.
		 * 
		 * @param matrix a matriz.
		 */
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
	}
}
