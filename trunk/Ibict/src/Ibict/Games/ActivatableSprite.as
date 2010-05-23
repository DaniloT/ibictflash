package Ibict.Games
{
	import flash.display.Sprite;

	/**
	 * Uma Sprite que pode ser ativada ou desativada, lançando
	 * os respectivos eventos quando da mudança do estado.
	 * 
	 * @author Luciano Santos
	 */
	public class ActivatableSprite extends Sprite
	{
		private var _active : Boolean;
		
		/**
		 * Cria uma nova ActivatableSprite.
		 */
		public function ActivatableSprite()
		{
			super();
			
			this.active = true;
		}
		
		/**
		 * Define se essa sprite está ativa ou inativa.
		 */
		public function get active() : Boolean {
			return _active;
		}
		
		/**
		 * Ativa ou desativa essa sprite.
		 * 
		 * @param value true, para ativar; falso, caso contrário.
		 */
		public function set active(value : Boolean) {
			if (value != _active) {
				if (value)
					dispatchEvent(new ActivationEvent(this, ActivationEvent.ACTIVATED));
				else
					dispatchEvent(new ActivationEvent(this, ActivationEvent.DEACTIVATED));
			}
			
			this._active = value;
		}
	}
}
