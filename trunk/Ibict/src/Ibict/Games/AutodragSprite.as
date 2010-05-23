package Ibict.Games
{
	import flash.events.MouseEvent;
	
	/**
	 * ActivatableSprite que é arrastada automaticamente, quando ativa.
	 */
	public class AutodragSprite extends ActivatableSprite
	{
		private var is_draggin : Boolean;
		
		
		/**
		 * Cria uma nova AutodragActivatableSprite.
		 */
		public function AutodragSprite()
		{
			super();
			
			this.is_draggin = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		
		private function mouseDown(e : MouseEvent) {			
			if (this.active) {
				is_draggin = true;
				
				this.startDrag();
								
				dispatchEvent(new AutodragEvent(this, AutodragEvent.STARTED_DRAG));
			}
		}
		
		private function mouseUp(e : MouseEvent) {
			if (is_draggin) {
				is_draggin = false;
				
				this.stopDrag();
				
				dispatchEvent(new AutodragEvent(this, AutodragEvent.STOPPED_DRAG));
			}
		}
	}
}
