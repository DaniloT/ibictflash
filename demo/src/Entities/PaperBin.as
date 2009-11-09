package Entities
{
	import flash.display.Sprite;

	public class PaperBin extends Texture
	{
		public function PaperBin()
		{
			this.x = Main.stage_g.stageWidth - this.width;
			this.y = 300;
		}		
	}
}
