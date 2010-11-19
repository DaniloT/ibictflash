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
		public const MAXNIVEIS : int = 4;
		public var nivelAtual : int = 0;
		
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
			moldura = new errosMoldura();
			moldura.x = 0;
			moldura.y = 0;
			criaCena(nivelAtual);
			
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
			
			erros = new Array();
			acertos = new Array();
			mensagens = new Array();
			
			qtdErros = 0;
			tempoInicial = 0;
			
			tempoInicial = getTimer();
			 switch(config){
			 	//Para cada erro, adiciona o moviclip "errado" e o "certo" e a "mensagem"
				case(0) : 
					cenario = new errosFundo1();
					cenario.x = 34;
					cenario.y = 127;
					cenario.width = 734;
					cenario.height = 422;
					
					graph1 = new erros1TvLigada();
					graph1.x = 517 - cenario.x;
					graph1.y = 201 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros1TvDesligada();
					graph2.x = 517 - cenario.x;
					graph2.y = 201 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Desligue a televisão se ninguém estiver assistindo.");
					qtdErros++;
					
						  
				break;
			    case(1) : 
					cenario = new errosFundo2();
					cenario.x = 43;
					cenario.y = 135;
					cenario.width = 718.5;
					cenario.height = 409.7;
					
					graph1 = new erros2ChuveiroLigado();
					graph1.x = 656 - cenario.x;
					graph1.y = 177 - cenario.y;
					graph1.width = 103.5;
					graph1.height = 342.4;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros2ChuveiroDesligado();
					graph2.x = 656 - cenario.x;
					graph2.y = 177 - cenario.y;
					graph2.width = 103.5;
					graph2.height = 342.4;
					acertos.push(graph2);
					mensagens.push("Não deixe o chuveiro ligado quando ninguém estiver tomando banho.");
					qtdErros++;
			   	
		    	break;
		    	case(2) : 
					cenario = new errosFundo3();
					cenario.x = 43;
					cenario.y = 135;
					
					graph1 = new erros3LuzAcesa();
					graph1.x = 90 - cenario.x;
					graph1.y = 220 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros3LuzApagada();
					graph2.x = 90 - cenario.x;
					graph2.y = 220 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Apague as luzes enquanto for dia.");
					qtdErros++;
					
					graph1 = new erros3ArLigado();
					graph1.x = 470 - cenario.x;
					graph1.y = 145 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros3ArDesligado();
					graph2.x = 470 - cenario.x;
					graph2.y = 145 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Desligue o ar condicionado se as janelas estiverem abertas.");
					qtdErros++;
			   	
		    	break;
		    	case(3) : 
					cenario = new errosFundo4();
					cenario.x = 48;
					cenario.y = 136;
					
					graph1 = new erros4TorneiraAberta();
					graph1.x = 183 - cenario.x;
					graph1.y = 380 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros4TorneiraFechada();
					graph2.x = 183 - cenario.x;
					graph2.y = 380 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Não deixe torneiras abertas sem ninguém usando.");
					qtdErros++;
					
					graph1 = new erros4GeladeiraAberta();
					graph1.x = 404 - cenario.x;
					graph1.y = 259 - cenario.y;
					cenario.addChild(graph1);
					erros.push(graph1);
					graph2 = new erros4GeladeiraFechada();
					graph2.x = 404 - cenario.x;
					graph2.y = 259 - cenario.y;
					acertos.push(graph2);
					mensagens.push("Feche a geladeira quando não estiver usando.");
					qtdErros++;
			   	
		    	break;
			} 
			
		}

	}
}