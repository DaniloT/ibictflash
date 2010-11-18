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
		
		public var voltar : MovieClip;

		public function Cooperativa(imgNum:int){

			fundo = new CooperativaFundo;
			partes = new Array();
			partesX = new Array();
			partesY = new Array();
			trava = new Array();
			duplicado = new Array();
			
			voltar = new MiniBotaoVoltar;
			
			voltar.x = 707.95;
			voltar.y = 500.95;
			voltar.stop();
			fundo.addChild(voltar);
			
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

				} else {
					if (imgNum == 3) {
						
						sombra = new B3Sombra;
						sombra.stop();
						sombra.x = 344.85;
						sombra.y = 126;
						fundo.addChild(sombra);
						
						parte = new B3P1;
						parte.x = 30.9;
						parte.y = 71;
						parte.stop();
						partes.push(parte);
						posX = 89.95;
						posY = 173.2;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
						parte = new B3P2;
						parte.x = 31.05;
						parte.y = 142.85;
						parte.stop();
						partes.push(parte);
						posX = 106.8;
						posY = 152.25;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(2);
						fundo.addChild(parte);
						
						parte = new B3P3;
						parte.x = 111.6;
						parte.y = 56.7;
						parte.stop();
						partes.push(parte);
						posX = 85.5;
						posY = 145.3;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
						parte = new B3P2;
						parte.x = 220.05;
						parte.y = 401;
						parte.stop();
						partes.push(parte);
						posX = 208.7;
						posY = 188.9;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(-2);
						fundo.addChild(parte);
						
						parte = new B3P4;
						parte.x = 145.95;
						parte.y = 322.05;
						parte.stop();
						partes.push(parte);
						posX = 221.9;
						posY = 209.2;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
						parte = new B3P5;
						parte.x = 60.45;
						parte.y = 462.95;
						parte.stop();
						partes.push(parte);
						posX = 237.9;
						posY = 122.2;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
						parte = new B3P6;
						parte.x = 37.75;
						parte.y = 346.05;
						parte.stop();
						partes.push(parte);
						posX = 85.8;
						posY = 201.45;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
						parte = new B3P7;
						parte.x = 210.4;
						parte.y = 218.55;
						parte.stop();
						partes.push(parte);
						posX = 148.9;
						posY = 120.2;
						partesX.push(posX);
						partesY.push(posY);
						trava.push(0);
						duplicado.push(0);
						fundo.addChild(parte);
						
					} else {
						if (imgNum == 4) {
							
							sombra = new B4Sombra;
							sombra.stop();
							sombra.x = 448.9;
							sombra.y = 189.2;
							fundo.addChild(sombra);
							
							parte = new B4P1;
							parte.x = 40.55;
							parte.y = 65.9;
							parte.stop();
							partes.push(parte);
							posX = 600.9;
							posY = 266.15;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B4P2;
							parte.x = 194.25;
							parte.y = 18.8;
							parte.stop();
							partes.push(parte);
							posX = 504.9;
							posY = 391.35;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(1);
							fundo.addChild(parte);
							
							parte = new B4P3;
							parte.x = 217.85;
							parte.y = 439.3;
							parte.stop();
							partes.push(parte);
							posX = 568.55;
							posY = 391.35;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(-1);
							fundo.addChild(parte);
							
							parte = new B4P4;
							parte.x = 197.75;
							parte.y = 89.55;
							parte.stop();
							partes.push(parte);
							posX = 498;
							posY = 243.05;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B4P5;
							parte.x = 224.95;
							parte.y = 346.8;
							parte.stop();
							partes.push(parte);
							posX = 53.65;
							posY = 189.2;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B4P6;
							parte.x = 48.5;
							parte.y = 258.25;
							parte.stop();
							partes.push(parte);
							posX = 545.4;
							posY = 207.65;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(1);
							fundo.addChild(parte);
							
							parte = new B4P7;
							parte.x = 74.35;
							parte.y = 184.2;
							parte.stop();
							partes.push(parte);
							posX = 568.9;
							posY = 207.65;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(-1);
							fundo.addChild(parte);
							
							parte = new B4P8;
							parte.x = 37.7;
							parte.y = 416.15;
							parte.stop();
							partes.push(parte);
							posX = 551.35;
							posY = 236.15;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B4P9;
							parte.x = 23.95;
							parte.y = 467.4;
							parte.stop();
							partes.push(parte);
							posX = 449;
							posY = 270.1;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
						} else {
							
							sombra = new B5Sombra;
							sombra.stop();
							sombra.x = 404.75;
							sombra.y = 175.35;
							fundo.addChild(sombra);
							
							parte = new B5P1;
							parte.x = 226.95;
							parte.y = 129.15;
							parte.stop();
							partes.push(parte);
							posX = 404.5;
							posY = 302.9;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(4);
							fundo.addChild(parte);
							
							parte = new B5P2;
							parte.x = 62.95;
							parte.y = 59.4;
							parte.stop();
							partes.push(parte);
							posX = 482.8;
							posY = 445.2;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(1);
							fundo.addChild(parte);
							
							parte = new B5P3;
							parte.x = 53.15;
							parte.y = 353.35;
							parte.stop();
							partes.push(parte);
							posX = 562.2;
							posY = 446.75;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(-1);
							fundo.addChild(parte);
							
							parte = new B5P4;
							parte.x = 169.05;
							parte.y = 249;
							parte.stop();
							partes.push(parte);
							posX = 485.7;
							posY = 272.5;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B5P5;
							parte.x = 73;
							parte.y = 469.95;
							parte.stop();
							partes.push(parte);
							posX = 621.75;
							posY = 305.85;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(-4);
							fundo.addChild(parte);
							
							parte = new B5P6;
							parte.x = 154.45;
							parte.y = 150.65;
							parte.stop();
							partes.push(parte);
							posX = 498.45;
							posY = 174.25;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B5P7;
							parte.x = 48.95;
							parte.y = 496.6;
							parte.stop();
							partes.push(parte);
							posX = 517.3;
							posY = 215.2;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B5P8;
							parte.x = 248.4;
							parte.y = 215.2;
							parte.stop();
							partes.push(parte);
							posX = 565.8;
							posY = 215.2;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
							parte = new B5P9;
							parte.x = 183.05;
							parte.y = 488.05;
							parte.stop();
							partes.push(parte);
							posX = 457.9;
							posY = 174.45;
							partesX.push(posX);
							partesY.push(posY);
							trava.push(0);
							duplicado.push(0);
							fundo.addChild(parte);
							
						}
					}
				}
			}
		}
	}
}