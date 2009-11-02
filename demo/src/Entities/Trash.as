package Entities
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Trash extends Sprite
	{
		protected var velocidade : Number = 0;
		public function Trash(randomY:Boolean)
		{
			this.x = Math.floor((Math.random() * (Main.stage_g.stageWidth-200)) + 100);
			this.y = randomY ? Math.floor(Math.random() * -300) : -50;						
		}

		public function update(e : Event)
		{
			this.y += velocidade;
		}

		public function toBeRemoved():Boolean{
			return(this.y > Main.stage_g.stageHeight);
		}
	}
}
