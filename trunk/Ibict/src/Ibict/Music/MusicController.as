package Ibict.Music{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * Controla os canais de todos os sons (efeitos ou músicas).
	 * Esta classe é um Singleton e tentar iniciá-la mais de uma vez 
	 * ocorrerá um erro
	 * 
	 * @author Bruno Zumba
	 */
	public class MusicController{
		/* Constantes que controlam o máximo e o mínimo do 
		 * volume das músicas e sons
		 */
		public const MAX_VOL : Number = 2;
		public const MIN_VOL : Number = 0;
		
		/** Controlam o volume dos Efeitos e das Músicas do jogo */
		public static var musicVolume : Number = 0.6;
		public static var effectVolume : Number = 0.6;
		
		/** Array que guarda todos os canais de som que esta classe controla */
		public var musicChannels : Array;
		public var effectChannels : Array;
		
		private static var instance : MusicController;
		
		public function MusicController(){
			musicChannels = new Array();
			effectChannels = new Array();
			
			if (instance != null){
				throw new Error("Tried to reinstantiate singleton!");
			}
			
			MusicController.instance = this;
		}
		
		/** adiciona um novo "channel" ao array. Essa função deve ser usada
		 * somente pela função "play" da classe "Music"
		 * 
		 * @param chn O canal que será adicionado
		 * @param isEffect Indica se o canal é de Efeito ou de Música
		 * 
		 * @see Music
		 */ 
		public function addChannel(chn:SoundChannel, isEffect:Boolean){
			if (isEffect){
				effectChannels.push(chn);
			} else {
				musicChannels.push(chn);
			}
		}
		
		/**
		 * Muda o volume de uma música
		 * 
		 * @param volume Novo volume da música (0 = mudo. 1 = volume máximo)
		 */
		public function changeMusicVolume(volume:Number){
			if (volume > MAX_VOL) {
				volume = MAX_VOL;
			}
			if (volume < MIN_VOL){
				volume = MIN_VOL;
			}
			
			musicVolume = volume;
			var transform : SoundTransform = new SoundTransform(musicVolume);
			var i,total:int;
			total = musicChannels.length;
			
			for (i=0; i<total; i++){
				musicChannels[i].soundTransform = transform;
			}
		}
		
		/**
		 * Muda o volume de um efeito
		 * 
		 * @param volume Novo volume do efeito (0 = mudo. 1 = volume máximo)
		 */
		public function changeEffectVolume(volume:Number){
			if (volume > MAX_VOL) {
				volume = MAX_VOL;
			}
			if (volume < MIN_VOL){
				volume = MIN_VOL;
			}
			
			effectVolume = volume;
			var transform : SoundTransform = new SoundTransform(effectVolume);
			var i, total: int;
			total = effectChannels.length;
			
			for (i=0; i<total; i++){
				effectChannels[i].soundTransform = transform;
			}
		}
		
		public static function getInstance(){
			return instance;
		}
		

	}
}