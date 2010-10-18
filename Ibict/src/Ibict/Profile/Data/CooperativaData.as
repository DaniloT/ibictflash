package Ibict.Profile.Data {
	public class CooperativaData {
		
		private var stars : Array;
		
		public function CooperativaData() {
			var i : int;
			
			stars = new Array(5);
			
			for (i = 0; i < 5; i++) {
				stars[i] = 0;
			}
			
		}
		
		/** Define se o jogador ganhou ou nao uma estrela. 
		 * 
		 * @param ind Indica qual brinquedo se refere.
		 * @param val 0 se nao completou, 1 se completou. */
		public function setStar(ind:int, val:int){
			stars[ind] = val;
		}
		
		/** Retorna se o jogador já recebeu
		 * a estrela dada por esse jogo em dado brinquedo.
		 * 
		 * @param ind Indice do brinquedo desejado.
		 * @returns Indica se a estrela desse brinquedo já foi pega pelo jogador.
		 */
		public function getStar(ind:int):int{
			return stars[ind];
		}
		
		/*Função obrigatória de todo mini jogo que informa 
		o total de estrelas que o jogador já obteve naquele jogo.
		É necessário para informar ao jogador quantas estrelas 
		cada perfil tem, na tela de load e no mundo.
		*/
		public function getStarCount() : int {
			var i : int;
			var soma : int;
			
			soma = 0;
			for (i = 0; i < 5; i++) {
				if (stars[i]) {
					soma++;
				}
			}
			
			return soma;
		}

	}
}