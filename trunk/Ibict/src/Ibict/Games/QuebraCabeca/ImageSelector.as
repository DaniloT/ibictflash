package Ibict.Games.QuebraCabeca
{
	import Ibict.Button;
	import Ibict.Main;
	import Ibict.Updatable;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
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
		
		
		private var mainStage : Stage;
		
		private var thumbWidth : int;
		private var thumbHeight : int;
		
		private var images : Array;
		private var curImageIndex : int;
		
		private var btnNext : Button;
		private var btnPrev : Button;
		private var btnOK : Button;
		
		/**
		 * Cria novo ImageSelector.
		 * 
		 * @param thumbWidth a largura das miniaturas das imagens.
		 * @param thumbHeight a altura das miniaturas das imagens.
		 */
		public function ImageSelector(thumbWidth : int, thumbHeight : int)
		{
			super();
			
			this.mainStage = Main.getInstance().stage;
			
			this.thumbWidth = thumbWidth;
			this.thumbHeight = thumbHeight;
			
			this.images = new Array();
			this.curImageIndex = -1;
			
			createBackground();
			createInteface();
			
			updateUI();
		}
		
		/**
		 * Adiciona uma imagem ao final da lista.
		 * 
		 * @param bmp a imagem, na forma de um BitmapData.
		 */
		public function addImage(bmp : BitmapData, active : Boolean = true) {
			/* Cria e redimensiona a imagem. */
			var image : ImageSelectorBitmap = new ImageSelectorBitmap(bmp, active);
			image.x = mainStage.stageWidth / 2 - thumbWidth / 2;
			image.y = btnPrev.y - thumbHeight - 10;
			image.width = thumbWidth;
			image.height = thumbHeight;
			
			/* Adiciona imagem na lista. */
			images.push(image);
			
			if (curImageIndex < 0)
				curImageIndex = 0;
			
			updateUI();
		}
		
		
		
		
		/**
		 * Ativa/Desativa botões, conforme o estado da lista de imagens.
		 */
		private function updateUI() {
			btnPrev.active = curImageIndex > 0;
			btnNext.active = curImageIndex < images.length - 1;
			
			/* De certa forma, uma gambiarra... */
			if (this.numChildren > 4)
				this.removeChildAt(4);
				
			
			if (curImageIndex >= 0) {
				this.addChild(images[curImageIndex]);
				
				btnOK.active = images[curImageIndex].active;
			}
			else {
				btnOK.active = false;
			}
		}
		
		/**
		 * Inicializa o background desse seletor.
		 */
		private function createBackground() {
			/* Cria o fundo. */
			var back : Shape = new Shape();
			
			/* Preenche com um retângulo preto. */
			back.graphics.beginFill(0);
			back.graphics.drawRect(0, 0, mainStage.stageWidth, mainStage.stageHeight);
			back.graphics.endFill();
			
			this.addChild(back);
		}
		
		/**
		 * Cria e adiciona a interface à árvore de gráficos.
		 */
		private function createInteface() {
			var centerx : int = mainStage.stageWidth / 2;
			
			/* Cria botão OK. */
			btnOK = newButton(new qbcBtnOKActivated(), new qbcBtnOKDeactivated(), false, handlerOK);
			btnOK.x = centerx - btnOK.width / 2;
			btnOK.y = 500;
			this.addChild(btnOK);
			
			/* Cria botão previous. */
			btnPrev = newButton(new qbcBtnPrevActivated(), new qbcBtnPrevDeactivated(), false, handlerPrev);
			btnPrev.x = centerx - 300 - btnPrev.width / 2;
			btnPrev.y = 500;
			this.addChild(btnPrev);
			
			/* Cria botão next. */
			btnNext = newButton(new qbcBtnNextActivated(), new qbcBtnNextDeactivated(), false, handlerNext);
			btnNext.x = centerx + 300 - btnNext.width / 2;
			btnNext.y = 500;
			this.addChild(btnNext);
		}
		
		/**
		 * Cria e inicializa um novo botão.
		 */
		private function newButton(
				img_act : DisplayObject, img_deact : DisplayObject,
				active : Boolean,
				handler : Function) : Button {
			
			var button : Button = new Button(img_act, img_deact);
			button.active = active;
			button.addEventListener(Button.CLICKED, handler);
			
			return button;
		}
		
		/**
		 * Handler do botão OK.
		 */
		private function handlerOK(e : Event) {
			trace ("click");
		}
		
		/**
		 * Handler do botão Previous.
		 */
		private function handlerPrev(e : Event) {
			curImageIndex--;
			updateUI();
		}
		
		/**
		 * Handler do botão Next.
		 */
		private function handlerNext(e : Event) {
			curImageIndex++;
			updateUI();
		}
		
		
		
		/* Override. */
		public function update(e : Event) {
			/* Dá um update nos botões. */
			btnPrev.update(e);
			btnNext.update(e);
			btnOK.update(e);
		}
	}
}
