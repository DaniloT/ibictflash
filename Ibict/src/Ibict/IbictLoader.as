package Ibict
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class IbictLoader
	{
		private static var done : Boolean;
		private static var error : Boolean;
		
		public static function load(url : String) : DisplayObject
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadDone);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error);
			
			done = false;
			error = false
			
			try {
				loader.load(new URLRequest(url));
			}
			catch (SecurityError e) {
				return null;
			}
			
			while (!done);
			if (error) return null;
			
			return loader.content;
		}
		
		private static function loadDone(e : Event) {
			done = true;
		}
		
		private static function error(e : IOErrorEvent) {
			done = true;
			error = true;
		}
	}
}
