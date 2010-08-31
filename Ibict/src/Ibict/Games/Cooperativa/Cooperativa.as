package Ibict.Games.Cooperativa
{
	import flash.display.MovieClip;
	
	public class Cooperativa extends MovieClip
	{
		/* Fundo do jogo. */
		public var fundo : MovieClip;
		public var parte : MovieClip;
		public var sombra : MovieClip;
		
		public var partes : Array;
		public var partesX : Array;
		public var partesY : Array;
		public var trava : Array;
		public var duplicado : Array;
		
		public var posX : Number;
		public var posY : Number;

		public function Cooperativa(imgNum:int){

			fundo = new CooperativaFundo;
			partes = new Array();
			partesX = new Array();
			partesY = new Array();
			trava = new Array();
			duplicado = new Array();
			
			if (imgNum == 1) {
				
				sombra = new B1Sombra;
				sombra.stop();
				sombra.x = 413.45;
				sombra.y = 246.45;
				fundo.addChild(sombra);
				
				parte = new B1P1;
				parte.x = 23.5;
				parte.y = 116.3;
				parte.stop();
				partes.push(parte);
				posX = 46.40;
				posY = 78.15;
				partesX.push(posX);
				partesY.push(posY);
				trava.push(0);
				duplicado.push(0);
				fundo.addChild(parte);
				
				parte = new B1P2;
				parte.x = 251.5;
				parte.y = 247.5;
				parte.stop();
				partes.push(parte);
				posX = 72.45;
				posY = 147.5;
				partesX.push(posX);
				partesY.push(posY);
				trava.push(0);
				duplicado.push(1);
				fundo.addChild(parte);
				
				parte = new B1P2;
				parte.x = 66.5;
				parte.y = 470.45;
				parte.stop();
				partes.push(parte);
				posX = 156.45;
				posY = 147.5;
				partesX.push(posX);
				partesY.push(posY);
				trava.push(0);
				duplicado.push(-1);
				fundo.addChild(parte);
				
				parte = new B1P3;
				parte.x = 237.5;
				parte.y = 386.75;
				parte.stop();
				partes.push(parte);
				posX = 73;
				posY = 30;
				partesX.push(posX);
				partesY.push(posY);
				trava.push(0);
				duplicado.push(0);
				fundo.addChild(parte);
				
				parte = new B1P4;
				parte.x = 45.5;
				parte.y = 253;
				parte.stop();
				partes.push(parte);
				posX = 5;
				posY = 4.25;
				partesX.push(posX);
				partesY.push(posY);
				trava.push(0);
				duplicado.push(0);
				fundo.addChild(parte);

			} else {
				if (imgNum == 2) {
					
					sombra = new B2Sombra;
					sombra.stop();
					sombra.x = 429.5;
					sombra.y = 234.55;
					fundo.addChild(sombra);
					
					parte = new B2P2;
					parte.x = 110.5;
					parte.y = 249;
					parte.stop();
					partes.push(parte);
					posX = 30.95;
					posY = 58.35;
					partesX.push(posX);
					partesY.push(posY);
					trava.push(0);
					duplicado.push(0);
					fundo.addChild(parte);
					
					parte = new B2P1;
					parte.x = 46.4;
					parte.y = 112.4;
					parte.stop();
					partes.push(parte);
					posX = 8.35;
					posY = 139.4;
					partesX.push(posX);
					partesY.push(posY);
					trava.push(0);
					duplicado.push(0);
					fundo.addChild(parte);
					
					parte = new B2P3;
					parte.x = 251;
					parte.y = 153;
					parte.stop();
					partes.push(parte);
					posX = 82.95;
					posY = 138.2;
					partesX.push(posX);
					partesY.push(posY);
					trava.push(0);
					duplicado.push(1);
					fundo.addChild(parte);
					
					parte = new B2P3;
					parte.x = 73;
					parte.y = 469.95;
					parte.stop();
					partes.push(parte);
					posX = 166.85;
					posY = 105.2;
					partesX.push(posX);
					partesY.push(posY);
					trava.push(0);
					duplicado.push(-1);
					fundo.addChild(parte);

				}
			}
		}
	}
}