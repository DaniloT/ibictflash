package Ibict
{
	import flash.geom.Point;
	
	public class TextureScrollable extends Texture
	{
		public var px : int, py : int;
		var center : TextureScrollable;
		
		
		public function TextureScrollable()
		{
			center = null;
			super();
		}
		
		public function setCenter(center : TextureScrollable) {
			if(center == null) {
				this.center = null;
			} else {
				this.center = center;
			}
		}
		
		public function pixelScrollCollidesWith(otherTexture : TextureScrollable, precision : uint = 1) : Boolean {
			// primeiro faz teste de colisão entre blocos, depois faz pixel a pixel
			if(hitTestObject(otherTexture)) {
				return getBitmapData().hitTest(
					new Point(px, py),
					precision,
					otherTexture.getBitmapData(),
					new Point(otherTexture.px, otherTexture.py),
					precision);
			}

			return false;
		}
		
		
		public function Render() { 
			if(center == null) {
				this.x = px;
				this.y = py;
			} else if(center == this) {
				if(this.px > 400) {
					this.x = 400;
				} else {
					this.x = px;
				}
				
				if(this.py > 300) {
					this.y = 300;
				} else {
					this.y = py;
				}
				
			} else {
				if(center.px > 400) {
					this.x = 400 + (this.px - center.px);
				} else {
					this.x = px;
				}
				
				if(center.py > 300) {
					this.y = 300 + (this.py - center.py);
				} else {
					this.y = py;
				}
				
			}
			
		}
		
	}
}