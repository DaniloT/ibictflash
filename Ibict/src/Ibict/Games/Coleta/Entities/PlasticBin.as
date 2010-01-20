package Ibict.Games.Coleta.Entities
{
	import Ibict.Main;
	import flash.display.Sprite;
	
	public class PlasticBin extends Texture
	{
		public function PlasticBin()
		{
			this.x = Main.stage_g.stageWidth - this.width ;
			this.y = 80;
		}
	}
}
