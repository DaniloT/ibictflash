package Ibict.Games.QuebraCabeca
{
	import Ibict.Games.AutodragEvent;
	import Ibict.Music.Music;
	import Ibict.Updatable;
	import Ibict.Util.Matrix;
	import Ibict.Util.Random;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * Controla o modo "Em Jogo" do quebra cabeça.
	 * 
	 * @author Luciano Santos
	 * 
	 * @see QuebraCabecaState
	 */
	public class QuebraCabecaInGame extends Sprite implements Updatable
	{
		public static const BOUNDS : Rectangle = new Rectangle(
			50, 50,
			PieceUtility.BOARD_WIDTH - 50, PieceUtility.BOARD_HEIGHT - 50);
		
		private var pieces : Matrix;
		
		private var board_rect : Rectangle;
		private var board_root : Sprite;
		
		private var pc_base_width : int;
		private var pc_base_height : int;
		private var cols : int;
		private var rows : int;
		
		private var btnSwap : Sprite;
		private var btnSwapPressed : Bitmap;
		private var btnSwapReleased : Bitmap;
		
		private var parabensImagem : MovieClip;
		private var timerFinal : Timer;
		private var completo : Boolean;
		
		private var somOk : Music;


		public function get complete() : Boolean {
			return (completo && (timerFinal.currentCount > 6));
		}
		
		
		/**
		 * Inicia um novo jogo de quebra-cabeça.
		 * 
		 * @param mode o modo de grade.
		 * @param img a imagem a ser utilizada.
		 */
		public function QuebraCabecaInGame(mode : int, src1 : BitmapData, src2 : BitmapData)
		{
			var i, j : int;
			var p : Piece;
			var pos : Point;
			var pc_scalex, pc_scaley : Number;
			
			this.cols = PieceUtility.BOARD_WIDTH / mode;
			this.rows = PieceUtility.BOARD_HEIGHT / mode;
			this.completo = false;
			timerFinal = new Timer(500);

			/* Cria e adiciona o fundo. */
			this.addChild(new Bitmap(new qbcFundoJogo(0,0)));
			
			/* Desenha o "tabuleiro". */
			this.board_rect = new Rectangle((85 + 710) / 2 - 300, (130 + 520) / 2 - 200, 600, 400);
			this.board_root = new Sprite();
			board_root.x = board_rect.x;
			board_root.y = board_rect.y;
			this.addChild(board_root);
			
			/* Botão de troca. */
			btnSwap = new Sprite();
			btnSwapPressed = new Bitmap(new qbcBtnSwapPressed(0, 0));
			btnSwapReleased = new Bitmap(new qbcBtnSwapReleased(0, 0));
			btnSwap.addChild(btnSwapReleased);
			btnSwap.x = 492;
			btnSwap.y = 26;
			btnSwap.addEventListener(MouseEvent.MOUSE_DOWN, swapDown);
			btnSwap.addEventListener(MouseEvent.MOUSE_UP, swapUp);
			this.addChild(btnSwap);
			
			/* Cria as peças do quebra-cabeças. */
			this.pieces = PieceBuilder.build(src1, src2, mode, this);
			
			/* Posiciona as peças. */
			pc_scalex = board_rect.width / PieceUtility.BOARD_WIDTH;
			pc_scaley = board_rect.height / PieceUtility.BOARD_HEIGHT;
			pc_base_width = mode * pc_scalex
			pc_base_height = mode * pc_scaley;
			var lim_rect : Rectangle = new Rectangle(
				board_rect.x, board_rect.y,
				board_rect.width - pc_base_width, board_rect.height - pc_base_height);
			
			for (i = 0; i < pieces.rows; i++) {
				for (j = 0; j < pieces.cols; j++) {
					p = pieces.data[i][j];
					
					pos = Random.randpos(lim_rect)
					
					p.x = pos.x; p.y = pos.y;
					p.scaleX = pc_scalex; p.scaleY = pc_scaley;
					
					p.addEventListener(AutodragEvent.STARTED_DRAG, selectedHandler);
					p.addEventListener(AutodragEvent.STOPPED_DRAG, droppedHandler);
					
					this.addChild(p);
				}
			}


			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			this.addChild(parabensImagem);
			
			somOk = new Music(new qbcSomPiece(), true, -10);
		}
		
		private function swapDown(e : MouseEvent) {
			btnSwap.removeChild(btnSwapReleased);
			btnSwap.addChild(btnSwapPressed);
		}
		
		private function swapUp(e : MouseEvent) {
			btnSwap.removeChild(btnSwapPressed);
			btnSwap.addChild(btnSwapReleased);
			
			for (var i : int = 0; i < pieces.rows; i++) {
				for (var j : int = 0; j < pieces.cols; j++) {
					pieces.data[i][j].swap();
				}
			}
		}
		
		private function selectedHandler(e : AutodragEvent) {}
		
		private function droppedHandler(e : AutodragEvent) {
			if (isPieceCorrect(e.source as Piece)) {
				attach(e.source as Piece);
				somOk.play(0);
			}
		}
		
		public function isPieceCorrect(p : Piece) : Boolean {
			var centerx = board_rect.x + p.gridx * pc_base_width + pc_base_width / 2;
			var centery = board_rect.y + p.gridy * pc_base_height + pc_base_height / 2;
			
			return (Math.abs(p.anchor.x + p.x - centerx) < pc_base_width / 5) &&
				   (Math.abs(p.anchor.y + p.y - centery) < pc_base_height / 5);
		}
		
		public function attach(p : Piece) {
			p.active = false;
			p.x = pc_base_width * p.gridx + pc_base_width / 2 - p.anchor.x + 2;
			p.y = pc_base_height * p.gridy + pc_base_height / 2 - p.anchor.y + 2;
			this.removeChild(p);
			board_root.addChild(p);
		}
		
		/* Override */
		public function update(e : Event)
		{
			if (!completo) {
				completo = (board_root.numChildren >= (pieces.rows * pieces.cols));
				
				if (completo) {
					parabensImagem.play();
					timerFinal.start();
				}
			}
		}
	}
}
