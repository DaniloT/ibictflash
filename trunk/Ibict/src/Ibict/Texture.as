package Ibict
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Ibict.Main;
	
	/**
	 * Adiciona capacidade de colisão pixel a pixel a um MovieClip.
	 */
	public class Texture extends MovieClip
	{
		var bmap : BitmapData;
		
		/** 
		 * Construtor.
		 */
		public function Texture()
		{
			this.bmap = null;
		}
		
		/**
		 * Retorna um BitmapData do movieClip a ser usado no pixel perfect collision.
		 */ 
		private function getBitmapData() : BitmapData {
			var offset : flash.geom.Matrix;
			
			if(bmap == null) {
				var bounds: Rectangle = getBounds(Main.getInstance().stage);
				bmap = new BitmapData(
					bounds.width, bounds.height,
					true,
					0);
			
				offset = this.transform.matrix;
				offset.tx = this.x - bounds.x;
				offset.ty = this.y - bounds.y;
			
				bmap.draw(this, offset);
			}
			
			return bmap;
		}

		/**
		 * Colisão perfeita pixel a pixel.
		 * 
		 * @param otherTexture a textura com quem irá colidir
		 * 
		 * @return true, se hover colidido; false, caso contrário
		 */
		public function pixelCollidesWith(otherTexture : Texture, precision : uint = 1) : Boolean {
			// primeiro faz teste de colisão entre blocos, depois faz pixel a pixel
			if(hitTestObject(otherTexture)) {
				return getBitmapData().hitTest(
					new Point(x, y),
					precision,
					otherTexture.getBitmapData(),
					new Point(otherTexture.x, otherTexture.y),
					precision);
			}

			return false;
		}
	}
}
