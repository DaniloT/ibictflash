﻿package Ibict.Games.SeletorFases
{
	import Ibict.InputManager;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SeletorFasesState  extends State
	{
		var fundo : MovieClip;
		var fase : Array;
		var star : Array;
		var selecionado : Array;
		var ativado : Array;
		var inputManager : InputManager;
		var glowFilter : Array;
		var textPontuacoes : Array;
		var textFormat : TextFormat;
		var textFormat2 : TextFormat;
		
		private var musica : Music;
		
		var MISSOES_POSITION_X : int = 53;
		var MISSOES_POSITION_Y : int = 400;
		var exclamacao : MovieClip;
		var mensagemMissoes : MovieClip;
		var descricaoEstrelasFase : TextField;
		
		private var gameStateInstance : GameState;
		
		public function SeletorFasesState()
		{
			var i : int;
			fase = new Array(5);
			selecionado = new Array(5);
			ativado = new Array(5);
			star = new Array(10);
			fundo = new selecaoFasesFundo();
			glowFilter = new Array(5);
			textPontuacoes = new Array(5);
			
			root = new MovieClip();
			inputManager = InputManager.getInstance();
			gameStateInstance = GameState.getInstance();
			
			textFormat = new TextFormat();
			textFormat.font = "tahoma";
			textFormat.size = 18;
			textFormat.color = 0xFFFFFF;
			
			textFormat2 = new TextFormat();
			textFormat2.font = "tahoma";
			textFormat2.size = 18;
			textFormat2.color = 0x053E05;
			
			for(i = 0; i < 5; i++) {
				var text : TextField;
				glowFilter[i] = new GlowFilter(0x0D8E0D, .75, 0, 0, 2, 2);
				textPontuacoes[i] = new TextField();
				text = textPontuacoes[i];
				text.defaultTextFormat = textFormat;
				
				
			}
			
			mensagemMissoes = new comumMensagemMissoes();
			mensagemMissoes.x = MISSOES_POSITION_X;
			mensagemMissoes.y = MISSOES_POSITION_Y;
			
			descricaoEstrelasFase = new TextField();
			
			descricaoEstrelasFase.x = MISSOES_POSITION_X + 31;
			descricaoEstrelasFase.y = MISSOES_POSITION_Y + 37;
			
			descricaoEstrelasFase.defaultTextFormat = textFormat2;
			
			descricaoEstrelasFase.text = "Termine cada fase para ganhar a primeira estrela de cada uma. \nA segunda estrela é obtida por pontuação.";
			descricaoEstrelasFase.width = 700;
			
			exclamacao = new comumInfoExclamation();
			
			exclamacao.x = MISSOES_POSITION_X + 5;
			exclamacao.y = MISSOES_POSITION_Y + 30;

			
		}
		
		public override function assume(previousState : State) {
			var i, j : int;
			var mclip : MovieClip;

			musica = new Music(new MusicaMundo, false, 20);
			
			if (previousState != null){
				//Main.getInstance().stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}
			
			//Main.getInstance().stage.addChild(this.root);
			gameStateInstance.addGraphics(this.root);
			
			this.root.addChild(fundo);
			
			fase[0] = new selecaoFasesFase01();
			
			ativado[0] = true;
			
			if(GameState.profile.selecaoColetaData.completed[0]) {
				fase[1] = new selecaoFasesFase02();
				ativado[1] = true;
			} else {
				fase[1] = new selecaoFasesFase02desativado();
				ativado[1] = false;
			}
			
			if(GameState.profile.selecaoColetaData.completed[1]) {
				fase[2] = new selecaoFasesFase03();
				ativado[2] = true;
			} else {
				fase[2] = new selecaoFasesFase03desativado();
				ativado[2] = false;
			}
			
			if(GameState.profile.selecaoColetaData.completed[2]) {
				fase[3] = new selecaoFasesFase04();
				ativado[3] = true;
			} else {
				fase[3] = new selecaoFasesFase04desativado();
				ativado[3] = false;
			}
			
			if(GameState.profile.selecaoColetaData.completed[3]) {
				fase[4] = new selecaoFasesFase05();
				ativado[4] = true;
			} else {
				fase[4] = new selecaoFasesFase05desativado(); 
				ativado[4] = false;
			}
			
			
			
			
			
			star[0] = new selecaoFasesEstrela01();
			star[1] = new selecaoFasesEstrela02();
			star[2] = new selecaoFasesEstrela01();
			star[3] = new selecaoFasesEstrela02();
			star[4] = new selecaoFasesEstrela01();
			star[5] = new selecaoFasesEstrela02();
			star[6] = new selecaoFasesEstrela01();
			star[7] = new selecaoFasesEstrela02();
			star[8] = new selecaoFasesEstrela01();
			star[9] = new selecaoFasesEstrela02();
			
			fase[0].x = 80;
			fase[0].y = 140;
			star[0].x = fase[0].x;
			star[0].y = fase[0].y;
			star[1].x = fase[0].x;
			star[1].y = fase[0].y;
			
			fase[1].x  = 310;
			fase[1].y = 140;
			star[2].x = fase[1].x;
			star[2].y = fase[1].y;
			star[3].x = fase[1].x;
			star[3].y = fase[1].y;
			
			fase[2].x = 540;
			fase[2].y = 140;
			star[4].x = fase[2].x;
			star[4].y = fase[2].y;
			star[5].x = fase[2].x;
			star[5].y = fase[2].y;
			
			fase[3].x = 195;
			fase[3].y = 265;
			star[6].x = fase[3].x;
			star[6].y = fase[3].y;
			star[7].x = fase[3].x;
			star[7].y = fase[3].y;
			
			fase[4].x = 425;
			fase[4].y = 265;
			star[8].x = fase[4].x;
			star[8].y = fase[4].y;
			star[9].x = fase[4].x;
			star[9].y = fase[4].y;
			
			for(i = 0; i < 5; i++) {
				var text : TextField;
				text = textPontuacoes[i];
				
				text.text = GameState.profile.selecaoColetaData.getPoints(i).toString();
				
				text.x = fase[i].x + 13;
				text.y = fase[i].y + 57;
			}
			
			
			/* determinando a visibilidade das estrelas */
			for(i = 0; i < 5; i++) {
				for(j = 0; j < 2; j++) {
					if(GameState.profile.selecaoColetaData.getStar(i, j)) {
						star[2*i + j].visible = true;
					} else {
						star[2*i + j].visible = false;
					}
				}
			}			
			
			
			
			for(i = 0; i < 5; i++) {
				this.root.addChild(fase[i]);
				selecionado[i] = false;
				mclip = fase[i];
				mclip.filters = [glowFilter[i]];
			}
			
			for(i = 0; i < 10; i++) {
				this.root.addChild(star[i]);
			}
			
			for(i = 0; i < 5; i++) {
				this.root.addChild(textPontuacoes[i]);
			}
			
			this.root.addChild(mensagemMissoes);
			this.root.addChild(descricaoEstrelasFase);
			this.root.addChild(exclamacao);
		}
		
		public override function leave(){	
			musica.stop(true);
		}
		
		public override function enterFrame(e : Event) {
			var mclip : MovieClip;
			var i : int;
			
			if(inputManager.getMousePoint().x < 230 &&
				inputManager.getMousePoint().y > 524 &&
				inputManager.mouseClick()) {
					GameState.setState(GameState.ST_MUNDO);
				}
				
				
			for(i = 0; i < 5; i++) {
				mclip = fase[i];
				if(inputManager.isMouseInsideMovieClip(fase[i]) && ativado[i]) {
					selecionado[i] = true;
					if(inputManager.mouseClick()) {
						GameState.setSelecaoLevelState(i + 1);
					}
				} else {
					selecionado[i] = false;
				}
	
				if(selecionado[i]) {
					glowFilter[i].blurX += 3;
					if(glowFilter[i].blurX > 25) glowFilter[i].blurX = 25;
					mclip.filters = [glowFilter[i]];
				} else {
					glowFilter[i].blurX -= 3;
					if(glowFilter[i].blurX < 0) glowFilter[i].blurX = 0;
					mclip.filters = [glowFilter[i]];
				}
				
				
				
			}
			
		}

	}
}