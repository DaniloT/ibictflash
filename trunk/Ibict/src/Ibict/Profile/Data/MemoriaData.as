package Ibict.Profile.Data {
	public class MemoriaData {
		
		private var stars : int;
		private var pontuacao : int;
		
		public function MemoriaData() {
			stars = 0;
			pontuacao = 0;
		}
		
		/** Define quantas estrelas o jogador tem. 
		 * 
		 * @param val Pontuacao obtida. */
		public function setStar(val:int){
			
			if (val > pontuacao) {
				pontuacao = val;
				if (pontuacao > 0) {
					if (pontuacao > 12500) {
						if (pontuacao > 21000) {
							if (pontuacao > 25000) {
								if (pontuacao > 34000) {
									if (pontuacao > 35500) {
										stars = 6;
									} else {
										stars = 5;
									}
								} else {
									stars = 4;
								}
							} else {
								stars = 3;
							}
						} else {
							stars = 2;
						}
					} else {
						stars = 1;
					}
				}
			}
		}
		
		/** Retorna quantos pontos o jogador tem.
		 * 
		 * @returns Indica quantos pontos o jogador tem.
		 */
		public function getPont():int{
			return pontuacao;
		}
		
		/*Função obrigatória de todo mini jogo que informa 
		o total de estrelas que o jogador já obteve naquele jogo.
		É necessário para informar ao jogador quantas estrelas 
		cada perfil tem, na tela de load e no mundo.
		*/
		public function getStarCount() : int {
			return stars;
		}

	}
}