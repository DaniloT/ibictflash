package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.events.Event;

	/**
	 * Evento lançado quando uma imagem é selecionada no ImageSelector.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see ImageSelector
	 */
	public class ImageSelectorEvent extends Event
	{
		private var _image : Bitmap;
		
		/**
		 * Cria novo ImageSelectorEvent.
		 * 
		 * @param image_index índice da imagem no ImageSelector.
		 */
		public function ImageSelectorEvent(
				image : Bitmap,
				type : String)
		{
			super(type);
			
			this._image = image;
		}
		
		/**
		 * A imagem selecionada no ImageSelector.
		 */
		public function get image() : Bitmap {
			return _image;
		}
	}
}
