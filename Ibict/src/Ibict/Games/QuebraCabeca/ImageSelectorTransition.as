package Ibict.Games.QuebraCabeca
{
	import flash.display.Shape;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	import fl.transitions.easing.Bounce;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.Strong;
	
	public class ImageSelectorTransition
	{
		public static const RIGHT = 0;
		public static const LEFT = 1;
		
		private static const DX = 30;
		
		private var leav_img : ImageSelectorBitmap;
		private var ent_img : ImageSelectorBitmap;
		
		private var ent_tween : Tween;
		private var leav_tween : Tween;
		
		/**
		 * Cria e inicia uma nova transição.
		 */
		public function ImageSelectorTransition (
				leaving_img : ImageSelectorBitmap,
				entering_img : ImageSelectorBitmap,
				direction : int,
				frm_count : int,
				handler : Function) {
					
			this.leav_img = leaving_img;
			this.ent_img = entering_img;
			
			/* Cria máscara das imagens. */
			leav_img.mask = createMask(leav_img);
			ent_img.mask = createMask(ent_img);
			
			/* Função de interpolação. */
			var func : Function = Regular.easeOut;
			
			if (direction == RIGHT) {
				/* Imagem que sai... */
				ent_tween = new Tween(leav_img, "x", func, leav_img.x, leav_img.x + leav_img.width + DX, frm_count);
				ent_tween.addEventListener(TweenEvent.MOTION_FINISH, handler);
				ent_tween.start();
				
				/* Imagem que entra... */
				leav_tween = new Tween(ent_img, "x", func, leav_img.x - DX - ent_img.width, leav_img.x, frm_count);
				leav_tween.start();
			}
			else {
				/* Imagem que sai... */
				ent_tween = new Tween(leav_img, "x", func, leav_img.x, leav_img.x - leav_img.width - DX, frm_count);
				ent_tween.addEventListener(TweenEvent.MOTION_FINISH, handler);
				ent_tween.start();
				
				/* Imagem que entra... */
				leav_tween = new Tween(ent_img, "x", func, leav_img.x + DX + ent_img.width, leav_img.x, frm_count);
				leav_tween.start();
			}
		}
		
		
		private static function createMask(img : ImageSelectorBitmap) {
			var mask : Shape = new Shape();
			
			mask.graphics.beginFill(0);
			mask.graphics.drawRect(0, 0, img.width, img.height);
			mask.graphics.endFill();
			
			mask.x = img.x;
			mask.y = img.y;
			
			return mask;
		}
	}
}
