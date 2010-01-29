package Ibict.Games.QuebraCabeca
{
	import flash.display.Bitmap;
	import flash.events.Event;

	/**
	 * Evento lançado quando uma imagem é selecionada no ImageSelector.
	 * 
	 * @author Luciano Santos
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
				type : String,
				bubbles : Boolean=false,
				cancelable : Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._image = image;
		}
		
		/**
		 * A imagem selecionada no ImageSelector.
		 */
		public function get image() : int {
			return _image;
		}
	}
}
