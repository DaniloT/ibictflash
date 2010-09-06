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
		
		private function instanciaRoupa() : MovieClip {
			var roupa : MovieClip;
			if(GameState.profile.sexo == "M")
				roupa = new perfilMeninoRoupaLateral();
			else
				roupa = new perfilMeninaRoupaLado();
			roupa.scaleX = escala;
			roupa.scaleY = escala;
			
			roupa.x = 10;
			roupa.y = 3;
			
			roupa.gotoAndStop(GameState.profile.getRoupa())
			
			return roupa;
		}
		
		
		private function instanciaCabelo() : MovieClip {
			var cabelo : MovieClip;
			if(GameState.profile.sexo == "M") {
				cabelo = new perfilCabeloMeninoLateral();
				cabelo.y = - 8;
			} else {
				cabelo = new cabeloMeninaLado();
				cabelo.y = - 2;
				cabelo.x = 3;
			}
			
			cabelo.scaleX = escala;
			cabelo.scaleY = escala;
			
			
			cabelo.gotoAndStop(GameState.profile.getCabelo());
			
			return cabelo;
		}
		
		private function instanciaCabeca() : MovieClip {
			var cabeca : MovieClip;
			cabeca = new perfilCabecaMeninoLateral();
			
			if(GameState.profile.sexo == "M") {
				cabeca.x = 4;
			} else {
				cabeca.x = 4;
				cabeca.y = 4;
			}
			
			cabeca.scaleX = escala;
			cabeca.scaleY = escala;
			
			
			cabeca.gotoAndStop(GameState.profile.getCabeca());
			
			return cabeca;
		}
		
		
		
		private function instanciaOlho() : MovieClip {
			var olhos : MovieClip;
			olhos = new perfilMeninoOlhoLateral();
			
			olhos.scaleX = escala;
			olhos.scaleY = escala;
			
			olhos.x = 20;
			olhos.y = 7;
			
			olhos.gotoAndStop(GameState.profile.getOlho());
			
			return olhos;
		}
		
		private function instanciaOculos() : MovieClip {
			var oculos : MovieClip;
			oculos = new perfilMeninoOculosLateral();
			
			oculos.scaleX = escala;
			oculos.scaleY = escala;
			oculos.x = 5;
			oculos.y = 6;
			
			oculos.gotoAndStop(GameState.profile.getOculos());
			
			return oculos;
		}
		
		private function instanciaBracoEsquerdo() : MovieClip {
			var braco : MovieClip
			if(GameState.profile.sexo == "M") {
				braco = new slcBracoMenino();
			} else {
				braco = new slcBracoMenina();
			}
			braco = new slcBracoMenino();
					
			braco.gotoAndStop(GameState.profile.getRoupa());
			
			return braco;
		}
		
		private function instanciaBracoDireito() : MovieClip {
			var braco : MovieClip;
			
			if(GameState.profile.sexo == "M") {
				braco = new slcBracoDirMenino();
			} else {
				braco = new slcBracoDirMenina();
			}
			
			
			braco.gotoAndStop(GameState.profile.getRoupa());
			
			return braco;
		}
		
		public function determinaRoupa() {					
			
			spriteParadoDir.corpo.removeChildAt(0);
			spriteParadoDir.corpo.addChild(instanciaRoupa());
			
			spriteAndandoDir.corpo.removeChildAt(0);
			spriteAndandoDir.corpo.addChild(instanciaRoupa());
			
			spritePulandoDir.corpo.removeChildAt(0);
			spritePulandoDir.corpo.addChild(instanciaRoupa()); 
			

			
		}
		
		public function determinaCabelo() {
			
			determinaCabeca();

			spriteParadoDir.cabeca.addChild(instanciaCabelo());
			spriteAndandoDir.cabeca.addChild(instanciaCabelo());
			spritePulandoDir.cabeca.addChild(instanciaCabelo());		
			
			spriteParadoDir.cabeca.addChild(instanciaOlho());
			spriteAndandoDir.cabeca.addChild(instanciaOlho());
			spritePulandoDir.cabeca.addChild(instanciaOlho());	
			
			spriteParadoDir.cabeca.addChild(instanciaOculos());
			spriteAndandoDir.cabeca.addChild(instanciaOculos());
			spritePulandoDir.cabeca.addChild(instanciaOculos());		
			

		}
		
		
		
		public function determinaCabeca() {
			spriteParadoDir.cabeca.removeChildAt(0);
			spriteParadoDir.cabeca.addChild(instanciaCabeca());
			
			spriteAndandoDir.cabeca.removeChildAt(0);
			spriteAndandoDir.cabeca.addChild(instanciaCabeca());
			
			spritePulandoDir.cabeca.removeChildAt(0);
			spritePulandoDir.cabeca.addChild(instanciaCabeca());
			

		}
		
		public function determinaBracoEsquerdo() {
			spriteParadoDir.braco.removeChildAt(0);
			spriteParadoDir.braco.addChild(instanciaBracoEsquerdo());
			
			spriteAndandoDir.braco1.removeChildAt(0);
			spriteAndandoDir.braco1.addChild(instanciaBracoEsquerdo());
			
			spritePulandoDir.braco1.removeChildAt(0);
			spritePulandoDir.braco1.addChild(instanciaBracoEsquerdo());
		}
		
		public function determinaBracoDireito() {
			spriteAndandoDir.braco2.removeChildAt(0);
			spriteAndandoDir.braco2.addChild(instanciaBracoDireito());
			
			spritePulandoDir.braco2.removeChildAt(0);
			spritePulandoDir.braco2.addChild(instanciaBracoDireito());
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
			determinaCabelo();
			determinaBracoEsquerdo();
			determinaBracoDireito();
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
			if(orientacao == 1) {
				sprite = spriteParadoDir;
				sprite.scaleX = 1;
			}
			else { 
				sprite = spriteParadoDir;
				sprite.scaleX = -1;
			}
			
			this.addChild(sprite);
			animacao = PARADO;
		}
		
		public function setAndando() {
			this.removeChild(sprite);
			if(orientacao == 1) {
				sprite = spriteAndandoDir;
				sprite.scaleX = 1;
			} else { 
				sprite = spriteAndandoDir;
				sprite.scaleX = -1;
			}
			
			this.addChild(sprite);
			animacao = ANDANDO;
		}
		
		public function setPulando() {
			this.removeChild(sprite);
			if(orientacao == 1) {
				sprite = spritePulandoDir;
				sprite.scaleX = 1;
				
			} else {
				sprite = spritePulandoDir;
				sprite.scaleX = -1;
			}
			
			if(animacao != PULANDO)
				sprite.play();
			
			this.addChild(sprite);
			animacao = PULANDO;
		}

	}
}