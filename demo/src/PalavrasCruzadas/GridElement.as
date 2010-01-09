package PalavrasCruzadas
{
	public class GridElement
	{
		var caractere : String;
		var usado : Boolean;
		
		public function GridElement(caractere : String)
		{
			if(caractere != null) {
				this.caractere = caractere;
				usado = true;
			} else {
				usado = false;
				caractere = "";
				
			}
			
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