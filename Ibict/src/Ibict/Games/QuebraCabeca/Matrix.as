package Ibict.Games.QuebraCabeca
{
	/**
	 * Uma matriz.
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
