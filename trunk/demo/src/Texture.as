package
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Texture extends MovieClip
	{
		var mclip : MovieClip;
		var rootComponent : DisplayObjectContainer;
		
		/**
		 * Cria um bitmap data do movieClip a ser usado no pixel perfect collision.
		 * 
		 */ 
		private function createBitMapData(mclip : MovieClip) : BitmapData {
			var bmap : BitmapData;
			var offset : Matrix;
			
			
			bmap = new BitmapData(mclip.getBounds(rootComponent.stage).width,
						mclip.getBounds(rootComponent.stage).height,
						true,
						0);
			
			offset = mclip.transform.matrix;
			offset.tx = mclip.x - mclip.getBounds(rootComponent.stage).x;
			offset.ty = mclip.y - mclip.getBounds(rootComponent.stage).y;
			
			bmap.draw(mclip, offset);
			
			return bmap;
			
			
		}

		/**
		 * Colisão perfeita por pixeis.
		 * @param otherTexture a textura com quem irá colidir
		 * 
		 * @return true, se hover colidido; false, caso contrário
		 */
		public function pixelCollidesWith(otherTexture : Texture, precision : int) {
			var bitmapData1, bitmapData2 : BitmapData;
			
			// primeiro faz teste de colisão entre blocos, depois faz por pixels
			if(mclip.hitTestObject(otherTexture.mclip)) {
				bitmapData1 = createBitMapData(mclip); 
				bitmapData2 = createBitMapData(otherTexture.mclip);
				return bitmapData1.hitTest(new Point(mclip.x, mclip.y), precision, bitmapData2, new Point(otherTexture.mclip.x, otherTexture.mclip.y), precision);
			}

			
			return false;
			
		}
		
		/**
		 * Colisao por blocos
		 * @param otherTexture a textura com quem irá colidir
		 * 
		 * @return true, se hover colidido; false, caso contrário
		 */
		public function blockCollidesWith(otherTexture : Texture) 
		{
			return mclip.hitTestObject(otherTexture.mclip);
		}
		
		/** 
		 * Construtor
		 */
		public function Texture(mclip : MovieClip, rootComponent : DisplayObjectContainer)
		{
			this.rootComponent = rootComponent;
			this.mclip = mclip;
			addChild(mclip);
			
		}

	}
}