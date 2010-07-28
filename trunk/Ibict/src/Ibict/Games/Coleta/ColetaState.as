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
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : MyCursorClass;
		
		public function ColetaState()
		{
			var i : int;
			mainInstance = Main.getInstance();
			inputManager = InputManager.getInstance();
			
			started = false;
			
			// Scene root node...
			root = new MovieClip();
			root.added = false;
			
			fundo = new cltFundo();
			fundoArvores = new cltFundoArvores();
			
			
			// Creates points text...
			points_mc.x = 5;
			points_mc.y = 550;
			
			
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
		}
		
		public override function assume(previousState : State){
			var i:int;
			
			Mouse.show();
			
			root.addChild(myCursor);
			if (!mainInstance.stage.contains(this.root)){
				root.addChild(fundo);
				root.addChild(points_mc);
				root.addChild(fundoArvores);
				
				
				/** AQUI TEM Q SER .PAPER MESMO??? Oo */
				for(i = 0; i < TrashTypesEnum.size /*i < TrashTypesEnum.size*/; i++){
					root.addChild(bins[i]);
				}
				
				if (!started) {
					points = 0;
					
					trashes = new Array();
					for (i = 0; i < NUM_ELEMENTS; i++) {
						newTrash(i, true)
					}
					
					started = true;
				}
				
				mainInstance.stage.addChild(this.root);
			}
			
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}			
		}
		
		public override function leave(){
			Mouse.show();
			root.removeChild(myCursor);
		}
		
		public override function enterFrame(e : Event)
		{
			if(inputManager.kbClick(Keyboard.SPACE)){
				//GameState.setState(GameState.ST_PAUSE);
			}
			processMouse(e);
			
			processTrashes(e);
			
			processAnimation(e);
			
			/* atualiza o alpha do fundo */
			fundoArvores.alpha = points/100;
			
			/* Atualiza a quantidade de pontos mostrada na tela */
			points_mc.points_text.text = points.toString();
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
				respawn = trashes[i].toBeRespawned();
				test = false;
				
				// testa se colidiu com alguma lixeira
				for (var j : int = 0; (j < bins.length) && (!test); j++) {
					if ((test = trashes[i].pixelCollidesWith(bins[j]))) {
						if (j == trashes[i].getTargetBin()) {
							points += trashes[i].getRightPoints();
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
					root.removeChild(trashes[i]);
					newTrash(i, false);
				}
				
				if(respawn) {
					trashes[i].y = - 100;
					trashes[i].setVelocity(0,0);
				}
				
				trashes[i].update(e);
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
		
		private function newTrash(index : int, randomY : Boolean)
		{
			var trash : Trash = null;
			var type : int = Math.floor(Math.random() * TrashTypesEnum.size);
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

		}
		
		public function setNroLixos(nro_lixos : int) {
			this.nro_lixos = nro_lixos;
			
		}
	}
}