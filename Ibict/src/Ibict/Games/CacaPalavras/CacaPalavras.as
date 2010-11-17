package Ibict.Games.CacaPalavras
{
	import Ibict.InputManager;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public final class CacaPalavras 
	{
		var grid : Grid;
		var painelResultados : PainelResultados;
		var palavras : Array;
		var dicas : Array;
		var root : MovieClip; 
		var lineDraw : MovieClip;
		var lineDrawed : MovieClip;
		var angle : Number;
		
		
		var cacaPalavrasFundo : MovieClip;
		var acabouTempoImagem : MovieClip;
		var parabensImagem : MovieClip;
		
		var inputManager : InputManager;
		
		var mouseLineStart : Point;
		var mouseLineFinish : Point;
		
		var pontuacao : CacaPalavrasPontuacao;
		
		var timer : Timer;
		var timerFinal : Timer;
		
		var blurFilters : BlurFilter;
		
		var blur : int;
		
		var completo : Boolean;
		
		var music : Sound;
		
		var bancoPalavras : BancoPalavras;
		
		var dificuldade : int;
		
		var saiu : Boolean;
		
		var botaoVoltar : MovieClip;
		
		var alphaPainel : Number;
		
		var botaoPowerUp01 : MovieClip;
		var botaoPowerUp02 : MovieClip;
		var botaoPowerUp03 : MovieClip;

		
		var powerUp01usado : Boolean;
		var powerUp02usado : Boolean;
		var powerUp03usado : Boolean;
		
		var comecou : Boolean;
		var tutorial : MovieClip;
		

		
		private var somOk : Music;
		private var somWrong : Music;
		
		private function retiraLinhas(string : String) : String {
			var i : int;
			var espaco : String = " ";
			
			for(i = 0; i < string.length; i++) {
				if(string.charAt(i) == "\n") {
					string = string.slice(0, i).concat(espaco.concat(string.slice(i+1, string.length)));	
				}
			}
			
			return string;
		}
		
		public function adicionaLinhasDicas(jump : int) {
			var i, j, k : int;
			var string : String;
			var troca : Boolean;
			var linha : String = "\n";
			
			troca = false;
			
			for(i = 0; i < dicas.length; i++) {
				string = retiraLinhas(dicas[i]);
				
				j = jump;
				while(j < string.length) {
					troca = false;
					
					k = j;
					do {
						if(string.charAt(k) == " ") {
							troca = true;
							string = string.slice(0, k).concat(linha.concat(string.slice(k+1, string.length)));
						}
						k--;
					} while(k > 0 && !troca);
					j = k + jump;
				}
				
				dicas[i] = string;
			}
		}
		
		
		public function CacaPalavras(root : MovieClip, dificuldade : int)
		{
			this.root = root;
			this.dificuldade = dificuldade;
			
			//music = new Sound(new URLRequest("music/caca_palavras.mp3"));
			//music.play(0,100,null);
			
			saiu = false;
				
			cacaPalavrasFundo = new FundoCacaProvisorio();
			
			bancoPalavras = new BancoPalavras();
			
			pontuacao = new CacaPalavrasPontuacao(585, 560);
			
			blurFilters = new BlurFilter(0, 0, 1);
			blur = 0;
			
			
			this.root.addChild(cacaPalavrasFundo);
			
			this.root.addChild(pontuacao);
			
			timer = new Timer(500);
			timer.start();
			
			timerFinal = new Timer(500);
			
			/*
			palavras = new Array("Reciclagem", 
			 "Esforço",
			  "Meioambiente",
			   "Limpas",
			    "Isopor",
			     "Reduzir",
			      "Repensar",
			       "Transporte",
			        "Economica",
			         "Desperdicio");
			dicas = new Array( "Processo de reutilização\ndo lixo.",
			  "Para mudar o problema, pre-\ncisamos de e_____.",
			   "O meio que devemos cuidar.",
			    "Nossas águas precisam estar l______.",
			     "O i____ é um material\ndifícil de reciclar.", 
			     "Devemos ____ energia e ma-\nterial de consumo.",
			      "É importante r_____ o pro-\nduto e suas funções.",
			       "O tr____ de materiais\ndeve ser otimizado.",
			        "A preservação também é\numa questão ec______.",
			         "Devemos evitar o ____\nde água nas torneiras.");
			         
			*/
			
			switch(dificuldade) {
				case 0:
					bancoPalavras.selectWords(6, 0, 0);
				break;
				case 1:
					bancoPalavras.selectWords(5, 1, 0);
				break;
				case 2:
					bancoPalavras.selectWords(3, 2, 1);
				break;
				case 3:
					bancoPalavras.selectWords(1, 3, 2);
				break;
				case 4:
					bancoPalavras.selectWords(0, 0, 6);
				break;
					
			}
			//bancoPalavras.selectWords(8, 1, 1);
			palavras = bancoPalavras.getWords();
			dicas = bancoPalavras.getHints();
			
			adicionaLinhasDicas(30);

			         
			         
			var repete : Boolean;
			repete = false;
			
			do {
				try {
					grid = new Grid(10, 10, palavras, dicas, 230, 130, 14, 50,  blurFilters, false);
					painelResultados = new PainelResultados(dicas, palavras);
				} catch(errObject:Error) {
					trace("Erro no grid!" + errObject.message);
					trace("tentando novamente..");
					repete = true;
				}
			} while(repete);
			
			
			this.root.addChild(grid);
			
			
			inputManager = InputManager.getInstance();
			
			lineDraw = new MovieClip();
			lineDrawed = new MovieClip();
			
			mouseLineStart = new Point(0,0);
			mouseLineFinish = new Point(0,0);
			
			
			this.root.addChild(lineDraw);
			this.root.addChild(lineDrawed);
			
			
			
			lineDrawed.graphics.lineStyle(3,0xFFFFFF);
			
			acabouTempoImagem = new cpAcabouTempo();
			acabouTempoImagem.x = 270;
			acabouTempoImagem.y = 240;
			acabouTempoImagem.stop();
			this.root.addChild(acabouTempoImagem);
			
			parabensImagem = new cpParabensImg();
			parabensImagem.x = 270;
			parabensImagem.y = 240;
			parabensImagem.stop();
			this.root.addChild(parabensImagem);	
			
			alphaPainel = 0;
			painelResultados.alpha = alphaPainel;
			this.root.addChild(painelResultados); 
			
			botaoVoltar = new MiniBotaoVoltar();
			botaoVoltar.x = 700;
			botaoVoltar.y = 500;
			this.root.addChild(botaoVoltar);
			
			
				
			/* carregando os sons */
			somOk = new Music(new ColetaSomOk(), true, -10);
			somWrong = new Music(new ColetaSomWrong(), true, -10);
			
			
			botaoPowerUp01 = new CacaPowerUp01();
			botaoPowerUp02 = new CacaPowerUp02();
			botaoPowerUp03 = new CacaPowerUp03();
			
			
			botaoPowerUp01.x = 334;
			botaoPowerUp01.y = 533;
			
			botaoPowerUp02.x = 391;
			botaoPowerUp02.y = 533;
			
			botaoPowerUp03.x = 448;
			botaoPowerUp03.y = 533;
			
			this.root.addChild(botaoPowerUp01);
			this.root.addChild(botaoPowerUp02);
			this.root.addChild(botaoPowerUp03);
			
			powerUp01usado = false;
			powerUp02usado = false;
			powerUp03usado = false;
			
			comecou = false;
			tutorial = new FundoTutorialCacaPalavras();
			this.root.addChild(tutorial);
			
		}
		
		public function update() {
			var deslAngularX, deslAngularY : int;
			var variacaoMouse : Number;
			var espacamento;
			var mouseWasClicked : Boolean;
			espacamento = 28;
			
			grid.update();
			

			
			mouseWasClicked = false;
			/* verificando input do mouse */
			if(inputManager.mouseClick() && !saiu) {
				mouseWasClicked = true;
				mouseLineStart = inputManager.getMousePoint().clone();
			}
			
			lineDraw.graphics.clear();
			lineDraw.graphics.lineStyle(3,0xFFFFFF);

			
			
			mouseLineFinish = inputManager.getMousePoint().clone();
			variacaoMouse = ( mouseLineFinish.y - mouseLineStart.y)/(mouseLineFinish.x - mouseLineStart.x);
			angle = Math.atan(variacaoMouse);
			angle = angle + Math.PI/2;

			
			
			/* calculando os deslocamentos angulares */
			if((mouseLineFinish.x - mouseLineStart.x) >= 0) {
				deslAngularX = -espacamento*Math.cos(angle);
				deslAngularY = -espacamento*Math.sin(angle);
			} else {
				deslAngularX = +espacamento*Math.cos(angle);
				deslAngularY = +espacamento*Math.sin(angle);
			}
			
			if(inputManager.isMouseDown()) {
				
				
				if(!isNaN(angle)) {
					lineDraw.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 , mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2);
					lineDraw.graphics.lineTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 + deslAngularY);
					lineDraw.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 );
					lineDraw.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2  , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
					lineDraw.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2  + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2  + deslAngularY);
					lineDraw.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 + deslAngularX , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 +  deslAngularY);
					lineDraw.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
				}
				
	
			}
			
			if(inputManager.mouseUnclick() && !saiu) {
				var resultado : int;
				if((resultado = grid.comparaPontos(mouseLineStart, mouseLineFinish)) != -1) {
					var pontos;
					if(timer.currentCount < 100) {
						pontos = 200 - timer.currentCount;
						
					} else if(timer.currentCount < 150) {
						pontos = 200 - timer.currentCount/2;
					} else if(timer.currentCount < 190){
						pontos = 200 - timer.currentCount/4;
					} else {
						pontos = 10;
					}
					pontuacao.addPoints(pontos);
					
					grid.atualizaQuantasPalavrasFaltam();
					
					somOk.play(0);
					
					grid.pintaElementoBarra(resultado);
					trace("result");
					trace(resultado);
					mouseLineFinish = inputManager.getMousePoint().clone();
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 , mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2);
					lineDrawed.graphics.lineTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 + deslAngularY);
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 );
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2  , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2  + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2  + deslAngularY);
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 + deslAngularX , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 +  deslAngularY);
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
					
					
					/* verifica se esta completo */
					completo = grid.verificaCompleto();
					if(completo) {
						timerFinal.start();
						parabensImagem.play();
					}
				} else {
					if(mouseWasClicked)
						somWrong.play(0);
				}
			}
			
			if(timerFinal.currentCount > 5) {
				if(completo) {
					GameState.profile.cacaPalavrasData.setPontuacao(dificuldade, pontuacao.pontuacao);
					GameState.setState(GameState.ST_SELECAO_CACA);	
				} else {
					GameState.setState(GameState.ST_SELECAO_CACA);
				}
			}
			

			/*
			if(timer.currentCount == 350) { 
				timerFinal.start();
				acabouTempoImagem.play();
				cacaPalavrasFundo.filters = [blurFilters];
				grid.filters = [blurFilters];
				blur = 1;
				blurFilters.blurX = blur;
				blurFilters.blurY = blur;
				
				
			}
			*/
			
			

			
			if(inputManager.getMousePoint().x > 700 &&
				inputManager.getMousePoint().y > 470 &&
				inputManager.mouseClick() && alphaPainel < 1 && !completo) {
				
				// alteracao: vai sair logo
				GameState.setState(GameState.ST_MUNDO);
				saiu = true;
			}
			
			if(saiu) {
				alphaPainel += 0.05;
				if(alphaPainel > 1) alphaPainel = 1;
			}
			
			if(alphaPainel == 1 && inputManager.getMousePoint().x > 700 &&
				inputManager.getMousePoint().y > 470 &&
				inputManager.mouseClick()) {
					GameState.setState(GameState.ST_MUNDO);
				}
			
			painelResultados.alpha = alphaPainel;
			
			if(completo) {
				if(blur < 12) {
					blur++;
					blurFilters.blurX = blur;
					blurFilters.blurY = blur;
				}
				cacaPalavrasFundo.filters = [blurFilters];
				grid.filters = [blurFilters];
			}
			
			if(inputManager.mouseClick() && 
				inputManager.getMouseTarget() == botaoPowerUp03 && !powerUp03usado) {
				powerUp03usado = true;
				botaoPowerUp03.gotoAndStop(2);
				grid.setIniciaisBrilhantes();
				pontuacao.addPoints(-200);
			}
			
			if(inputManager.mouseClick() && 
				inputManager.getMouseTarget() == botaoPowerUp02 && !powerUp02usado) {
				powerUp02usado = true;
				botaoPowerUp02.gotoAndStop(2);
				grid.setTodasPiscando();
				pontuacao.addPoints(-100);
			}
			
			if(inputManager.mouseClick() && 
				inputManager.getMouseTarget() == botaoPowerUp01 && !powerUp01usado) {
					
				powerUp01usado = true;
				botaoPowerUp01.gotoAndStop(2);
				grid.setPalavraBrilhando();
				
				pontuacao.addPoints(-100);
				
			}
			
			if(!comecou && inputManager.mouseClick()) {
				tutorial.x = 2000;
				comecou = true;
			}
			
			
	
			
			
			
		}

	}
}