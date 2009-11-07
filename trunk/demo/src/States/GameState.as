package States
{
	import Entities.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	public class GameState extends State
	{
		/* Maximum number of trash elements on screen. */
		private static const NUM_ELEMENTS : int = 5;
		
		/* Arrays for holding trashes and bins. */
		private var trashes : Array;
		private var bins : Array;
		
		/* Points counter and text. */
		private var points : int;
		private var txt_points : TextField;
		
		/* Helps controlling this state's loading process. */
		private var started : Boolean;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : MyCursorClass;
		
		public function GameState()
		{
			started = false;
			
			// Scene root node...
			root = new MovieClip();
			
			// Creates points text...
			txt_points = new TextField(); 
			txt_points.y = 450;
			var format : TextFormat = new TextFormat();
			format.size = 90;
			format.color = 0xFFFF00;
			txt_points.defaultTextFormat = format;
			txt_points.selectable = false;
			
			// Creates bins...
			bins = new Array();
			bins[TrashTypesEnum.GLASS] = new GlassBin();
			bins[TrashTypesEnum.METAL] = new MetalBin();
			//bin[TrashTypesEnum.NOT_REC] = new NotRecBin();
			bins[TrashTypesEnum.PAPER] = new PaperBin();
			bins[TrashTypesEnum.PLASTIC] = new PlasticBin();
			for(var i:int = 0; i <= TrashTypesEnum.PAPER /*i < TrashTypesEnum.size*/; i++){
				root.addChild(bins[i]);
			}
			
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor =  new MyCursorClass();
			root.addChild(myCursor);
			GameState.myCursor.visible = false;
		}
		
		public override function assume(previousState : State)
		{
			if (!started) {
				points = 0;
				
				trashes = new Array();
				for (var i : int = 0; i < NUM_ELEMENTS; i++) {
					newTrash(i, true)
				}
				
				started = true;
			}
			
			if (previousState != null){
				Main.stage_g.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.stage_g.addChild(this.root);
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
			var remove, test : Boolean;
			
			for (var i : int = 0; i < trashes.length; i++) {
				remove = trashes[i].toBeRemoved();
				test = false;
				
				// testa se colidiu com alguma lixeira
				for (var j : int = 0; (j < bins.length) && (!test); j++) {
					if ((test = trashes[i].pixelCollidesWith(bins[j]))) {
						if (j == trashes[i].getTargetBin()) {
							points += trashes[i].getRightPoints();
						}
						else {
							points -= trashes[i].getWrongPoints();
						}
					}
				}
				
				if (remove || test) {
					root.removeChild(trashes[i]);
					newTrash(i, false);
				}
				
				trashes[i].update(e);
			}
			
			updatePoints();
		}
		
		private function updatePoints()
		{
			/* Garantees that points are on top of screen... */
			if (root.contains(txt_points))
				root.removeChild(txt_points);
			root.addChild(txt_points);
						
			txt_points.text = points.toString();
			txt_points.x = Main.stage_g.stageWidth / 2 - txt_points.width / 2;
		}
		
		private function newTrash(index : int, randomY : Boolean)
		{
			var trash : Trash = null;
			var type : int = Math.floor(Math.random() * TrashTypesEnum.size);
			switch (type) {
				case TrashTypesEnum.PAPER:
					trash = new Paper(randomY);
					break;
				case TrashTypesEnum.PLASTIC:
					trash = new Plastic(randomY);
					break;
				case TrashTypesEnum.GLASS:
					trash = new Glass(randomY);
					break;
				case TrashTypesEnum.METAL:
					trash = new Metal(randomY);
					break;
				default:
					trash = new NotRec(randomY);
					break;
			}
			
			trashes[index] = trash;
			root.addChild(trashes[index]);
			
			/* linha necessaria para que o cursor do mouse nao fique atras dos lixos */
			root.swapChildren(trashes[index], GameState.myCursor);

		}
	}
}
