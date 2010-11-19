package Ibict.Games.Fabrica
{
	import Ibict.InputManager;
	import Ibict.Music.Music;
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;

	/**
	 * Modela o modo de jogo da fábrica.
	 */
	public class FabricaInGame extends Sprite implements Updatable
	{
		private var _won : Boolean;
		private var voltar : Boolean;
		private var timerFinal : Timer;
		private var parabensImagem : MovieClip;

		private var ciclo : Array;
		private var card_scroll : CardScroller;
		private var card_holder : CardHolder;
		private var cur_card : Card;

		private var somOk : Music;

		private var botaoVoltar : MovieClip;
		
		private var inputManager : InputManager;

		public var ciclo_ref : int;


		public function get won() : Boolean {
			return _won;
		}

		public function get done() : Boolean {
			return ((won && (timerFinal.currentCount > 6)) || voltar);
		}


		public function FabricaInGame(ciclo_ref : int, ciclo : Array, prob : Number)
		{
			this.ciclo_ref = ciclo_ref;

			inputManager = InputManager.getInstance();

			voltar = false;
			
			this.ciclo = ciclo;
		
			this.addChild(new Bitmap(new fabFundo(0,0)));
			
			this.card_holder = new CardHolder();
			this.addChild(card_holder);

			this.card_scroll = new CardScroller(60, 60);
			this.addChild(card_scroll);
			this.card_scroll.x = 42;
			this.card_scroll.y = 61;
			this.card_scroll.addEventListener(CardScrollerEvent.SELECTED, cardSelectHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)

			this.cur_card = null;

			var i, j : int;
			var index : int;
			var card : DisplayObject;
			var non_arrow : Array = new Array();
			
			/* Primeiro, separa entre setas e não-setas. */
			for (i = 0; i < ciclo.length; i++) {
				index = ciclo[i][0];
				if (index <= 7)
					card_holder.addNewCard(index, ciclo[i][1], ciclo[i][2], true);
				else
					non_arrow.push(i);
			}

			/* Agora, escolhe aleatoriamente as cartas preenchidas. */
			var filled : int = Math.round(prob * (non_arrow.length - 1));
			for (i = 0; i < filled; i++) {
				j = Math.round(Math.random() * (non_arrow.length - 1));
				index = ciclo[non_arrow[j]][0];
				card_holder.addNewCard(
						index,
						ciclo[non_arrow[j]][1], ciclo[non_arrow[j]][2],
						true);
				non_arrow.splice(j, 1);
			}
			
			/* E coloca o restante no scroller. */
			while (non_arrow.length > 0) {
				i = non_arrow.pop();
				index = ciclo[i][0];
				card_holder.addNewCard(index, ciclo[i][1], ciclo[i][2], false);
				card_scroll.addCard(index);
			}

			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			this.addChild(parabensImagem);
			
			timerFinal = new Timer(500);
			
			this._won = false;
			
			botaoVoltar = new MiniBotaoVoltar();
			botaoVoltar.x = 700;
			botaoVoltar.y = 470;
			this.addChild(botaoVoltar);
			
			somOk = new Music(new fabSomCard(), true, -10);
		}


		private function cardSelectHandler(e : CardScrollerEvent) {
			card_scroll.removeCard(e.index);
			
			cur_card = CardBuilder.build(e.index);
			cur_card.x = inputManager.getMousePoint().x - cur_card.width / 2;
			cur_card.y = inputManager.getMousePoint().y - cur_card.height / 2;
			this.addChild(cur_card);
			cur_card.startDrag();
		}

		private function mouseUpHandler(e : MouseEvent) {
			if (cur_card != null) {
				cur_card.stopDrag();
				this.removeChild(cur_card);

				var i : int = card_holder.matchingCard(cur_card);
				if (i >= 0) {
					somOk.play(0);
					card_holder.lockCard(i);
				}
				else
					card_scroll.addCard(cur_card.number);

				cur_card = null;
			}
		}

		/* Override */
		public function update(e : Event)
		{
			card_scroll.update(e);
			
			if (!_won) {
				_won = card_holder.completo;
				
				if (_won) {
					parabensImagem.play();
					timerFinal.start();
				}
			}
			
			if(inputManager.mouseClick() && (inputManager.getMouseTarget() ==  botaoVoltar)) {
				voltar = true;
			}
		}
	}
}
