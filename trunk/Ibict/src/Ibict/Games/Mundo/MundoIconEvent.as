package Ibict.Games.Mundo
{
	import flash.events.Event;

	public class MundoIconEvent extends Event
	{
		private var _icon : MundoIcon;
		
		public function MundoIconEvent(icon : MundoIcon, type : String)
		{
			super(type);
			
			this._icon = icon;
		}
		
		public function get icon() : MundoIcon {
			return this._icon;
		}
	}
}
