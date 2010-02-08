package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.States.State;
	import Ibict.Updatable;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * Sub-estado da classe GameState que controla o mini-jogo de quebra-cabeça.
	 * 
	 * @author Luciano Santos
	 */
	public class QuebraCabecaState extends State
	{
		private var in_game : QuebraCabecaInGame;
		private var image_sl : ImageSelector;
		private var type_sl : ImageSelector;
		
		private var img2_dic : Dictionary;
		
		 
		private var cur_state : Updatable;
		
		private var mode : int;
		
		/**
		 * Cria novo QuebraCabecaState.
		 */
		public function QuebraCabecaState()
		{
			super();
			
			root = new MovieClip();
			
			img2_dic = new Dictionary();
			
			/* Cria o seletor de imagens principal. */
			image_sl = createMainImgSelector();
			
			/* Cria o seletor de tipos. */
			type_sl = createTypeSelector();
			
			/* Inicia no seletor de tipos de grade. */
			root.addChild(type_sl);
			cur_state = type_sl;
		}
		
		
		
		
		private function createMainImgSelector() : ImageSelector {
			var sel : ImageSelector = new ImageSelector(
				PieceUtility.BOARD_WIDTH, PieceUtility.BOARD_HEIGHT,
				"IMAGENS");
			
			var aux : BitmapData;
			
			aux = new qbcArvore(0, 0);
			sel.addImage(aux, "Árvore", true);
			img2_dic[aux] = new qbcPapel(0, 0);
			
			sel.addImage(new Quebra1(0,0), "Imagem 2", false);
			sel.addImage(new Quebra2(0,0), "Imagem 3", false);
			sel.addImage(new Quebra3(0,0), "Imagem 4", false);
			sel.addImage(new Quebra4(0,0), "Imagem 5", false);
			sel.addImage(new Quebra5(0,0), "Imagem 6", false);
			
			sel.addEventListener(ImageSelector.IMAGE_SELECTED, imageSelectorHandler);
			
			return sel;
		}
		
		private function createTypeSelector() : ImageSelector {
			var sel : ImageSelector = new ImageSelector(
				PieceUtility.BOARD_WIDTH, PieceUtility.BOARD_HEIGHT,
				"TAMANHOS DE GRADE");
			
			sel.addImage(new qbcType4x3(0, 0), "4x3");
			sel.addImage(new qbcType8x6(0, 0), "8x6");
			sel.addImage(new qbcType12x9(0, 0), "12x9");
			sel.addImage(new qbcType20x15(0, 0), "20x15");
			
			sel.addEventListener(ImageSelector.IMAGE_SELECTED, typeSelectorHandler);
			
			return sel;
		}
		
		private function createInGame(mode : int, src1 : BitmapData, src2 : BitmapData) : QuebraCabecaInGame {
			var in_game : QuebraCabecaInGame = new QuebraCabecaInGame(mode, src1, src2);
			
			return in_game;
		}
		
		private function imageSelectorHandler(e : ImageSelectorEvent) {
			root.removeChild(image_sl);
			
			/* Muda para o estado "Em Jogo". */
			in_game = createInGame(mode, e.image.bitmapData, img2_dic[e.image.bitmapData]);
			root.addChild(in_game);
			cur_state = in_game;
		}
		
		private function typeSelectorHandler(e : ImageSelectorEvent) {
			root.removeChild(type_sl);
			
			/* Salva o modo selecionado. */
			switch (type_sl.currentImageIndex) {
				case 0 :
					mode = PieceUtility.PC_4x3;
					break;
				case 1 :
					mode = PieceUtility.PC_8x6;
					break;
				case 2 :
					mode = PieceUtility.PC_12x9;
					break;
				default :
					mode = PieceUtility.PC_20x15;
					break;
			}
			
			/* Muda para o seletor de imagens. */
			image_sl.currentImageIndex = 0;
			root.addChild(image_sl);
			cur_state = image_sl;
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
			cur_state.update(e);
		}
	}
}
