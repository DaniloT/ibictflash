package Ibict.Games.Fabrica
{
	import Ibict.States.GameState;
	import Ibict.Updatable;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class FabricaInGame extends Sprite implements Updatable
	{
		private var completo : Boolean;
		private var timerFinal : Timer;
		private var parabensImagem : MovieClip;

		private var correctImagesRoot : MovieClip;

		private var ciclo : Array;
		private var card_scroll : CardScroller;
		private var cur_card : Sprite;
		private var cur_card_index : int;
		
		private var card_dic : Dictionary;

		
		public function get complete() : Boolean {
			return (completo && (timerFinal.currentCount > 6));
		}
		
		
		public function FabricaInGame(ciclo : Array)
		{
			this.ciclo = ciclo;
			
			this.card_scroll = new CardScroller(60, 60);
			this.addChild(card_scroll);
			this.card_scroll.x = 42;
			this.card_scroll.y = 61;
			this.card_scroll.addEventListener(CardScrollerEvent.SELECTED, cardSelectHandler);


			this.card_dic = new Dictionary();
			var index : int;
			var card : DisplayObject;
			for (var i : int = 0; i < ciclo.length; i++) {
				index = ciclo[i][0];

				if (index > 7) {
					var s : Sprite = new Sprite();
					s.addChild(CardBuilder.build(CardBuilder.BLANK));
					s.addEventListener(MouseEvent.CLICK, dropHandler);
					
					var data : Object = new Object();
					data.index = index;
					data.complete = false;
					data.cover = null;
					card_dic[s] = data;
					card = s;
					this.card_scroll.addCard(index);
				}
				else
					card = CardBuilder.build(index);
				
				card.x = ciclo[i][1];
				card.y = ciclo[i][2];
				addChild(card);
			}
			
			this.correctImagesRoot = new MovieClip();
			addChild(correctImagesRoot);
			
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			this.addChild(parabensImagem);
			
			timerFinal = new Timer(500);
			
			this.completo = false;
			
			cur_card = null;
			cur_card_index = -1;
		}

		private function dropHandler(e : MouseEvent) {
			if (cur_card != null) {
				var target : Sprite = e.target as Sprite;
				
				if (Math.sqrt((cur_card.x - target.x) * (cur_card.x - target.x) + (cur_card.x - target.x) * (cur_card.x - target.x)) < 10) {
					var data : Object = card_dic[target];
					if (data.cover != null)
						correctImagesRoot.removeChild(data.cover);
					
					cur_card.stopDrag();
					
					cur_card.x = target.x;
					cur_card.y = target.y;
					data.cover = cur_card;
					data.complete = (cur_card_index == data.index);
					card_dic[cur_card] = data;
					cur_card.addEventListener(MouseEvent.CLICK, dropHandler);
					
					cur_card = null;
					cur_card_index = -1;
				}
			}
		}
		
		private function cardSelectHandler(e : CardScrollerEvent) {
			if (cur_card != null) {
				cur_card.stopDrag();
				correctImagesRoot.removeChild(cur_card);
			}

			cur_card = new Sprite();
			cur_card_index = e.index;
			cur_card.addChild(CardBuilder.build(cur_card_index));
			correctImagesRoot.addChild(cur_card);
			cur_card.startDrag(true);
		}

		/* Override */
		public function update(e : Event)
		{
			card_scroll.update(e);
			
			if (!completo) {
				completo = true;
				for each (var value:Object in card_dic) {
					completo = completo && value.complete;
				}
				
				if (completo) {
					parabensImagem.play();
					timerFinal.start();
				}
			}
		}
	}
}
