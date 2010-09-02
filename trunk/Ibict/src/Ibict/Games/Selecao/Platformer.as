package Ibict.Games.Selecao
{
	
	import Ibict.InputManager;
	import Ibict.States.GameState;
	import Ibict.TextureScrollable;
	import Ibict.Util.Temporizador;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	
	public class Platformer extends MovieClip
	{
		/* animacoes */
		var PARADO = 0;
		var ANDANDO = 1;
		var PULANDO = 2;
		
		var fundo : TextureScrollable;
		
		
		var vx : Number, vy : Number;
		var cenario : TextureScrollable;
		var objetosSprings : TextureScrollable;
		var objetosLixos : TextureScrollable;
		var placarLixos : MovieClip;
		var inimigos : Inimigos;
		var gravidade : int;
		var staticBall : TextureScrollable;
		var inputManager : InputManager;
		var colisores : Colisores;
		var bloqueiaPulo : Boolean;
		var temporizadorPulo : Temporizador;
		var relogio : Relogio;
		var estaNoChao : Boolean;
		
		var spritePersonagem : SpritePersonagem;
		
		var divisorTempo : int;
		
		var textoPontuacao : TextField;
		var formatoPontuacao : TextFormat;
		
		var pontuacao : int;
		var pontuacaoMax : int;
		
		var fundobranco : MovieClip;
		
		var endingCounter : int;
		var finished : Boolean;
		
		var papelTeste : MovieClip;
		
		var collisionMap : Array;
		var nstage : int;
		
		

		public function loadImages() {
			fundo = new selectFundoParque();
			staticBall = new selectSB();
			spritePersonagem = new SpritePersonagem();
			cenario = new selectStage1();
			objetosLixos = new selectLixos();
			objetosSprings = new selectSprings1();
			inimigos = new selectInimigos1();
			placarLixos = new selectPlacarLixosColetados();
			
			
			
			this.addChild(fundo);
			this.addChild(staticBall);
			this.addChild(spritePersonagem);
			this.addChild(cenario);
			this.addChild(objetosLixos);
			this.addChild(objetosSprings);
			this.addChild(inimigos);
			this.addChild(placarLixos);
			
		
		}
		
				
		public function Platformer(nstage : int)
		{
			loadImages();
			
			this.nstage = nstage;
					
			
		
					
			
			/* instanciando objetos e setando variaveis principais */
			gravidade = 1;
			
			staticBall.visible = false;
			staticBall.x = 0;
			staticBall.y = 0;
			
			
			
			staticBall.px = 3;
			staticBall.py = 3;
			vx = 0;
			vy = 0;
			
			
		
			
			
			/* inicializando o inputManager */
			inputManager = InputManager.getInstance();
			
			/* inicializando o cenario */
			
			
			/* inicializando os objetos de lixos */
			
			
			
			/* inicializando os objetos das molas */
			
					

			/* inicializando os inimigos */
			
			
			
			
			 
			/* inicializando o placar */
			
			
			placarLixos.x = 10;
			placarLixos.y = 540;
			
			formatoPontuacao = new TextFormat();
			formatoPontuacao.font = "tahoma";
			formatoPontuacao.size = 14;
			
			textoPontuacao = new TextField();
			textoPontuacao.defaultTextFormat = formatoPontuacao;
			textoPontuacao.x = 30;
			textoPontuacao.y = 555;
			this.addChild(textoPontuacao);
			
			pontuacao = 0;
			textoPontuacao.text = pontuacao.toString();
		
			/* inicializando o relogio */
			
			switch(nstage) {
				case 1:
				relogio = new Relogio(2, 15);
				
				break;
				case 2:
				relogio = new Relogio(2, 15);
				
				break;
				
				case 3:
				relogio = new Relogio(3, 15);
				
				break;
				case 4:
				relogio = new Relogio(3, 15);
				break;
				case 5:
				relogio = new Relogio(2, 30);
				break;
				
				default:
				relogio = new Relogio(2, 30);
				break;
			}
			relogio.start();
			this.addChild(relogio);
			relogio.x = 10;
			relogio.y = 10;
			
						
			/* seta o bloqueiaPulo */
			bloqueiaPulo = false;
			
			
			
			divisorTempo = 33;
			
			/* inicializando o temporizador do pulo */
			temporizadorPulo = new Temporizador();
			
			/* construindo a fase */
			var iMax : int;
			var jMax : int;
			var i, j, valorcelula : int;
			var chao : MovieClip;
			var grama : MovieClip;
			var lixo : MovieClip;
			var spring : MovieClip;
			var oinimigo : MovieClip;
			var stagesData : Array;
			
			switch(nstage) {
				case 1: 
					stagesData = StagesData.stage01;
					break;
				case 2: 
					stagesData = StagesData.stage02;
					break;
				case 3: 
					stagesData = StagesData.stage03;
					break;
				case 4: 
					stagesData = StagesData.stage04;
					break;
				case 5: 
					stagesData = StagesData.stage05;
					break;
				case 6: 
					stagesData = StagesData.stage06;
					break;
				case 7: 
					stagesData = StagesData.stage07;
					break;
				case 8: 
					stagesData = StagesData.stage08;
					break;
				case 9: 
					stagesData = StagesData.stage09;
					break;
				case 10: 
					stagesData = StagesData.stage10;
					break;
				default:
					trace("erro!");
				break;
					
			}
			
			jMax = stagesData[0];
			iMax = stagesData[1];
			
			
			
			collisionMap = new Array(new Array(stagesData[0]));
			for(i = 0; i < stagesData[0]; i++) 
				collisionMap.push(new Array(stagesData[1]));
		
			
			for (i = 0; i < iMax; i++) {
				for (j = 0; j < jMax; j++) {
					valorcelula = stagesData[i*jMax + j + 2];
					if(valorcelula > 0 && valorcelula < 7) {
						chao = new selectChao001();
						chao.y = i*50;
						chao.x = j*50;
						
						cenario.addChild(chao);
						collisionMap[i][j] = true;
					} else {
						collisionMap[i][j] = false;
					}
					
					if(valorcelula > 3 && valorcelula < 7) {
						grama = new selectGrama001();
						grama.y = i*50;
						grama.x = j*50;
						
						cenario.addChild(grama);
					}
					
					if(valorcelula == 7) {
						spring = new selectSpring();
						
						spring.y = i*50 + 50;
						spring.x = j*50;
						
						objetosSprings.addChild(spring);
					}
					
					if(valorcelula == 8 || valorcelula == 9) {
						lixo = new selectLixo();
						
						lixo.y = i*50 + 10;
						lixo.x = j*50 + 10;
						
						objetosLixos.addChild(lixo);
					}
				
					
					if(valorcelula == 12) {
						staticBall.px = j*50 + 10;
						staticBall.py = i*50 + 10;
					}
					
					if(valorcelula == 13) {
						oinimigo = new selectInimigo();
						
						oinimigo.y = i*50 + 25;
						oinimigo.x = j*50;

						
						inimigos.addChild(oinimigo);
					}
					
				}
			}
			
			/* inicializando os colisores */
			colisores = new Colisores(cenario, inimigos, this, collisionMap, iMax, jMax);
			
			/* setando o centro */
			staticBall.setCenter(staticBall);
			cenario.setCenter(staticBall);
			objetosLixos.setCenter(staticBall);
			objetosSprings.setCenter(staticBall);
			inimigos.setCenter(staticBall);
			fundo.setCenter(staticBall);
			colisores.setCentro(staticBall);

			
			pontuacaoMax = objetosLixos.numChildren;
			
			/* colocando o fundo branco */
			fundobranco = new selectFundoBranco();
			fundobranco.alpha = 0;
			endingCounter = 0;
			finished = false;
			this.addChild(fundobranco);
			
			trace("imax, jmax");
			trace(iMax);
			trace(jMax);
			/* setando os limites do scrolling */
			cenario.setLimit(iMax*50, jMax*50);
			objetosSprings.setLimit(iMax*50, jMax*50);
			objetosLixos.setLimit(iMax*50, jMax*50);
			staticBall.setLimit(iMax*50, jMax*50);
			fundo.setLimit(iMax*50, jMax*50);
			spritePersonagem.setLimit(iMax*50, jMax*50);
			
			
			
		}
				
		private function detectaColisao(): Boolean {
			
			return false;
		}
		
		private function updatePhysics(dt : int) {
			
			/* aplicando tudo que fara o personagem se mover */
			var count : int;
			var i : int;
			var objeto : DisplayObject;
			var dx, dy : int;
			
			
			if(!colisores.detectaColisaoBaixo()) {
				vy += gravidade*dt/divisorTempo;
				estaNoChao = false;
			} else {
				estaNoChao = true;
				vy = 2;
				temporizadorPulo.stop();
				bloqueiaPulo = false;
			}		
			
			/*aplicando controle do pulo */
			
			if(vy > 2) {
				temporizadorPulo.start();
				bloqueiaPulo = true;
			}
			
			if(inputManager.isDown(Keyboard.UP)) {
				temporizadorPulo.start();
				if(temporizadorPulo.getCount() < 200 && !bloqueiaPulo) {
					vy = -10;
					staticBall.py -= 2;					
				}
				
				
			}
			
			/* verifica se esta pulando em cima de um inimigo */
			if((objeto = colisores.detectaColisaoInimigoBaixo()) != null) {
				inimigos.removeChild(objeto);
				vy = - 10;
			}
			
			/* verifica se levou dano de um inimigo */
			if(colisores.detectaColisaoInimigoDireita() != null) {
				vy = -10;
				vx = - 5;
			}
			
			if(colisores.detectaColisaoInimigoEsquerda() != null) {
				vy = -10;
				vx = + 5;
			}

			colisores.colisorDireita.avanca(vx, 0);
			colisores.colisorEsquerda.avanca(vx, 0);
			colisores.colisorCima.avanca(vx, vy);
			if(colisores.detectaColisaoDir() || colisores.detectaColisaoEsq()) {
				vx = 0;
			}
			
			if(inputManager.isDown(Keyboard.RIGHT) && !colisores.detectaColisaoDir()) {
				if(vx < 7)
					vx += 1;
			} else if(inputManager.isDown(Keyboard.LEFT) && !colisores.detectaColisaoEsq()) {
				if(vx > -7)
					vx += -1;
			} else {
				if(!inputManager.isDown(Keyboard.RIGHT) && vx > 0) {
					vx -= 1;
				}
				if(!inputManager.isDown(Keyboard.LEFT) && vx < 0) {
					vx += 1;
				}
				
			}
			colisores.colisorDireita.retorna();
			colisores.colisorEsquerda.retorna();
			
			
			
			
			if(colisores.detectaColisaoCima() && vy < 0) {
				staticBall.py -= vy;
				vy = 0;
				bloqueiaPulo = true;
			}
			colisores.colisorCima.retorna();
			
			/* verifica colisao com objetos de springs do cenario */
			for(i = 0; i < objetosSprings.numChildren; i++) {
				objeto = objetosSprings.getChildAt(i);
				
				if(staticBall.hitTestObject(objeto)) {
					vy = - 28;
					staticBall.py -= 2;
				}
				
			}
			
			
			dx = vx*dt/divisorTempo;
			dy = vy*dt/divisorTempo;
			if(dx > 45) dx = 45;
			if(dy > 45) dy = 45;
	
			staticBall.px += dx;
			staticBall.py += dy;	
			
			colisores.updatePhysics(dt);
			
			
			/* update nos inimigos*/
			inimigos.updatePhysics();
			
			
			/* da um update render de novo */
			colisores.colisorMenosBaixo.avanca(vx, vy);
									
			
			
			while(colisores.detectaColisaoMenosBaixo()) {
				staticBall.py--;
				colisores.updatePhysics(dt);
				colisores.updateRender(dt);
			}
			colisores.colisorMenosBaixo.retorna();
			
			
			
			/* verifica colisao com os objetos de lixo do cenario */
			for(i = 0; i < objetosLixos.numChildren; i++) {
				objeto = objetosLixos.getChildAt(i);
				
				
				if(staticBall.hitTestObject(objeto)) {
					objetosLixos.removeChild(objeto);
					pontuacao++;
					textoPontuacao.text = pontuacao.toString();
				}
			}
			
			
			/* atualiza o relogio */
			relogio.update();
			
			/* verifica se o relogio se esgotou ou pegou todos lixos */
			if(relogio.isZero() || pontuacao == pontuacaoMax) {	
				finished = true;
			}
			
			if(finished) {
				endingCounter = endingCounter + 5;
				fundobranco.alpha = endingCounter/100;
			}
			
			if(endingCounter > 100) {
				var pontuacao_extra : int;
				
				pontuacao_extra = (1 - relogio.getPorcentagem())*(pontuacaoMax*5);
				trace(pontuacao_extra);
				trace(relogio.getPorcentagem());
				
				
				/* verifica se pegou mais da metade dos lixos.
				 * caso afirmativo, entrega uma estrela */
				 if(pontuacao >= pontuacaoMax/2) {
				 	GameState.profile.selecaoColetaData.completed[nstage - 1] = true;
				 }
				 
				GameState.setColetaState(pontuacao, pontuacao_extra, nstage);
			}
			
			
			
			/* atualiza posicao do sprite personagem */
			spritePersonagem.x = staticBall.x;
			spritePersonagem.y = staticBall.y;
			
			if(vx > 0) spritePersonagem.setDireita();
			else if(vx < 0) spritePersonagem.setEsquerda();
			
			/* decide animacao */
			if(estaNoChao) {
				if(vx == 0)
					spritePersonagem.setParado();
				else
					spritePersonagem.setAndando();
			} else {
				spritePersonagem.setPulando();
			}
			
			
		}
		
		private function updateRenders(dt : int) {
			fundo.Render();
			staticBall.Render();
			spritePersonagem.Render();
			cenario.Render();
			objetosLixos.Render();
			objetosSprings.Render();
			inimigos.Render();
			colisores.updateRender(dt);
		}
		
		public function update(dt : int) {
			//if(dt >60) dt = 30;
			updateRenders(dt);
			updatePhysics(dt);		
			
			
		}

	}
}