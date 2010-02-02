package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.States.State;
	import Ibict.Util.Matrix;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Sub-estado da classe GameState que controla o mini-jogo de quebra-cabeça.
	 * 
	 * @author Luciano Santos
	 */
	public class QuebraCabecaState extends State
	{
		/* Define se está em jogo ou selecionando imagens. */
		private var in_game : Boolean;
		
		private var pieces : Matrix;
		private var image_sl : ImageSelector;
		private var type_sl : ImageSelector;
		
		/**
		 * Cria novo QuebraCabecaState.
		 */
		public function QuebraCabecaState()
		{
			super();
			
			root = new MovieClip();
			
			/* Cria o seletor de imagens principal. */
			image_sl = createMainImgSelector();
			
			/* Cria o seletor de tipos. */
			type_sl = createTypeSelector();
			
			var mode : int = PieceUtility.PC_20x15;
			var m : Matrix = PieceBuilder.build(new qbcBlank(0, 0), mode);
			for (var i : int = 0; i < m.rows; i++) {
				for (var j : int = 0; j < m.cols; j++) {
					var p : Piece = m.data[i][j];
					p.x = mode * j + mode / 2 - p.anchor.x + 10;
					p.y = mode * i + mode / 2 - p.anchor.y + 10;
					root.addChild(p);
				}
			}
		}
		
		
		
		private function createMainImgSelector() : ImageSelector {
			var sel : ImageSelector = new ImageSelector(
				PieceUtility.BOARD_WIDTH, PieceUtility.BOARD_HEIGHT,
				"IMAGENS");
				
			sel.addImage(new Quebra0(0,0), "Imagem 1");
			sel.addImage(new Quebra1(0,0), "Imagem 2");
			sel.addImage(new Quebra2(0,0), "Imagem 3");
			sel.addImage(new Quebra3(0,0), "Imagem 4");
			sel.addImage(new Quebra4(0,0), "Imagem 5");
			sel.addImage(new Quebra5(0,0), "Imagem 6");
			
			return sel;
		}
		
		private function createTypeSelector() : ImageSelector {
			var sel : ImageSelector = new ImageSelector(
				PieceUtility.BOARD_WIDTH, PieceUtility.BOARD_HEIGHT,
				"TAMANHOS DE GRADE");
			
			return sel;
		}
		
		
		/* Override. */
		public override function assume(previousState : State)
		{
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			Main.getInstance().stage.addChild(root);
		}
		
		/* Override. */
		public override function leave()
		{	
		}
		
		/* Override. */
		public override function enterFrame(e : Event)
		{
			image_sl.update(e);
		}
	}
}
