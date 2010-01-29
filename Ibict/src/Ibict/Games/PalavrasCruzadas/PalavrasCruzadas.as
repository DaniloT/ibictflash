package Ibict.Games.PalavrasCruzadas
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import Ibict.InputManager;
	
	public final class PalavrasCruzadas 
	{
		var grid : Grid;
		var palavras : Array;
		var dicas : Array;
		var root : MovieClip;
		var lineDraw : MovieClip;
		var lineDrawed : MovieClip;
		var angle : Number;
		
		var inputManager : InputManager;
		
		var mouseLineStart : Point;
		var mouseLineFinish : Point;
		
		
		public function PalavrasCruzadas(root : MovieClip)
		{
			this.root = root;
			palavras = new Array("Acido", "Luz", "Camera", "Acao", "Amor", "Paixao", "Vida", "Sonhos", "Paz", "Humanidade", "Risos");
			dicas = new Array("Corrói pele.",
			 "Ilumina a sala.",
			  "Serve para tirar fotos.",
			   "Este filme é agitado, ele é de _____.",
			    "Sentimento que nos une.",
			     "Sentimento nobre.", 
			     "Algo que nos é inerente.",
			      "Aquilo que temos quando dormimos.",
			       "Situacao boa.",
			        "Assim caminha a _______.",
			         "Algo que temos quando nos contam\npiada.");
			grid = new Grid(15, 15, palavras, dicas, 100, 100, root);
			
			inputManager = InputManager.getInstance();
			
			lineDraw = new MovieClip();
			lineDrawed = new MovieClip();
			
			mouseLineStart = new Point(0,0);
			mouseLineFinish = new Point(0,0);
			
			this.root.addChild(lineDraw);
			this.root.addChild(lineDrawed);
			
			lineDrawed.graphics.lineStyle(3,0x333333);
			
			
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
					trace("yay");
					grid.pintaElementoBarra(resultado);
					mouseLineFinish = inputManager.getMousePoint().clone();
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 , mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2);
					lineDrawed.graphics.lineTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2 + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 + deslAngularY);
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2 );
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2  , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
					lineDrawed.graphics.moveTo(mouseLineStart.x + 0.5*deslAngularY - deslAngularX/2  + deslAngularX, mouseLineStart.y - 0.5*deslAngularX - deslAngularY/2  + deslAngularY);
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 + deslAngularX , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 +  deslAngularY);
					lineDrawed.graphics.lineTo(mouseLineFinish.x - 0.5*deslAngularY - deslAngularX/2 , mouseLineFinish.y + 0.5*deslAngularX - deslAngularY/2 );
				
				}
			}
			
			
			
			
		}

	}
}