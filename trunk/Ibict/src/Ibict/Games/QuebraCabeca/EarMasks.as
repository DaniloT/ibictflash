package Ibict.Games.QuebraCabeca
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Classe de utilidade, que prepara e armazena as máscaras para criação das "orelhas".
	 */
	public final class EarMasks extends PieceUtility
	{
		/* Nomes das classes. */
		private static const CLASS30  : String = "Ear30";
		private static const CLASS50  : String = "Ear50";
		private static const CLASS75  : String = "Ear75";
		private static const CLASS150 : String = "Ear150"; 
		
		/* Os dados de máscaras. */
		private static var masks : Dictionary = null; 
		
		/**
		 * Prepara as máscaras (matrizes) utilizadas na geração das orelhas do quebra-cabeça.
		 */
		public static function prepare() {
			if (masks == null) {
				/* Coloca os nomes das classes e as constantes de modo em arrays. */
				var classes : Array = [CLASS30, CLASS50, CLASS75, CLASS150];
				var modes	: Array = [PC_20x15, PC_12x9, PC_8x6, PC_4x3];
				
				/* Cria e preenche as máscaras das orelhas, em todos os tamanhos, em todas as direções. */
				masks = new Dictionary();
				for (var i : int = 0; i < classes.length; i++) { 
					generateEarData(classes[i], modes[i]);
				}
			}
		}
		
		/**
		 * Retorna as máscaras de geração das orelhas.
		 * 
		 * Para acessar a máscara no tamanho do modo T e na direção D, utiliza-se
		 * <code>ears_data[T][D]</code>, onde <code>T</code> é uma das constantes de modo
		 * de grade e <code>D</code> é uma das constantes de direção.
		 * 
		 * Uma máscara é uma instância de Matrix, ou seja, uma matriz, de valores
		 * booleanos, que definem se um pixel deve vir da imagem original ou ser
		 * transparente.
		 */
		public static function getMasks() : Dictionary {
			return masks;
		}
		
		
		/**
		 * Dado um modo (tamanho) carrega a imagem da biblioteca de símbolos
		 * e gera as matrizes para todas as direções, armazenando em ears_data.
		 * 
		 * @param bitmap_class Nome da imagem na biblioteca.
		 * @param grid_mode Modo de grade (tamanho).
		 */
		private static function generateEarData(bitmap_class : String, grid_mode : int) {
			/* Carrega o bitmap. */
			var ear : Class = getDefinitionByName(bitmap_class) as Class;
			var bmp : BitmapData = new ear(0, 0);
			
			/* Cria as matrizes. */
			var right	: Matrix = new Matrix(bmp.height, bmp.width);
			var left	: Matrix = new Matrix(bmp.height, bmp.width);
			var top		: Matrix = new Matrix(bmp.width, bmp.height);
			var bottom	: Matrix = new Matrix(bmp.width, bmp.height);
			
			/* Preenche as matrizes. */
			var aux : Boolean;
			for (var y : int = 0; y < bmp.height; y++) {
				for (var x : int = 0; x < bmp.width; x++) {
					aux = (bmp.getPixel(x, y) == 0);
					right.data[y][x] = aux; /* direta */
					left.data[y][left.cols - x - 1] = aux; /* reversão vertical */
					bottom.data[x][y] = aux; /* transposta da direta */
					top.data[left.cols - x - 1][y] = aux; /* transposta da reversão */
				}
			}
			
			setEarData(grid_mode, right, left, top, bottom);
		}
		
		/**
		 * Apenas atribui todas as possíveis direções de um dado modo à respectiva
		 * entrada em ears_data.
		 */
		private static function setEarData(
				id : int,
				right : Matrix, left : Matrix, top : Matrix, bottom : Matrix) {
					
			masks[id] = new Dictionary();
			masks[id][RIGHT] = right;
			masks[id][LEFT] = left;
			masks[id][TOP] = top;
			masks[id][BOTTOM] = bottom;
		}
		
		private static function show(matrix : Matrix) {
			var text : String = "";
			for (var y : int = 0; y < matrix.rows; y++) {
				for (var x : int = 0; x < matrix.cols; x++) {
					text += matrix.data[y][x] ? "#" : "_";
				}
				text += "\n";
			}
			
			trace(text);
		}
	}
}
