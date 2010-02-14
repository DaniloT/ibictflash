package Ibict.Profile{
	
	/**
	 * Gerencia cada troféu ganhado pelo jogador ao longo do jogo
	 * 
	 * @author Bruno Zumba
	 */
	public class Trophy{
		/* bronze, prata e ouro */
		public var color:int;
		/* Indica qual miniGame o este troféu foi ganho */
		public var miniGame:String;
		
		/**
		 * Cria um novo troféu
		 * 
		 * @param c cor do troféu
		 * @param m miniGame no qual foi ganho
		 */
		public function Trophy(c: int, m:String){
			color = c;
			miniGame = m;
		}

	}
}