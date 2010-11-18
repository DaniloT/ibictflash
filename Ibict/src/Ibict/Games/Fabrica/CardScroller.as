package Ibict.Games.Fabrica
{
	import Ibict.Updatable;
	import Ibict.Util.Button;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * Descreve um seletor de cartas, que possui uma lista pré-definida de cartas
	 * e permite ao usuário navegar entre as mesmas e selecionar uma.
	 */
	public class CardScroller extends MovieClip implements Updatable
	{
		public static const WIDTH : int = 138;
		public static const HEIGHT : int = 468;


		private static const UP : int = 0;
		private static const DOWN : int = 1;
		
		/* Os índices das cartas desse seletor. */
		private var indexes : Array;
		private var cur_index : int;


		/* Botões da interface. */
		private var btn_up : Button;
		private var btn_down : Button;
		
		private var card_width : int;
		private var card_height : int;
		
		private var view : MovieClip;
		private var view_width : int;
		private var view_height : int;
		private var view_card_cnt : int;


		/**
		 * Cria novo CardScroller.
		 */
		public function CardScroller(card_width : int, card_height : int)
		{
			super();

			this.card_width = card_width;
			this.card_height = card_height;

			this.indexes = new Array();
			this.cur_index = -1;

			this.createUI();
		}
		
		/**
		 * Adiciona uma carta ao final da lista.
		 * 
		 * @param index O índice da carta.
		 */
		public function addCard(index : int) {
			indexes.push(index);
			
			if (cur_index < 0)
				cur_index = 0;

			this.updateView();
		}
		
		/**
		 * Remove a carta pelo seu índice e retorna a mesma.
		 * 
		 * @param index O índice da carta.
		 */
		public function removeCard(index : int) {
			var i : int = indexes.indexOf(index);
			if (i >= 0) {
				indexes.splice(i, 1);
				if (indexes.length == 0)
					cur_index = -1;

				this.updateView();
			}
		}


		/**
		 * Cria e adiciona a interface à árvore de gráficos.
		 */
		private function createUI() {
			/* Cria os botões. */
			btn_up = newButton(
				new Bitmap(new fabBtnUpActivated(0, 0)), new Bitmap(new fabBtnUpDeactivated(0, 0)),
				false, handlerUp);
			this.addChild(btn_up);
			
			btn_down = newButton(
				new Bitmap(new fabBtnDownActivated(0, 0)), new Bitmap(new fabBtnDownDeactivated(0, 0)),
				false, handlerDown);
			this.addChild(btn_down);
			
			view = new MovieClip();
			this.addChild(view);


			btn_up.x = WIDTH / 2 - btn_up.width / 2;
			btn_up.y = 0;

			btn_down.x = WIDTH / 2 - btn_down.width / 2;
			btn_down.y = HEIGHT - btn_down.height;

			view.x = 0;
			view.y = btn_up.height + 10;
			view_width = WIDTH;
			view_height = HEIGHT - btn_up.height - btn_down.height - 20;
			view_card_cnt = Math.floor(view_height / (card_height + 10));

			this.updateView();
		}
		
		/**
		 * Ativa/Desativa botões, conforme o estado da lista de cartas.
		 */
		private function updateView() {
			btn_up.active = (view_card_cnt < indexes.length) && (cur_index > 0);
			btn_down.active = (view_card_cnt < indexes.length) && (cur_index < indexes.length - 1);
			
			repos();
		}
		
		private function handlerUp(e : Event) {
			cur_index--;
			updateView();
		}

		private function handlerDown(e : Event) {
			cur_index++;
			updateView();
		}
		
		/**
		 * Atualiza a posição das cartas.
		 */
		private function repos() {
			while (view.numChildren > 0)
				view.removeChildAt(0);

			var lim : int = Math.min(view_card_cnt, indexes.length - cur_index);
			var index : int;
			var card : Card;
			for (var i : int = 0; i < lim; i++) {
				index = indexes[i + cur_index];
				card = CardBuilder.build(index);
				card.x = view_width / 2 - card_width / 2;
				card.y = i * (card_height + 10);
				card.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				view.addChild(card);
			}
		}

		private function mouseDownHandler(e : MouseEvent) {
			var index = (e.target as Card).number;
			dispatchEvent(new CardScrollerEvent(CardScrollerEvent.SELECTED, index));
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



		/* Override. */
		public function update(e : Event) {
			/* Dá um update nos botões. */
			btn_up.update(e);
			btn_down.update(e);
		}
	}
}
