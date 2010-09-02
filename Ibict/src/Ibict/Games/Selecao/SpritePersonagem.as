package Ibict.Games.Selecao
{
	import Ibict.States.GameState;
	import Ibict.TextureScrollable;
	
	import flash.display.MovieClip;
	import flash.utils.ByteArray;

	
	public class SpritePersonagem extends TextureScrollable
	{
		var PARADO = 0;
		var ANDANDO = 1;
		var PULANDO = 2;
		
		var animacao;
		
		var orientacao;
		
		private var escala : Number = 0.2;
		
		var sprite : MovieClip;
		public var spriteParadoDir, spriteParadoEsq, spriteAndandoDir, spriteAndandoEsq : MovieClip;
		var spritePulandoDir, spritePulandoEsq : MovieClip;
		
		private function copyObject(obj : Object) : Object {
			var buffer : ByteArray = new ByteArray();
			buffer.writeObject(obj);
			buffer.position = 0;
			return buffer.readObject();
		}
		
		public function determinaRoupa() {
			var roupa : MovieClip;
			if(GameState.profile.sexo == "M")
				roupa = new perfilMeninoRoupaLateral();
			else
				roupa = new perfilMeninaRoupaLado();
			roupa.scaleX = escala;
			roupa.scaleY = escala;
			
			roupa.x = 10;
			roupa.y = 3;
			
			roupa.gotoAndStop(GameState.profile.getRoupa());
			
			
			spriteParadoDir.corpo.removeChildAt(0);
			spriteParadoDir.corpo.addChild(roupa);
			
			if(GameState.profile.sexo == "M")
				roupa = new perfilMeninoRoupaLateral();
			else
				roupa = new perfilMeninaRoupaLado();
			roupa.scaleX = escala;
			roupa.scaleY = escala;
			
			roupa.x = 10;
			roupa.y = 3;
			
			roupa.gotoAndStop(GameState.profile.getRoupa())
			
			spriteAndandoDir.corpo.removeChildAt(0);
			spriteAndandoDir.corpo.addChild(roupa);
			
			if(GameState.profile.sexo == "M")
				roupa = new perfilMeninoRoupaLateral();
			else
				roupa = new perfilMeninaRoupaLado();
			roupa.scaleX = escala;
			roupa.scaleY = escala;
			
			roupa.x = 10;
			roupa.y = 3;
			
			roupa.gotoAndStop(GameState.profile.getRoupa())
			
			spritePulandoDir.corpo.removeChildAt(0);
			spritePulandoDir.corpo.addChild(roupa); 
		}
		
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
			
			determinaRoupa();
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