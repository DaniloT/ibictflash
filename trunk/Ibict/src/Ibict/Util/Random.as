package Ibict.Util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class Random
	{
		public function Random()
		{
			throw new ArgumentError("Shouldn't instantiate this class.");
		}
		
		/**
		 * Retorna um número aleatório entre a e b, inclusive.
		 */
		public static function rand(a : int, b : int) : int {
			return a + Math.round(Math.random() * (b - a));
		}

		/**
		 * Retorna uma posição aleatória dentro de um retângulo.
		 */		
		public static function randpos(rect : Rectangle) : Point {
			return new Point(
				rand(rect.x, rect.x + rect.width - 1),
				rand(rect.y, rect.y + rect.height - 1));
		}
	}
}
