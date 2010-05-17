package Ibict.Games.Mundo
{
	import flash.events.Event;

	/**
	 * Evento lançado por MundoIcon quando o usuário seleciona um ícone do mundo.
	 * 
	 * @author Luciano Santos
	 */
	public class MundoIconEvent extends Event
	{
		private var _icon : MundoIcon;
		
		/**
		 * Cria novo MundoIconEvent.
		 * 
		 * @param icon O ícone que gerou o evento.
		 * @param type O tipo de evento (como em Event).
		 */
		public function MundoIconEvent(icon : MundoIcon, type : String)
		{
			super(type);
			
			this._icon = icon;
		}
		
		/**
		 * O ícone deste evento.
		 */
		public function get icon() : MundoIcon {
			return this._icon;
		}
	}
}
