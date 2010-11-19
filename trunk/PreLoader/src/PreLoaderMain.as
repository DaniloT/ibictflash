package{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * Controla o pre-Loader do jogo
	 * 
	 * @author Bruno Zumba
	 */
	public class PreLoaderMain extends Sprite{
		private var loader:Loader = new Loader();
		private var carregando : carregandoMVC;
		private var circle : preLoaderCircle; 
		
		public function PreLoaderMain(){
			loader.load(new URLRequest("teste.swf"));
			carregando = new carregandoMVC();
			circle = new preLoaderCircle();
			
			carregando.x = 175;
			carregando.y = 390;
			circle.x = 233;
			circle.y = 98;
			
			addChild(carregando);
			addChild(circle);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function completeHandler(event:Event){
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);

			addChild(loader);
	
			removeChild(carregando);
			removeChild(circle);
		}
		
		private function progressHandler(event:ProgressEvent){
			var relacao:Number = event.bytesLoaded/event.bytesTotal
			var pct:int = Math.round(relacao*100);
			
			//barra.preenchimento.width = relacao*barra.width;
			circle.pct.text = pct.toString();
		}

	}
}