package Ibict.Games.Fabrica
{
	import flash.display.Sprite;

	/**
	 * Modela o "tabuleiro" que contém as cartas da Fábrica.
	 */
	public class CardHolder extends Sprite
	{
		/* Guarda as cartas ainda não acertadas desse tabuleiro. */
		private var cards : Array;


		public function get completo() : Boolean {
			return cards.length == 0;
		}

		public function CardHolder()
		{
			super();
			
			cards = new Array();
		}

		/**
		 * Cria uma nova carta, de acordo com o número de referência, e adiciona ao Holder.
		 */		
		public function addNewCard(number : int, x : int, y : int, locked : Boolean = false) {
			var card : Card = CardBuilder.build(number);

			card.x = x;
			card.y = y;
			this.addChild(card);
			if (!locked) {
				card.hidden = true;
				this.cards.push(card);
			}
		}

		/**
		 * Procura por uma carta neste Holder que tenha o mesmo número de card
		 * e esteja em uma posição próxima. Se encontrar, retorna seu índice neste
		 * Holder, se não, retorna -1.
		 */
		public function matchingCard(card : Card) : int {
			for (var i : int = 0; i < cards.length; i++) {
				if (cards[i].matches(card))
					return i;
			}
			return -1;
		}
		
		/**
		 * Dado um índice válido, bloqueia uma carta, que passa a ficar com o ícone
		 * visível e não entra mais na busca de matchingCard.
		 */
		public function lockCard(index : int) {
			var card : Card = cards[index];
			cards.splice(index, 1);
			card.hidden = false;
		}
	}
}
