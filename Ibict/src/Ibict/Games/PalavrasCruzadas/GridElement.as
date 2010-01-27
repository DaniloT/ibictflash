package Ibict.Games.PalavrasCruzadas
{
	public class GridElement
	{
		var caractere : String;
		var usado : Boolean;
		var palavrastart : Array;
		var palavrafim : Array;
		
		public function GridElement(caractere : String)
		{
			if(caractere != null) {
				this.caractere = caractere;
				this.usado = true;
			} else {
				this.usado = false;
				this.caractere = " ";
				
			}
			
			palavrastart = new Array();
			palavrafim = new Array();
			
		}
		
		public function addInicioPalavra(nro : int) {
			palavrastart[palavrastart.length] = nro;
		}
		
		public function addFimPalavra(nro : int) {
			palavrafim[palavrafim.length] = nro;
		}
		
		
		/* Atribui um caractere aleatorio da tabela ASCII para o elemento
		 * do grid */
		public function randomizeChar() 
		{
			usado = true;
			caractere = String.fromCharCode(Math.floor(Math.random() * 26) + 65);
		}

	}
}