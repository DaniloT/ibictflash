package Ibict.Games.Fabrica
{
	import flash.events.Event;

	public class CardScrollerEvent extends Event
	{
		public static var SELECTED : String = "cardSelected";

		public var index : int;


		public function CardScrollerEvent(type : String, index : int)
		{
			super(type);

			this.index = index;
		}
	}
}
