package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.Updatable;
	import Ibict.Util.Button;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
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
		
		
		private static const BTN_TO_LABEL	: int = 10;
		private static const LABEL_HEIGHT	: int = 20;
		private static const LABEL_TO_IMG	: int = 10;
		private static const IMG_TO_TITLE	: int = 10;
		private static const TITLE_HEIGHT	: int = 25;
		
		private static const TRANS_FRAME_COUNT : int = 20;
		
		
		/* O stage principal. */
		private var main_stage : Stage;
		
		/* O tamanho das miniaturas de imagens. */
		private var thumb_width : int;
		private var thumb_height : int;
		private var thumb_x : int;
		private var thumb_y : int;
		
		/* As imagens desse seletor. */
		private var images : Array;
		/* Índice da imagem atual. */
		private var cur_img_index : int;
		/* A imagem corrente. */
		private var cur_img : ImageSelectorBitmap;
		
		/* Botões da interface. */
		private var btn_next : Button;
		private var btn_prev : Button;
		private var btn_ok : Button;
		
		private var txt_title : TextField;
		private var txt_label : TextField;
		
		/* O índice da imagem que vai ser mostrada em seguida. */
		private var toshow_img_index : int;
		/* A imagem que vai ser mostrada em seguida, não necessariamente a próxima da lista. */
		private var toshow_img : ImageSelectorBitmap;
		
		/* A transição atualmente ativa. */
		private var trans : ImageSelectorTransition;
		
		/**
		 * Cria novo ImageSelector.
		 * 
		 * @param thumb_width a largura das miniaturas das imagens.
		 * @param thumb_height a altura das miniaturas das imagens.
		 */
		public function ImageSelector(thumb_width : int, thumb_height : int, title : String)
		{
			super();
			
			this.main_stage = Main.getInstance().stage;
			
			this.thumb_width = thumb_width;
			this.thumb_height = thumb_height;
			
			this.images = new Array();
			this.cur_img_index = -1;
			this.cur_img = null;
			
			createBackground();
			createInteface(title);
		}
		
		/**
		 * Adiciona uma imagem ao final da lista.
		 * 
		 * @param bmp a imagem, na forma de um BitmapData.
		 */
		public function addImage(bmp : BitmapData, name : String, active : Boolean = true) {
			/* Cria e redimensiona a imagem. */
			var image : ImageSelectorBitmap = new ImageSelectorBitmap(bmp, name, active);
			image.x = thumb_x;
			image.y = thumb_y;
			image.width = thumb_width;
			image.height = thumb_height;
			
			/* Adiciona imagem na lista. */
			images.push(image);
			
			if (currentImageIndex < 0) {
				currentImageIndex = 0;
			}
			
			this.updateUI();
		}
		
		/**
		 * Retorna a índice da imagem atual.
		 */
		public function get currentImageIndex() : int {
			return this.cur_img_index;
		}
		
		/**
		 * Define o índice da imagem atual, iniciando em 0.
		 * 
		 * Se o índice especificado for negativo, nenhuma imagem estará disponível.
		 * Se o índice especificado for igual ou maior que o número de imagens, um erro será lançado.
		 *
		 * @param value o índice.
		 */
		public function set currentImageIndex(value : int) {
			var next_img = value < 0 ? null : this.images[value];
			
			/* Se necessário, remove a imagem atual da árvore. */
			if (cur_img != null)
				this.removeChild(cur_img);
			
			/* Se necessário, adiciona a nova imagem. */
			if (next_img != null)
				this.addChild(next_img);
			
			this.cur_img = next_img;
			this.cur_img_index = value;
			this.updateUI();
		}
		
		
		
		/**
		 * Ativa/Desativa botões, conforme o estado da lista de imagens.
		 */
		private function updateUI() {
			btn_prev.active = currentImageIndex > 0;
			btn_next.active = currentImageIndex < images.length - 1;
			btn_ok.active = currentImageIndex < 0 ? false : cur_img.active;
			
			
			txt_label.text = cur_img == null ? "" : cur_img.name;
			var format : TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = LABEL_HEIGHT;
			format.color = 0xFFFFFF;
			format.bold = true;
			txt_label.setTextFormat(format);
			txt_label.x = main_stage.stageWidth / 2 - txt_label.width / 2;
		}
		
		/**
		 * Desativa todos os botões.
		 */
		private function lockUI() {
			btn_ok.active = false;
			btn_prev.active = false;
			btn_next.active = false;
		}
		
		/**
		 * Calcula a posição e posiciona todos os elementos da UI.
		 */
		private function posUI() {
			/* Calcula as posições de referência. */
			var centerx : int = main_stage.stageWidth / 2;
			var centery : int = main_stage.stageHeight / 2;
			var max_btn_height : int = Math.max(btn_ok.height, btn_prev.height, btn_next.height);
			var max_height : int =
				max_btn_height + /* altura do maior botão */
				BTN_TO_LABEL + /* espaço entre o botão e o nome da imagem */
				LABEL_HEIGHT + /* altura do nome da imagem */
				LABEL_TO_IMG + /* espaço entre o nome da imagem e a imagem */
				thumb_height + /* altura da imagem */
				IMG_TO_TITLE + /* espaço entre a imagem e o título do seletor. */
				TITLE_HEIGHT; /* altura do título do seletor. */
			
			var basey : int =
				max_height < main_stage.stageHeight ?
					centery + max_height / 2 :
					main_stage.stageHeight - 10;
			
			
			/* Seta as posições verticais. */
			btn_ok.y = basey - max_btn_height / 2 - btn_ok.height / 2;
			btn_prev.y = basey - max_btn_height / 2 - btn_prev.height / 2;
			btn_next.y = basey - max_btn_height / 2 - btn_next.height / 2;
			
			txt_label.y = basey - max_btn_height - BTN_TO_LABEL - LABEL_HEIGHT;
			
			thumb_y = txt_label.y - LABEL_TO_IMG - thumb_height;
			
			txt_title.y = thumb_y - IMG_TO_TITLE - TITLE_HEIGHT;
			
			
			/* Seta as posições horizontais. */
			thumb_x = centerx - thumb_width / 2;
			
			btn_ok.x = centerx - btn_ok.width / 2;
			if ((btn_ok.width + btn_prev.width + btn_next.width <= thumb_width) &&
				(thumb_width <= main_stage.stageWidth)) {
				btn_prev.x = thumb_x;
				btn_next.x = thumb_x + thumb_width - btn_next.width;
			}
			else {
				btn_prev.x = btn_ok.x - 10 - btn_prev.width;
				btn_next.x = btn_ok.x + btn_ok.width + 10 + btn_next.width;
			}
			
			
			txt_title.x = centerx - txt_title.width / 2;
		}
		
		/**
		 * Handler do botão OK.
		 */
		private function handlerOK(e : Event) {
			dispatchEvent(new ImageSelectorEvent(cur_img, IMAGE_SELECTED));
		}
		
		/**
		 * Handler do botão Previous.
		 */
		private function handlerPrev(e : Event) {
			startTransition(cur_img_index - 1, ImageSelectorTransition.RIGHT);
		}
		
		/**
		 * Handler do botão Next.
		 */
		private function handlerNext(e : Event) {
			startTransition(cur_img_index + 1, ImageSelectorTransition.LEFT);
		}
		
		/**
		 * Dispara a transição entre duas imagens.
		 */
		private function startTransition(next_index : int, direction : int) {
			lockUI();
			
			toshow_img_index = next_index;
			toshow_img = images[toshow_img_index];
			this.addChild(toshow_img);
			
			trans = new ImageSelectorTransition(
				cur_img, toshow_img,
				direction,
				TRANS_FRAME_COUNT,
				onTransitionEnd);
		}
		
		/**
		 * Callback para quando a transição terminou.
		 */
		private function onTransitionEnd(e : Event) {
			this.removeChild(toshow_img);
			
			this.toshow_img.x = this.cur_img.x = thumb_x;
			this.toshow_img.mask = this.cur_img.mask = null;
			
			this.currentImageIndex = toshow_img_index;
		}
		
		
		
				
		/**
		 * Inicializa o background desse seletor.
		 */
		private function createBackground() {
			/* Cria o fundo. */
			var back : Shape = new Shape();
			
			/* Preenche com um retângulo preto. */
			back.graphics.beginFill(0);
			back.graphics.drawRect(0, 0, main_stage.stageWidth, main_stage.stageHeight);
			back.graphics.endFill();
			
			this.addChild(back);
		}
		
		/**
		 * Cria e adiciona a interface à árvore de gráficos.
		 */
		private function createInteface(title : String) {
			/* Cria os botões. */
			btn_ok = newButton(new Bitmap(new qbcBtnOKActivated()), new Bitmap(new qbcBtnOKDeactivated()), false, handlerOK);
			this.addChild(btn_ok);
			btn_prev = newButton(new qbcBtnPrevActivated(), new qbcBtnPrevDeactivated(), false, handlerPrev);
			this.addChild(btn_prev);
			btn_next = newButton(new qbcBtnNextActivated(), new qbcBtnNextDeactivated(), false, handlerNext);
			this.addChild(btn_next);
			
			/* Cria as caixas de texto. */
			txt_title = newTextField(title, TITLE_HEIGHT);
			this.addChild(txt_title);
			
			txt_label = newTextField("", LABEL_HEIGHT);
			this.addChild(txt_label);
			
			posUI();
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
		 * Cria e inicializa uma nova caixa de texto.
		 */
		private function newTextField(text : String, size : int) : TextField {
			var txt : TextField = new TextField();
			
			txt.text = text;
			txt.type = TextFieldType.DYNAMIC;
			txt.selectable = false;
			txt.autoSize = TextFieldAutoSize.CENTER;
			
			var format : TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = size;
			format.color = 0xFFFFFF;
			format.bold = true;
			txt.setTextFormat(format);
			
			return txt;
		}

		
		
		
		/* Override. */
		public function update(e : Event) {
			/* Dá um update nos botões. */
			btn_prev.update(e);
			btn_next.update(e);
			btn_ok.update(e);
		}
	}
}
