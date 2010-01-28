package Ibict.Games.QuebraCabeca
{
	import Ibict.Button;
	import Ibict.Updatable;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Descreve um seletor de imagens, que possui uma lista pré-definida de imagens
	 * e permite ao usuário navegar entre as mesmas e selecionar uma, quando lança
	 * um evento de imagem selecionada (ImageSelectedEvent).
	 * <br>
	 * Para ouvir por eventos de imagem selecionada, utilize:
	 * <br>
	 * <code>addEventListener(IMAGE_SELECTED, callback)</code>
	 * <br>
	 * 
	 * @author Luciano Santos
	 * 
	 * @see ImageSelectedEvent
	 */
	public class ImageSelector extends MovieClip implements Updatable
	{
		/** Identifica o evento de imagem selecionada. */
		public static var IMAGE_SELECTED : String = "imageSelected";
		
		
		private var images : Array;
		private var curImageIndex : int;
		
		private var btnNext : Button;
		private var btnPrev : Button;
		private var btnOK : Button;
		
		/**
		 * Cria novo ImageSelector.
		 */
		public function ImageSelector()
		{
			this.btnNext = new Button(new qbcBtnNextActivated(), new qbcBtnNextDeactivated());
			this.btnPrev = new Button(new qbcBtnPrevActivated(), new qbcBtnPrevDeactivated());
			this.btnOK = new Button(new qbcBtnOKActivated(), new qbcBtnOKDeactivated());
			
			btnPrev.x = 100;
			btnPrev.y = 100;
			btnPrev.addEventListener(Button.CLICKED, handlerPrev);
			this.addChild(btnPrev);
			
			btnOK.x = 400;
			btnOK.y = 100;
			btnOK.addEventListener(Button.CLICKED, handlerOK);
			this.addChild(btnOK);
			
			btnNext.x = 700;
			btnNext.y = 100;
			btnNext.addEventListener(Button.CLICKED, handlerNext);
			this.addChild(btnNext);
		}
		
		private function handlerOK(e : Event) {
			trace ("click");
		}
		
		private function handlerPrev(e : Event) {
			btnOK.active = false;
		}
		
		private function handlerNext(e : Event) {
			btnOK.active = true;
		}
		
		public function addImage(bmp : BitmapData) {
			
		}
		
		/* Override. */
		public function update(e : Event) {
			btnPrev.update(e);
			btnNext.update(e);
			btnOK.update(e);
		}
	}
}

