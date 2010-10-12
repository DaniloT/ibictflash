package Ibict.Games.CacaPalavras
{
	import Ibict.InputManager;
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
		
		
		public function CacaPalavras(root : MovieClip, dificuldade : int)
		{
			this.root = root;
			this.dificuldade = dificuldade;
			
			//music = new Sound(new URLRequest("music/caca_palavras.mp3"));
			//music.play(0,100,null);
			
			
			cacaPalavrasFundo = new FundoCacaProvisorio();
			
			bancoPalavras = new BancoPalavras();
			
			pontuacao = new CacaPalavrasPontuacao(485, 560);
			
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
					bancoPalavras.selectWords(8, 1, 1);
				break;
				case 1:
					bancoPalavras.selectWords(6, 3, 1);
				break;
				case 2:
					bancoPalavras.selectWords(5, 3, 2);
				break;
				case 3:
					bancoPalavras.selectWords(4, 4, 2);
				break;
				case 4:
					bancoPalavras.selectWords(2, 4, 4);
				break;
					
			}
			bancoPalavras.selectWords(8, 1, 1);
			palavras = bancoPalavras.getWords();
			dicas = bancoPalavras.getHints();

			         
			         
			var repete : Boolean;
			repete = false;
			
			do {
				try {
					grid = new Grid(15, 15, palavras, dicas, 387, 185, 14, 50,  blurFilters);
					painelResultados = new PainelResultados(dicas, palavras);
				} catch(errObject:Error) {
					trace("Erro no grid!" + errObject.message);
					trace("tentando novamente..");
					repete = true;
				}
			} while(repete);
			
			
			this.root.addChild(grid);
			this.root.addChild(painelResultados);
			
			inputManager = InputManager.getInstance();
			
			lineDraw = new MovieClip();
			lineDrawed = new MovieClip();
			
			mouseLineStart = new Point(0,0);
			mouseLineFinish = new Point(0,0);
			
			
			this.root.addChild(lineDraw);
			this.root.addChild(lineDrawed);
			
			
			
			lineDrawed.graphics.lineStyle(3,0x333333);
			
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
		}
		
		public function update() {
			var deslAngularX, deslAngularY : int;
			var variacaoMouse : Number;
			var espacamento;
			espacamento = 16;
			
			grid.update();
			

			
			/* verificando input do mouse */
			if(inputManager.mouseClick()) {
				mouseLineStart = inputManager.getMousePoint().clone();
			}
			
			lineDraw.graphics.clear();
			lineDraw.graphics.lineStyle(3,0x333333);
			
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
			
			if(inputManager.mouseUnclick()) {
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
				}
			}
			
			if(timerFinal.currentCount > 1500) {
				if(completo) {
					GameState.profile.cacaPalavrasData.setPontuacao(pontuacao.pontuacao);
					GameState.setState(GameState.ST_SELECAO_CACA);	
				} else {
					GameState.setState(GameState.ST_SELECAO_CACA);
				}
			}
			

			
			if(timer.currentCount == 350) { 
				timerFinal.start();
				acabouTempoImagem.play();
				cacaPalavrasFundo.filters = [blurFilters];
				grid.filters = [blurFilters];
				blur = 1;
				blurFilters.blurX = blur;
				blurFilters.blurY = blur;
				
				
			}
			
			if(timer.currentCount > 350 || completo) {
				if(blur < 12) {
					blur++;
					blurFilters.blurX = blur;
					blurFilters.blurY = blur;
				}
				cacaPalavrasFundo.filters = [blurFilters];
				grid.filters = [blurFilters];
			}
			
			
	
			
			
			
		}

	}
}