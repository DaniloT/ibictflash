package Ibict.Games.PalavrasCruzadas
{
	import flash.display.MovieClip;
	
	public final class PalavrasCruzadas
	{
		var grid : Grid;
		var palavras : Array;
		var root : MovieClip;
		
		public function PalavrasCruzadas(root : MovieClip)
		{
			this.root = root;
			palavras = new Array("Acido", "Luz", "Camera", "Acao", "Amor", "Paixao", "Vida", "Sonhos", "Paz", "Humanidade", "Risos");
			grid = new Grid(15, 15, palavras, 100, 100, root);
		}
		
		public function update() {
			grid.update();
		}

	}
}