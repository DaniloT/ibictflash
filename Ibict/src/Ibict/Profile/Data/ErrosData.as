package Ibict.Profile.Data {
	public class ErrosData {
		/* como esse jogo só dá uma estrela,
		 * só é necessário uma variável booleana
		 * para guardar quantas estrelas o jogador 
		 * ganhou nesse jogo
		 */
		private var star : Boolean;
		public function ErrosData() {
			star = false;
		}
		
		/** Dá a estrela desse jogo para o jogador. 
		 * 
		 * @param bool Indica se o jogador conseguiu ou não a estrela.*/
		public function setStar(bool:Boolean){
			star = bool;
		}
		
		/** Retorna se o jogador já recebeu
		 * a estrela dada por esse jogo.
		 * 
		 * @returns Indica se a estrele desse jogo já foi pega pelo jogador.
		 */
		public function getStar():Boolean{
			return star;
		}
	}
}