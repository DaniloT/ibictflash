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
		/** Figura que contera os erros*/
		public var cenario : MovieClip;
		/** Moldura que envolve a figura*/
		public var moldura : MovieClip;
		/** MovieClip onde os botões dos niveis estará*/
		private var telaNiveis : MovieClip;
		
		/** Array que conterá os movieClips com erros*/
		public var erros : Array;
		/** Array que conterá os movieClips com os acertos (para serem trocados qnd o 
		 * jogador clicar e acertar */
		public var acertos : Array;
		/** Array que conterá as mensagens que aparecerão
		 * quando o jogador clicar em um erro. */
		public var mensagens : Array;
		 
		
		/** Indica se esta no jogo ou na escolha do nivel */
		public var emJogo:Boolean = false;
		
		public var qtdErros :int;
		
		/** Array que conterá os botões de seleção de nível */
		public var nivel : Array = new Array();
		public const MAXNIVEIS : int = 2;
		
		/** Armazena a quantidade de pontos do jogador*/
		public var pontos: int;
		
		/** Usadas na contagem de tempo*/
		public var tempoInicial : int;
		public var tempoAtual : int;
		
		/** Quantidade maxima de pontos que o jogador recebe por acerto*/
		public const MAXPTS : int = 200;
		/** Quantidade de pontos que o jogador perde por segundo*/
		public const PTSPERSEC : int = 10;
		/** Cada segundo que o jogador gastar ele perde PTSPERSEC pontos. Após MAXSECS
		segundos, ele não perde mais*/
		public const MAXSECS : int = 10;
		
		
		public function Cena(){
			qtdErros = 0;
			cenario = new MovieClip();
			moldura = new MovieClip();
			escolheNivel();
			//criaCena(1);
			
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
			
			//cenario = new errosFundo0();
			moldura = new errosMoldura();
			moldura.x = 0;
			moldura.y = 0;
			
			erros = new Array();
			acertos = new Array();
			mensagens = new Array();
			
			tempoInicial = getTimer();
			 switch(config){
			 	//Para cada erro, adiciona o moviclip "errado" e o "certo" e a "mensagem"
				case(0) : 
					cenario = new errosFundo1();
					cenario.x = 42.4;
					cenario.y = 132.8;
					cenario.width = 719.9;
					cenario.height = 413.5;
					
					graph1 = new erros1JanelaAberta();
					graph1.x = 175 - cenario.x;
					graph1.y = 147 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros1JanelaFechada();
					graph2.x = 181 - cenario.x;
					graph2.y = 134 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Ficar com a janela aberta e o ar condicionado ligado ao mesmo" + 
							"tempo não é bom.");
					qtdErros++;
					
					graph1 = new erros1LuzAcesa();
					graph1.x = 140 - cenario.x;
					graph1.y = 232 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros1LuzApagada();
					graph2.x = 137 - cenario.x;
					graph2.y = 269 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Não se deve deixar a luz ligada enquanto ainda há muita luz" + 
							"natural");
					qtdErros++;
					
						  
				break;
			    case(1) : 
					cenario = new errosFundo2();
					cenario.x = 41;
					cenario.y = 130;
					cenario.width = 721;
					cenario.height = 417.9;
					
					graph1 = new erros2TorneiraAberta();
					graph1.x = 194 - cenario.x;
					graph1.y = 393 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros2TorneiraFechada();
					graph2.x = 183 - cenario.x;
					graph2.y = 391 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Não deixe a torneira ligada sem necessidade.");
					qtdErros++;
					
					graph1 = new erros2GeladeiraAberta();
					graph1.x = 408 - cenario.x;
					graph1.y = 273 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros2GeladeiraFechada();
					graph2.x = 368 - cenario.x;
					graph2.y = 264 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Não deixa a geladeira aberta desnecessariamente.");
					qtdErros++;
			   	
		    	break;
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