package Ibict.Games.Coleta
{
	import Ibict.Games.Coleta.Entities.Dangerous;
	import Ibict.Games.Coleta.Entities.DangerousBin;
	import Ibict.Games.Coleta.Entities.Glass;
	import Ibict.Games.Coleta.Entities.GlassBin;
	import Ibict.Games.Coleta.Entities.Metal;
	import Ibict.Games.Coleta.Entities.MetalBin;
	import Ibict.Games.Coleta.Entities.NotRec;
	import Ibict.Games.Coleta.Entities.NotRecBin;
	import Ibict.Games.Coleta.Entities.Paper;
	import Ibict.Games.Coleta.Entities.PaperBin;
	import Ibict.Games.Coleta.Entities.Plastic;
	import Ibict.Games.Coleta.Entities.PlasticBin;
	import Ibict.Games.Coleta.Entities.Trash;
	import Ibict.Games.Coleta.Entities.TrashTypesEnum;
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.Music.Music;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;

	public class ColetaState extends State
	{
		private var mainInstance : Main;
		private var inputManager : InputManager;
		private var gameStateInstance : GameState;
		
		private var musica : Music;
		
		
		private var anim : Array = new Array();
		
		/* Maximum number of trash elements on screen. */
		private static const NUM_ELEMENTS : int = 5;
		
		/* Arrays for holding trashes and bins. */
		private var trashes : Array;
		private var bins : Array;
		private var onceTests : Array;
		
		/* Points counter and text. */
		private var points : int;
		private var points_mc : Points = new Points;

		/* Helps controlling this state's loading process. */
		private var started : Boolean;
		
		/* fundo */
		private var fundo : MovieClip;
		private var fundoArvores : MovieClip;
		
		/* nro_lixos */
		private var nro_lixos : int;
		private var lixos_count : int;
		private var lixos_catch_count : int;
		
		/* animacao inicial */
		private var fundoBranco : FundoBrancoColeta;
		private var animacao_inicial_ocorrendo : Boolean;
		private var alphaFundoBranco : Number;
		private var trashesAnim : Array;
		private var trashesAngle : Array;
		private var raio : int;
		private var fundo_preparese : ColetaImagemPreparese;
		private var alphaTrashes : Number;
		
		private var nstage : int;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : MyCursorClass;
		
		private function inicializa() {
			var i : int;
			started = false;
			
			// Scene root node...
			root = new MovieClip();
			root.added = false;
			
			fundo = new cltFundo();
			fundoArvores = new cltFundoArvores();
			
			
			// Creates points text...
			points_mc.x = 5;
			points_mc.y = 550;
			
			// set lixos_count = 0
			lixos_count = 0;
			lixos_catch_count = 0;
			
			// Creates bins...
			bins = new Array();
			bins[TrashTypesEnum.GLASS] = new GlassBin();
			bins[TrashTypesEnum.METAL] = new MetalBin();
			bins[TrashTypesEnum.NOT_REC] = new NotRecBin();
			bins[TrashTypesEnum.PAPER] = new PaperBin();
			bins[TrashTypesEnum.PLASTIC] = new PlasticBin();
			bins[TrashTypesEnum.DANGEROUS] = new DangerousBin();

			
			onceTests = new Array((bins.length + 1)*(bins.length + 1));
			for(i = 0; i < (bins.length + 1)*(bins.length + 1); i++) {
				onceTests[i] = false;
			}
			
			myCursor =  new MyCursorClass();
			myCursor.visible = false;
			myCursor.gotoAndStop(1);
			
			/* inicializando os elementos da animacao */
			fundoBranco = new FundoBrancoColeta();
			animacao_inicial_ocorrendo = true;
			alphaFundoBranco = 1;
			
			trashesAnim = new Array();
			
			trashesAnim[0] = new LixoAnim01();
			trashesAnim[1] = new LixoAnim02();
			trashesAnim[2] = new LixoAnim03();
			trashesAnim[3] = new LixoAnim04();
			trashesAnim[4] = new LixoAnim05();
			trashesAnim[5] = new LixoAnim06();
			trashesAnim[6] = new LixoAnim07();
			trashesAnim[7] = new LixoAnim08();
			
			trashesAngle = new Array();
			
			for(i = 0; i < 8; i++) {
				trashesAngle[i] = 0.125*i*Math.PI*2;
				trashesAnim[i].alpha = 0;
				trashesAnim[i].x = - 300;
				trashesAnim[i].y = - 300;
			}
			
			alphaTrashes = 0;
			
			raio = 200;
			
			fundo_preparese = new ColetaImagemPreparese();
	
		}
		
		public function ColetaState()
		{
			var i : int;
			mainInstance = Main.getInstance();
			inputManager = InputManager.getInstance();
			gameStateInstance = GameState.getInstance();
			
			
		
		}
		
		public override function assume(previousState : State){
			var i:int;
			
			musica = new Music(new MusicaSelecao, false, 20);
			
			inicializa();
			
			Mouse.show();
			
			root.addChild(myCursor);
			//if (!mainInstance.stage.contains(this.root)){
			if (!gameStateInstance.getGraphicsRoot().contains(this.root)){
				root.addChild(fundo);
				root.addChild(fundoArvores);
				
				
				/** AQUI TEM Q SER .PAPER MESMO??? Oo */
				for(i = 0; i < TrashTypesEnum.size /*i < TrashTypesEnum.size*/; i++){
					root.addChild(bins[i]);
				}
				
				if (!started) {
					
					
					trashes = new Array();
					for (i = 0; i < NUM_ELEMENTS; i++) {
						newTrash(i, true)
					}
					
					started = true;
				}
				
				root.addChild(points_mc);
				
				
				
				root.addChild(fundoBranco);
				
				for(i = 0; i < 8; i++) {
					root.addChild(trashesAnim[i]);
				}
				
				root.addChild(fundo_preparese);
				
				//mainInstance.stage.addChild(this.root);
				gameStateInstance.addGraphics(this.root);
			}
			
			
			if (previousState != null){
				//mainInstance.stage.removeChild(previousState.getGraphicsRoot());
				gameStateInstance.removeGraphics(previousState.getGraphicsRoot());
			}			
		}
		
		public override function leave(){
			musica.stop(true);
			Mouse.show();
			root.removeChild(myCursor);
		}
		
		public override function enterFrame(e : Event)
		{
			var i : int;
			if(inputManager.kbClick(Keyboard.SPACE)){
				//GameState.setState(GameState.ST_PAUSE);
			}
			
			if(inputManager.mouseClick()) {
				animacao_inicial_ocorrendo = false;
			}
			
			if(!animacao_inicial_ocorrendo) {
				alphaFundoBranco -= 0.1;
				if(fundoBranco != null) {
					fundoBranco.alpha = alphaFundoBranco;
					fundo_preparese.alpha = alphaFundoBranco;
					
					if(alphaFundoBranco < 0)  {
						alphaFundoBranco = 0;
						root.removeChild(fundoBranco);
						root.removeChild(fundo_preparese);
						
						fundoBranco = null;
						fundo_preparese = null;
					}
					
					
				}
				
				
				raio = raio + 10;
				if(raio > 3000) raio = 3000;
				
				processMouse(e);
				processTrashes(e);
				processAnimation(e);
			} else {
				for(i = 0; i < 8; i++) {
					trashesAnim[i].alpha = alphaTrashes;
				}
				alphaTrashes += 0.1;
				if(alphaTrashes > 1) alphaTrashes = 1;
			}

			processStartAnimation(e);
			
			/* atualiza o alpha do fundo */
			fundoArvores.alpha = lixos_catch_count/nro_lixos;
			
			/* Atualiza a quantidade de pontos mostrada na tela */
			points_mc.points_text.text = points.toString();
	
			if(nro_lixos == lixos_catch_count) {
				GameState.profile.selecaoColetaData.setPoints(nstage, points);
				GameState.setState(GameState.ST_SELECAO_FASES);
			}
		}
		
		private function processStartAnimation(e : Event) {
			var i : int;
			
			for(i = 0; i < 8; i++) {
				trashesAngle[i] += 0.1;
				if(trashesAngle[i] > 2*Math.PI) {
					trashesAngle[i] = trashesAngle[i] - 2*Math.PI;
				}
				
				trashesAnim[i].x = Math.sin(trashesAngle[i])*raio + 350;
				trashesAnim[i].y = Math.cos(trashesAngle[i])*raio + 250;
			}
			
			
		}
		
		private function processMouse(e : Event) {
			var mouse : Point = inputManager.getMousePoint();
			//myCursor.visible = inputManager.isMouseInside();
			myCursor.visible = false;
			//myCursor.x = mouse.x;
			//myCursor.y = mouse.y;
			
			/* Quando o mouse é clicado (na primeira vez), vai para o proximo frame no cursor (mao fechada)*/
			if (inputManager.mouseClick() || inputManager.mouseUnclick()) {
				myCursor.play();
			}
		}
		
		private function processTrashes(e : Event) {
			var respawn, test, wrong : Boolean;
			var i :int;
			
			for (i = 0; i < trashes.length; i++) {
				if(trashes[i] != null) {
					respawn = trashes[i].toBeRespawned();
					test = false;
					
					// testa se colidiu com alguma lixeira
					for (var j : int = 0; (j < bins.length) && (!test); j++) {
						if ((test = trashes[i].pixelCollidesWith(bins[j]))) {
							if (j == trashes[i].getTargetBin()) {
								points += trashes[i].getRightPoints();
								lixos_catch_count++;
								addBinAnimation(new RightBin(), j);
							}
							else {
								if(!onceTests[i*(bins.length + 1) + j]) {
									points -= trashes[i].getWrongPoints();
									addBinAnimation(new WrongBin(), j);
									onceTests[i*(bins.length + 1) + j] = true;
								}
								
								test = false;
								wrong = true;
								if(j == TrashTypesEnum.PLASTIC ||
									j == TrashTypesEnum.PAPER) {
										trashes[i].setVelocity(-8, -8);
										trashes[i].addPosition(-5, -5);
									} else {
										trashes[i].setVelocity(8, -8);
										trashes[i].addPosition(5, -5);
									}
									
									
							}
						} else {
							onceTests[i*(bins.length + 1) + j] = false;
						}
					}
					
					if (test) {
						if(trashes[i] != null) root.removeChild(trashes[i]);
						if(!newTrash(i, false)) trashes[i] = null;
						
					}
					
					if(respawn && trashes[i] != null) {
						trashes[i].y = - 100;
						trashes[i].setVelocity(0,0);
					}
					
					if(trashes[i] != null) trashes[i].update(e);
				}
				
			}
		}
		
		private function processAnimation(e : Event) {
			var i : int = 0;
			while (i < anim.length) {
				if(anim[i].currentFrame == anim[i].totalFrames) {
					root.removeChild(anim[i]);
					removeAnimation(i);					
				}
				else
					i++;
			}
		}
		
		private function addBinAnimation(clip : MovieClip, binIndex : int) {
			var bin : MovieClip = bins[binIndex];
			
			clip.x = bin.x + bin.width / 2;
			clip.y = bin.y;
			clip.width = 70;
			clip.height = 70;
			
			anim.push(clip);
			root.addChild(clip);
		}
		
		private function removeAnimation(index : int) {
			for (var i : int = index; i < (anim.length - 1); i++){
				anim[i] = anim[i+1];
			}
			
			anim[anim.length-1] = null;
			anim.length--;	
		}
		
		private function newTrash(index : int, randomY : Boolean) : Boolean
		{
			var trash : Trash = null;
			var type : int = Math.floor(Math.random() * TrashTypesEnum.size);
			if(lixos_count < nro_lixos + 1) {
				switch (type) {
					case TrashTypesEnum.PAPER:
						trash = new Paper(randomY);
						break;
					case TrashTypesEnum.PLASTIC:
						trash = new Plastic(randomY);
						break;
					case TrashTypesEnum.GLASS:
						trash = new Glass(randomY);
						break;
					case TrashTypesEnum.METAL:
						trash = new Metal(randomY);
						break;
					case TrashTypesEnum.DANGEROUS:
						trash = new Dangerous(randomY);
						break;
					default:
						trash = new NotRec(randomY);
						break;
				}
			
				trashes[index] = trash;
				root.addChild(trashes[index]);
				
				/* linha necessaria para que o cursor do mouse nao fique atras dos lixos */
				root.swapChildren(trashes[index], myCursor);
				lixos_count++;
				return true;
			}
			
			return false;

		}
		
		public function setNroLixos(nro_lixos : int) {
			this.nro_lixos = nro_lixos;
			
		}
		
		public function addPontuacaoInicial(pontuacao : int) {
			points = pontuacao;
		}
		
		public function setFase(nstage : int) {
			this.nstage = nstage;
		}
		
	}
}