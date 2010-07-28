package Ibict.Games.Coleta.Entities
{
	import Ibict.Main;
	import Ibict.Texture;

	public class PaperBin extends Texture
	{
		public function PaperBin()
		{
			this.x = Main.getInstance().stage.stageWidth - this.width;
			this.y = 166;
		}		
	}
}
