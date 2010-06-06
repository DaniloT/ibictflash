package Ibict.Games.Selecao
{
	import Ibict.TextureScrollable;
	
	import flash.display.MovieClip;
	
	public class SpritePersonagem extends TextureScrollable
	{
		var PARADO = 0;
		var ANDANDO = 1;
		var PULANDO = 2;
		
		var animacao;
		
		var orientacao;
		
		var sprite : MovieClip;
		var spriteParadoDir, spriteParadoEsq, spriteAndandoDir, spriteAndandoEsq : MovieClip;
		var spritePulandoDir, spritePulandoEsq : MovieClip;
		
		public function SpritePersonagem()
		{
			orientacao = 1;
			animacao = 0;
			
			
			spriteParadoDir = new selectSpriteParadoDir();
			spriteParadoEsq = new selectSpriteParadoEsq();
			spriteAndandoDir = new selectSpriteAndandoDir();
			spriteAndandoEsq = new selectSpriteAndandoEsq();
			spritePulandoDir = new selectSpritePulandoDir();
			spritePulandoEsq = new selectSpritePulandoEsq();
			
			sprite = spriteParadoDir;
			
			this.addChild(sprite);
		}
		
		public function setDireita() {
			orientacao = 1;
			reset();
		}
		
		public function setEsquerda() {
			orientacao = -1;
			reset();
		}
		
		public function reset() {
			switch(animacao) {
				case PARADO:
					setParado();
				break;
				case ANDANDO:
					setAndando();
				break;
				case PULANDO:
					setPulando();
				break;
			}
		}
		
		public function setParado() {
			this.removeChild(sprite);
			if(orientacao == 1) 
				sprite = spriteParadoDir;
			else 
				sprite = spriteParadoEsq;
			
			this.addChild(sprite);
			animacao = PARADO;
		}
		
		public function setAndando() {
			this.removeChild(sprite);
			if(orientacao == 1) 
				sprite = spriteAndandoDir;
			else 
				sprite = spriteAndandoEsq;
			
			this.addChild(sprite);
			animacao = ANDANDO;
		}
		
		public function setPulando() {
			this.removeChild(sprite);
			if(orientacao == 1) {
				sprite = spritePulandoDir;
				
			} else {
				sprite = spritePulandoEsq;
			}
			
			if(animacao != PULANDO)
				sprite.play();
			
			this.addChild(sprite);
			animacao = PULANDO;
		}

	}
}