package Ibict.Games.QuebraCabeca
{
	import Ibict.Games.AutodragEvent;
	import Ibict.InputManager;
	import Ibict.Music.Music;
	import Ibict.Updatable;
	import Ibict.Util.Matrix;
	import Ibict.Util.Random;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
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
		
		private var img1 : Sprite;
		private var img2 : Sprite;
		private var cur_img : DisplayObject;

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
		
		private var lamp : MovieClip;
		private var show_img : Boolean;

		private var parabensImagem : MovieClip;
		private var timerFinal : Timer;
		private var _won : Boolean;
		private var voltar : Boolean;
		
		private var somOk : Music;
		
		private var botaoVoltar : MovieClip;
		
		private var input : InputManager;


		public function get won() : Boolean {
			return _won;
		}

		public function get done() : Boolean {
			return ((won && (timerFinal.currentCount > 6)) || voltar);
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
			
			input = InputManager.getInstance();
			
			voltar = false;
			
			this.cols = PieceUtility.BOARD_WIDTH / mode;
			this.rows = PieceUtility.BOARD_HEIGHT / mode;
			this._won = false;
			timerFinal = new Timer(500);

			this.img1 = createBorderedBmp(src1, 610, 460, 15, 0x000000);
			this.img2 = createBorderedBmp(src2, 610, 460, 15, 0x000000);
			this.cur_img = img1;
			

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
			btnSwap.x = 485;
			btnSwap.y = 26;
			btnSwap.addEventListener(MouseEvent.MOUSE_DOWN, swapDown);
			btnSwap.addEventListener(MouseEvent.MOUSE_UP, swapUp);
			this.addChild(btnSwap);

			/* Lâmpada. */
			lamp = new qbcLamp();
			lamp.x = 660;
			lamp.y = 20;
			lamp.addEventListener(MouseEvent.CLICK, lampHandler);
			lamp.stop();
			this.addChild(lamp);

			/* Botão para voltar. */
			botaoVoltar = new MiniBotaoVoltar();
			botaoVoltar.x = 700;
			botaoVoltar.y = 470;
			this.addChild(botaoVoltar);

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

			/* Mostra a imagem no jogo. */
			show_img = false;

			/* Animação de "Parabéns" */
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			this.addChild(parabensImagem);
			
			somOk = new Music(new qbcSomPiece(), true, -10);
		}
		
		private function createBorderedBmp(
				data : BitmapData,
				width : Number, height : Number, arc : Number,
				color : uint) : Sprite {

			var img : Sprite = new Sprite();
			var bmp : Bitmap = new Bitmap(data);
			img.graphics.beginFill(color);
			img.graphics.drawRoundRect(0, 0, width, height, arc);
			img.graphics.endFill();
			bmp.x = img.width / 2 - bmp.width / 2;
			bmp.y = img.height / 2 - bmp.height / 2;
			img.addChild(bmp);
			
			return img;
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

			if (show_img)
				hideImage();

			if (cur_img == img1)
				cur_img = img2;
			else
				cur_img = img1;

			if (show_img)
				showImage();
		}

		private function lampHandler(e : MouseEvent) {
			if (!show_img) {
				lamp.play();
				
				show_img = true;
				showImage();
			}
			else
				shownImgHandler(null);
		}
		
		private function showImage() {
			this.addChild(cur_img);
			//cur_img.x = ((this.width / 2) - (cur_img.width / 2));
			//cur_img.y = ((this.height / 2) - (cur_img.height / 2));
			cur_img.x = 95;
			cur_img.y = 120;
			cur_img.addEventListener(MouseEvent.CLICK, shownImgHandler);
		}

		private function hideImage() {
			this.removeChild(cur_img);
			cur_img.removeEventListener(MouseEvent.CLICK, shownImgHandler);
		}

		private function shownImgHandler(e : MouseEvent) {
			hideImage();
			show_img = false;
			lamp.play();
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
			if (!_won) {
				_won = (board_root.numChildren >= (pieces.rows * pieces.cols));
				
				if (_won) {
					parabensImagem.play();
					timerFinal.start();
				}
			}

			if(input.mouseClick() && (input.getMouseTarget() ==  botaoVoltar)) {
				voltar = true;
			}
		}
	}
}
