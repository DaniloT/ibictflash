package Ibict
{
	/**
	 * Um Interpolator cria valores intermediários entre dois valores-chave.
	 * 
	 * @author Luciano Santos
	 */
	public class Interpolator
	{
		protected var start : Number;
		protected var end : Number;
		protected var steps : uint;
		protected var curStep : uint;
		
		/**
		 * Essa é uma classe abstrata, não a instancie!.
		 */
		public function Interpolator()
		{
		}
		
		/**
		 * Inicia uma nova interpolação.
		 * 
		 * Após uma chamada a begin, a próxima chamada a next iniciará no
		 * passo 0, retornando start.
		 * 
		 * @param start valor inicial.
		 * @param end valor final.
		 * @param steps número de passos. 
		 */
		public function begin(start : Number, end : Number, steps : uint) {
			this.start = start;
			this.end = end;
			this.steps = steps;
			curStep = 0;
		}
		
		/**
		 * Calcula o próximo passo da interpolação e retorna o valor.
		 * 
		 * Se a interpolação tiver terminado, retornará o último passo sempre.
		 * 
		 * @return o valor calculado neste passo.
		 */
		public function next() : Number {
			var k : Number = end;
			
			if (curStep < steps) {
				k = evaluate(curStep / steps);
				curStep++;
			}
			
			return k;
		}
		
		/**
		 * Verifica se a interpolação já terminou.
		 */
		public function hasEnded() : Boolean {
			return curStep >= steps;
		}
		
		/**
		 * Reinicia a interpolação.
		 * 
		 * É o mesmo que chamar begin() com os valores de início, fim e passos já definidos.
		 */
		public function reset() {
			curStep = 0;
		}
		
		/**
		 * Troca os valores de início e de final.
		 */
		public function swap() {
			var aux : Number = start;
			start = end;
			end = aux;
		}
		
		/**
		 * Dada a fração até o fim da interpolação, calcula o valor do passo atual.
		 * 
		 * Deve ser sobrescrita pelas classes filhas.
		 * 
		 * @param u a fração atual (curStep / steps).
		 * 
		 * @return o valor do passo. 
		 */
		protected function evaluate(u : Number) : Number {
			return 0;
		}
	}
}
