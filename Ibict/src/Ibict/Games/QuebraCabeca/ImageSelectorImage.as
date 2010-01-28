package Ibict.Games.QuebraCabeca
{
	import Ibict.InputManager;
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * Uma das imagens do ImageSelector.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see ImageSelector
	 */
	public class ImageSelectorImage extends Bitmap
	{
		private var input : InputManager;
		
		private var _active : Boolean;
		
		/**
		 * Cria nova imagem.
		 */
		public function ImageSelectorImage(bmp : BitmapData)
		{
			super(bmp);
			
			this.input = InputManager.getInstance();
			
			this.ative = true;
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
			this._active = value;
		}
	}
}
