package Ibict.Games.Coleta.Entities
{
	import Ibict.Texture;
	import Ibict.Main;
	
	public class DangerousBin extends Texture
	{
		public function DangerousBin()
		{
			
			this.x = Main.getInstance().stage.stageWidth - this.width;;
			this.y = 0;
		}
		
	}
}