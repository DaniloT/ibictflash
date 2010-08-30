package Ibict.Games.Cooperativa
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Cooperativa extends MovieClip
	{
		/* Fundo do jogo. */
		public var fundo : MovieClip;

		public function Cooperativa(imgNum:int){

			fundo = new CooperativaFundo;
						
		}
	}
}