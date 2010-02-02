﻿package States
{
	import Entities.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class GameState extends State
	{
		private var anim : Array = new Array();
		
		/* Maximum number of trash elements on screen. */
		private static const NUM_ELEMENTS : int = 5;
		
		/* Arrays for holding trashes and bins. */
		private var trashes : Array;
		private var bins : Array;
		
		/* Points counter and text. */
		private var points : int;
		private var points_mc : Points = new Points;

		/* Helps controlling this state's loading process. */
		private var started : Boolean;
		
		/* fundo */
		private var fundo : MovieClip;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : MyCursorClass;
		
		public function GameState()
		{
			started = false;
			
			// Scene root node...
			root = new MovieClip();
			
			fundo = new Fundo();
			root.addChild(fundo);
			
			// Creates points text...
			points_mc.x = 5;
			points_mc.y = 550;
			root.addChild(points_mc);
			
			
			// Creates bins...
			bins = new Array();
			bins[TrashTypesEnum.GLASS] = new GlassBin();
			bins[TrashTypesEnum.METAL] = new MetalBin();
			//bin[TrashTypesEnum.NOT_REC] = new NotRecBin();
			bins[TrashTypesEnum.PAPER] = new PaperBin();
			bins[TrashTypesEnum.PLASTIC] = new PlasticBin();
			for(var i:int = 0; i <= TrashTypesEnum.PAPER /*i < TrashTypesEnum.size*/; i++){
				root.addChild(bins[i]);
			}
			
			
			/* esconde o cursor padrao do mouse */
			Mouse.hide();
			myCursor =  new MyCursorClass();
			myCursor.gotoAndStop(1);
			root.addChild(myCursor);
			GameState.myCursor.visible = false;
			
			
		}
		
		public override function assume(previousState : State){
			if (!started) {
				points = 0;
				
				trashes = new Array();
				for (var i : int = 0; i < NUM_ELEMENTS; i++) {
					newTrash(i, true)
				}
				
				started = true;
			}
			
			if (previousState != null){
				Main.stage_g.removeChild(previousState.getGraphicsRoot());
			}
			
			Main.stage_g.addChild(this.root);
		}
		
		public override function leave()
		{	
		}
		
		public override function enterFrame(e : Event)
		{
			var remove, test : Boolean;
			var i :int;
			
			for (i = 0; i < trashes.length; i++) {
				remove = trashes[i].toBeRemoved();
				test = false;
				
				// testa se colidiu com alguma lixeira
				for (var j : int = 0; (j < bins.length) && (!test); j++) {
					if ((test = trashes[i].pixelCollidesWith(bins[j]))) {
						if (j == trashes[i].getTargetBin()) {
							points += trashes[i].getRightPoints();
							
							/* coloca a animacao na tela quando um lixo colide com a lixeira correta */
							anim.push(new RightBin());
							root.addChild(anim[anim.length-1]);
							anim[anim.length-1].x = bins[j].x + bins[j].width/2;
							anim[anim.length-1].y = bins[j].y;
							anim[anim.length-1].width = 70;
							anim[anim.length-1].height = 70;
							
						}
						else {
							points -= trashes[i].getWrongPoints();
							anim.push(new WrongBin());
							
							root.addChild(anim[anim.length-1]);
							anim[anim.length-1].x = bins[j].x + bins[j].width/2;
							anim[anim.length-1].y = bins[j].y;
							anim[anim.length-1].width = 70;
							anim[anim.length-1].height = 70;
							
						}
						/* adiciona o evento que testa o fim da animacao */
						if (anim.length == 1){
							root.addEventListener(Event.ENTER_FRAME, animHandler);
						}
					}
				}
				
				if (remove || test) {
					root.removeChild(trashes[i]);
					newTrash(i, false);
				}
				
				trashes[i].update(e);
			}
			
			/* Atualiza a quantidade de pontos mostrada na tela */
			points_mc.points_text.text = points.toString();
		}
		
		private function animHandler (e:Event){
			var i : int = 0;
			if(anim[0].currentFrame == anim[0].totalFrames){
				root.removeChild(anim[0]);
				for (i=0; i < (anim.length - 1); i++){
					anim[i] = anim[i+1];
				}
				anim[anim.length-1] = null;
				anim.length--;
			} 
			if (anim.length == 0){
				root.removeEventListener(Event.ENTER_FRAME, animHandler);
			}
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
				default:
					trash = new NotRec(randomY);
					break;
			}
			
			trashes[index] = trash;
			root.addChild(trashes[index]);
			
			/* linha necessaria para que o cursor do mouse nao fique atras dos lixos */
			root.swapChildren(trashes[index], GameState.myCursor);

		}
	}
}