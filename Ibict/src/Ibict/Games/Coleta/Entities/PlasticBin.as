package Ibict.Games.Coleta.Entities
{
	import Ibict.Main;
	import Ibict.Texture;
	
	public class PlasticBin extends Texture
	{
		public function PlasticBin()
		{
			this.x = Main.getInstance().stage.stageWidth - this.width ;
			this.y = 80;
		}
	}
}
