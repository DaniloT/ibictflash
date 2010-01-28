package Ibict.Games.QuebraCabeca
{
	/**
	 * Uma matriz, com as respectivas dimensões e dados, na forma de array de arrays.
	 * 
	 * @author Luciano Santos
	 */
	public class Matrix {
		public var data : Array;
		public var rows : int;
		public var cols : int;
		
		public function Matrix(rows : int, cols : int) {
			this.rows = rows;
			this.cols = cols;
			
			data = new Array(rows);
			for (var i : int = 0; i < rows; i++) {
				data[i] = new Array(cols);
			}
		}
	}
}
