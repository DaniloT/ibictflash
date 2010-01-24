package Ibict.Games.QuebraCabeca
{
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;
	
	public class PieceBuilder
	{
		public function PieceBuilder()
		{
			var bmp : BitmapData = getEar(150, "Ear150");
			
			var text : String = "";
			for (var j : int = 0; j < bmp.height; j++) {
				for (var i : int = 0; i < bmp.width; i++) {
					if (bmp.getPixel(i, j) == 0)
						text += "#";
					else
						text += "_";
				}
				text += "\n";
			}
			trace (text);
		}
		
		private static function getEar(size : int, class_name : String) : BitmapData {
			var Ear : Class = getDefinitionByName(class_name) as Class;
            return new Ear(size, size);
		}
	}
}
