package Ibict.Games.Erros
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	/**
	 * Classe que controla o que será apresentado na tela no jogo dos sete erros.
	 * Controla tanto a cena do jogo, quanto a tela de escolher o nivel
	 * 
	 * @author Bruno Zumba
	 */
	public class Cena extends MovieClip{
		/*Figura que contera os erros*/
		public var cenario : MovieClip;
		/*MovieClip onde os botões dos niveis estará*/
		private var telaNiveis : MovieClip;
		
		/*Array que contera os movieClips com erros*/
		public var erros : Array;
		/*Array que contera os movieClips com os acertos (para serem trocados qnd o 
		jogador clicar e acertar*/
		public var acertos : Array;
		
		/* Indica se esta no jogo ou na escolha do nivel */
		public var emJogo:Boolean = false;
		
		public var qtdErros :int;
		
		/* Array que conterá os botões de seleção de nível */
		public var nivel : Array = new Array();
		public const MAXNIVEIS : int = 5;
		
		/*Armazena a quantidade de pontos do jogador*/
		public var pontos: int;
		
		/*Usadas na contagem de tempo*/
		public var tempoInicial : int;
		public var tempoAtual : int;
		
		/*Quantidade maxima de pontos que o jogador recebe por acerto*/
		public const MAXPTS : int = 200;
		/*Quantidade de pontos que o jogador perde por segundo*/
		public const PTSPERSEC : int = 10;
		/*Cada segundo que o jogador gastar ele perde PTSPERSEC pontos. Após MAXSECS
		segundos, ele não perde mais*/
		public const MAXSECS : int = 10;
		
		public function Cena(){
			qtdErros = 0;
			cenario = new MovieClip();
			//escolheNivel();
			criaCena(0);
			
		}

		private function escolheNivel(){
			var i : int;
			var aux : MovieClip;
			var posY : int = 100;
			telaNiveis = new MovieClip();
			
			/* Adiciona os botões de escolha de nivel */
			for(i = 0; i<MAXNIVEIS; i++){
				aux = new seteErrosBt();
				aux.texto.text = "Nivel "+(i+1).toString();
				nivel.push(aux);
				aux.x = 270;
				aux.y = 50+100*i;
				
				telaNiveis.addChild(aux);
			}
			cenario.addChild(telaNiveis);
			
			
		}
		
		/**
		 * Cria uma cena de acordo com a configuração passada
		 * 
		 * @param config A configuração pré-definida desejada (fundo + erros)
		 */
		public function criaCena(config:int){
			var graph1 : Sprite;
			var graph2 : Sprite;
			var i:int;
			
			pontos = 0;			
			emJogo = true;
			
			cenario = new errosFundo0();
			
			erros = new Array();
			acertos = new Array();
			 switch(config){
				case(0) : 
					//cenario = new ErrosFundo0;
					cenario.width = 800;
					cenario.height = 600;
					
					graph1 = new erros0JanelaAberta();
					graph1.x = 175;
					graph1.y = 147;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros0JanelaFechada();
					graph2.x = 181;
					graph2.y = 134;
					acertos.push(graph2);
					qtdErros++;
					
					graph1 = new erros0LuzAcesa();
					graph1.x = 140;
					graph1.y = 232;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros0LuzApagada();
					graph2.x = 137;
					graph2.y = 269;
					acertos.push(graph2);
					qtdErros++;
					
						  
				break;
				/* case(1) : figura = new ErrosFundo;
					break; */
			} 
			/* graph1 = new fundo0JanelaAberta();
			graph1.x = 50;
			graph1.y = 50;
			cenario.addChild(graph1);
			erros.push(graph1);
			graph2 = new lampadaApagada();
			graph2.x = graph1.x + (graph1.width - graph2.width)/2;
			graph2.y = graph1.y;
			acertos.push(graph2);
			qtdErros = 1; */
		}

	}
}