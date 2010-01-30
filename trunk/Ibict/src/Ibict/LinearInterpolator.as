package Ibict
{
	/**
	 * Interpolador linear simples.
	 * 
	 * @author Luciano Santos
	 */
	public class LinearInterpolator extends Interpolator
	{
		public function LinearInterpolator()
		{
		}
		
		protected override function evaluate(u : Number) : Number {
			return start + u * (end - start);
		}
	}
}
