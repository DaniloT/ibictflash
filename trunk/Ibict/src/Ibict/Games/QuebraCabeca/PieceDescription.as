﻿package Ibict.Games.QuebraCabeca
{
	import Ibict.Util.Matrix;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
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
			var mask : Matrix;
			var base_size, start_lim, end_lim, ref : int;
			
			
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
			
			mask = masks[or_mask];
			p1.side_masks[side1] = p2.side_masks[side2] = mask;
			
			base_size = isVertical(side) ? mask.rows : mask.cols;
			
			if (2 * base_size < mode) {
				start_lim = mode / 2 - base_size / 2  - base_size / 3;
				end_lim = mode / 2 - base_size / 2  + base_size / 3;
			}
			else
				start_lim  = 0;
			
			ref = start_lim > 0 ? rand(start_lim, end_lim) : 0;
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
		public function createPiece(
				src : BitmapData,
				src_ref : Point,
				gridx : int, gridy : int,
				root : DisplayObjectContainer) : Piece {
			
			var temp : Object = getSizeAndAnchor();
			var size : Point = temp.size;
			var anchor : Point = temp.anchor;
			
			/* Cria um BitmapData totalmente transparente, deixando espaço para a borda. */
			var dest : BitmapData = new BitmapData(size.x + 2, size.y + 2, true, 0);
			
			/* Pega as máscaras para o modo atual. */
			var masks : Dictionary = EarMasks.getMasks()[mode];
			
			var sides : Array = [LEFT, TOP, RIGHT, BOTTOM];
			var mask : Matrix;
			var src_start, dest_start : Point;
			var inverse : Boolean;
			var color : uint;
			var mx, my, sx, sy, dx, dy, bx, by : int;
			var border_rect : Rectangle;
			
			/* Calcula coordenadas do quadrado central. */
			sx = src_ref.x; dx = anchor.x - mode / 2 + 1;
			sy = src_ref.y; dy = anchor.y - mode / 2 + 1;
			
			/* Pinta a borda. */
			border_rect = new Rectangle(dx - 1, dy - 1, mode + 2, mode + 2);
			dest.fillRect(border_rect, 0xFF000000);
			
			/* Pinta o quadrado central. */
			dest.copyPixels(src, new Rectangle(sx, sy, mode, mode), new Point(dx, dy));
			
			for each (var side : int in sides) {
				if (side_dirs[side] != NONE) {
					/* Pega a máscara. */
					mask = side_masks[side];
					
					/* Gera as posições. */
					temp = getPositions(side, masks, size, anchor, src_ref);
					src_start = temp.src_start;
					dest_start = temp.dest_start;
					
					/* Aplica a máscara e cria borda da máscara. */
					for (my = 0, sy = src_start.y, dy = dest_start.y + 1; my < mask.rows; my++, sy++, dy++) {
						for (mx = 0, sx = src_start.x, dx = dest_start.x + 1; mx < mask.cols; mx++, sx++, dx++) {
							/* Aplicação da máscara. */
							if (mask.data[my][mx]) {
								color = isExternal(side) ? src.getPixel32(sx, sy) : 0;
								
								/* Caso especial da borda. */
								if (hasSolidNeighbor(mask, mx, my)) {
									if (mx == 0) {
										if (!((side == LEFT && !isExternal(LEFT)) ||
											 (side == RIGHT && isExternal(RIGHT))))
												color = 0xFF000000;
									}
									
									if (mx == mask.cols - 1) {
										if (!((side == RIGHT && !isExternal(RIGHT)) ||
											 (side == LEFT && isExternal(LEFT))))
											 	color = 0xFF000000;
									}
									
									if (my == 0) { 
										if (!((side == TOP && !isExternal(TOP)) ||
											 (side == BOTTOM && isExternal(BOTTOM))))
											 	color = 0xFF000000;
									}
										
									if (my == mask.rows - 1) {
										if (!((side == BOTTOM && !isExternal(BOTTOM)) ||
											 (side == TOP && isExternal(TOP))))
											 	color = 0xFF000000;
									}
								}
								
								dest.setPixel32(dx, dy, color);
							}
							
							/* Borda. */
							else {
								if (hasSolidNeighbor(mask, mx, my)) {
									dest.setPixel32(dx, dy, 0xFF000000);
								}
							}
						}
					}
					
					/* Apaga a borda onde deveria ser transparente, para o caso interno. */
					if (!isExternal(side)) {
						if (isVertical(side)) {
							dx = border_rect.x + (side == LEFT ? 0 : border_rect.width - 1);
							mx = side == LEFT ? 0 : mask.cols - 1;
							
							for (my = 0, dy = dest_start.y; my < mask.rows; my++, dy++) {
								if (hasSolidNeighbor(mask, mx, my)) {
									dest.setPixel32(dx, dy, 0);
								}
							}
						}
						else {
							dy = border_rect.y + (side == TOP ? 0 : border_rect.height - 1);
							my = side == TOP ? 0 : mask.rows - 1;
							
							for (mx = 0, dx = dest_start.x; mx < mask.cols; mx++, dx++) {
								if (hasSolidNeighbor(mask, mx, my)) {
									dest.setPixel32(dx, dy, 0);
								}
							}
						}
					}
				}
			}

			return new Piece(dest, anchor, gridx, gridy, root);
		}
		
		/**
		 * Retorna o valor de uma posição de uma máscara, tratando o
		 * caso de a posição ser inválida.
		 * 
		 * @param mask a máscara.
		 * @param x coordenada x da posição.
		 * @param y coordenada y da posição.
		 * 
		 * @return o valor do elemento [y][x] da máscara ou false, se
		 * a posição for inválida (fora da máscara).
		 */
		private function getValueNoBounds(mask : Matrix, x : int, y : int) : Boolean {
			if ((x >= 0) && (x < mask.cols) && (y >= 0) && (y < mask.rows))
				return mask.data[y][x];
			
			return false;
		}
		
		/**
		 * Dada uma posição qualquer em uma máscara, verifica se ela tem
		 * algum vizinho sólido (com valor true).
		 * 
		 * Se a posição for inválida, ou seja, cair fora da máscara,
		 * considera como se fosse false.
		 * 
		 * @param mask a máscara.
		 * @param x coordenada x da posição.
		 * @param y coordenada y da posição.
		 */
		private function hasSolidNeighbor(mask : Matrix, x : int, y : int) : Boolean {
			return getValueNoBounds(mask, x + 1, y) ||
				   getValueNoBounds(mask, x - 1, y) ||
				   getValueNoBounds(mask, x, y + 1) ||
				   getValueNoBounds(mask, x, y - 1);
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
				anchor : Point,
				src_ref : Point) : Object {
			var sx, sy, dx, dy : int;
			var inter : Boolean = !isExternal(side);
			
			switch (side) {
				case LEFT :
					dx = anchor.x - mode / 2 - (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = side_pos[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x - (isExternal(LEFT) ? masks[LEFT].cols : 0);
					sy = src_ref.y + side_pos[side];
					break;
					
				case RIGHT :
					dx = anchor.x + mode / 2 - (isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					dy = side_pos[side] + (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x + mode - (isExternal(RIGHT) ? 0 : masks[RIGHT].cols);
					sy = src_ref.y + side_pos[side];
					break;
					
				case TOP :
					dx = side_pos[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = anchor.y - mode / 2 - (isExternal(TOP) ? masks[TOP].rows : 0);
					
					sx = src_ref.x + side_pos[side];
					sy = src_ref.y - (isExternal(TOP) ? masks[TOP].rows : 0);
					break;
					
				default :
					dx = side_pos[side] + (isExternal(LEFT) ? masks[LEFT].cols : 0);
					dy = anchor.y + mode / 2 - (isExternal(BOTTOM) ? 0 : masks[BOTTOM].rows);
					
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
		private function isExternal(side : int) : Boolean {
			return side_dirs[side] == EXTERNAL;
		}
		
		private function isVertical(side : int) : Boolean {
			return side == RIGHT || side == LEFT;
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