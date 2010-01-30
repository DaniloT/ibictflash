package Ibict
{
	/**
	 * Interpolador que usa a equação cúbica, para movimentos suaves próximo
	 * às key-frames.
	 * 
	 * @author Luciano Santos
	 */
	public class CubicInterpolator extends Interpolator
	{
		public function CubicInterpolator()
		{
		}
		
		protected override function evaluate(u : Number) : Number {
			return start * (2 * u * u * u - 3 * u * u + 1) + end * (3 * u * u - 2 * u * u * u);
		}
	}
}
