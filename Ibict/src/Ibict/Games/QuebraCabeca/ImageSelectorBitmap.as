package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Uma das imagens do ImageSelector.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see ImageSelector
	 */
	public class ImageSelectorBitmap extends Bitmap
	{
		private var bmp_active : BitmapData;
		private var bmp_inactive : BitmapData;
		
		private var _active : Boolean;
		
		/**
		 * Cria nova imagem.
		 */
		public function ImageSelectorBitmap(bmp : BitmapData, name : String, active : Boolean = true)
		{
			super(bmp);
			
			this.name = name;
			
			this.bmp_active = bmp;
			createInactive();
			
			this.active = active;
		}
		
		/**
		 * Define se a imagem está ativa ou não.
		 * 
		 * Uma imagem inativa será mostrada (em tons de cinza), mas não poderá ser selecionada.
		 */
		public function get active() : Boolean {
			return _active;
		}
		
		/**
		 * Ativa ou desativa a imagem.
		 */
		public function set active(value : Boolean) {
			this.bitmapData = value ? bmp_active : bmp_inactive;
			this._active = value;
		}
		
		
		
		/**
		 * Cria uma versão em preto e branco da imagem.
		 */
		private function createInactive() {
			/* Matriz para converter imagem para gray scale. */
			var mat : Array = [
				.33, .33, .33, 0, 0,
				.33, .33, .33, 0, 0,
				.33, .33, .33, 0, 0,
				  0,   0,   0, 1, 0
			];

			bmp_inactive = new BitmapData(bmp_active.width, bmp_active.height, bmp_active.transparent);
			bmp_inactive.applyFilter(
				bmp_active,
				new Rectangle(0, 0, bmp_active.width, bmp_active.height),
				new Point(0, 0),
				new ColorMatrixFilter(mat));
		}
	}
}
