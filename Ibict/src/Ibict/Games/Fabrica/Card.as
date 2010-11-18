package Ibict.Games.Fabrica
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * Modela uma carta do jogo da Fábrica.
	 */
	public class Card extends Sprite
	{
		private var _number : int;
		private var icon : DisplayObject;
		private var hidden_icon : DisplayObject;

		private var _hidden : Boolean;


		public function get number() : int {
			return _number;
		}

		/**
		 * Se a carta estiver escondida, mostra um ícone padrão, caso contrário,
		 * mostra o ícone definido.
		 */
		public function get hidden() : Boolean {
			return _hidden;
		}

		public function set hidden(value : Boolean) {
			if (value != _hidden) {
				_hidden = value;
				if (_hidden) {
					this.removeChild(icon);
					this.addChild(hidden_icon);
				}
				else {
					this.removeChild(hidden_icon);
					this.addChild(icon);
				}
			}
		}


		/**
		 * Cria uma nova carta com código e ícone dados.
		 */
		public function Card(number : int, icon : DisplayObject)
		{
			this._number = number;
			this.icon = icon;
			this.hidden_icon = CardBuilder.getIcon(CardBuilder.BLANK);
			this._hidden = false;
			this.addChild(icon);
		}
		
		/**
		 * Verifica se uma dada carta está em uma posição próxima a esta carta
		 * e possui o mesmo código.
		 */
		public function matches(card : Card) {
			if (card._number == this._number) {
				var dx = card.x - this.x;
				var dy = card.y - this.y;
				return (Math.sqrt(dx * dx + dy * dy) < 20);
			}
			return false;
		}
	}
}
