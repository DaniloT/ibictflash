package Ibict.Games.QuebraCabeca
{
	import Ibict.Main;
	import Ibict.States.State;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Sub-estado da classe GameState que controla o mini-jogo de quebra-cabeça.
	 * 
	 * @author Luciano Santos
	 */
	public class QuebraCabecaState extends State
	{
		/**
		 * Cria novo QuebraCabecaState.
		 */
		public function QuebraCabecaState()
		{
			super();
			
			root = new MovieClip();
			
			var bmp : BitmapData = new Quebra0(0, 0);
			var matrix : Matrix = PieceBuilder.build(bmp, PieceUtility.PC_8x6);
			
			for (var i : int = 0; i < matrix.rows; i++) {
				for (var j : int = 0; j < matrix.cols; j++) {
					var p : Piece = matrix.data[i][j];
					p.x = j * 60 + 50;
					p.x += (60 - p.width) / 2;
					
					p.y = i * 60 + 50;
					p.y += (60 - p.height) / 2;
					
					p.scaleX = 0.5;
					p.scaleY = 0.5
					
					root.addChild(p);
				}
			}
		}
		
		public override function assume(previousState : State)
		{
			if (previousState != null){
				Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
			}
			Main.getInstance().stage.addChild(root);
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
		}
	}
}
