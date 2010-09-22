package Ibict.Music{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/**
	 * Controla uma música que está aberta no jogo
	 * Os sons que serão tocados deverão ser importados para o arquivo .fla
	 * e NÃO carregados extermente.
	 * 
	 * Nesta Classe uma "Música" é considerada uma música de fundo enquanto um
	 * "Efeito" é considerado um efeito sonoro, como quando um botão é pressionado.
	 * 
	 * @author Bruno Zumba
	 */
	public class Music extends Sprite{
		
		/* Indica se o som é um efeito ou uma música de fundo */
		private var isEffect : Boolean;
		/* Indica se o som deve ser destruído após parar de tocar */
		//private var destroyAfterComplete : Boolean;
		
		/* A musica e o "channel" a qual ela esta sendo tocada */
		private var sound : Sound;
		private var channel : SoundChannel;
		
		private var musControlInstance : MusicController;
		
		/* O ponto da música no qual ela foi pausada */
		public var pausePoint : Number = 0;
		
		/* Indica se ela está tocando ou não */
		private var isPlaying : Boolean = true;
		
		/* Guarda o volume inicial de um 'Fade out' */
		private var fadeOutVolume : Number;
		
		private var ocorreFadeIn : Boolean;
		
		

		/**
		 * Cria uma nova música
		 * 
		 * @param msc A classe da musica que será tocada
		 * @param number A quantidade de vezes que era será tocada (0 = repetidamente)
		 * @param destroy Indica se o som deve ser destruído após terminar de tocar
		 */
		public function Music(snd:Sound, isEfx:Boolean, times:int/*, destroy:Boolean*/){
			sound = snd;
			isEffect = isEfx;
			//destroyAfterComplete = destroy;			
			musControlInstance = MusicController.getInstance();
			
			play(times);
		}
		
		private function play(times:int){
			ocorreFadeIn = true;
			var transform : SoundTransform = new SoundTransform();
			
			/* Ajusta o volume */
			if (isEffect){
				transform.volume = MusicController.effectVolume;
				//channel.soundTransform = transform;
			} else {
				transform.volume = 0;
			}
			
			var timer: Timer = new Timer(100, 30);
			timer.addEventListener(TimerEvent.TIMER, fadeInHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, fadeInComplete);
			isPlaying = true;
			
			if(times != -1){
				channel = sound.play(0, times, transform);
			} else {
				channel = sound.play(pausePoint);
				channel.soundTransform = transform;
			}
			timer.start();
			
			/* Adiciona o canal ao vetor de canais do MusicController e adiciona */
			musControlInstance.addChannel(channel, isEffect);
			
			channel.addEventListener(Event.SOUND_COMPLETE, completeHandler);
		}
		
		/** Continua ou pausa a música */
		public function playPause(){
			if (isPlaying){
				pausePoint = channel.position;
				channel.stop();
				isPlaying = false;
				removeChannel();
			} else {
				play(-1);
			}
		}
		
		/** Encerra a música. Colocando seu ponto de execução no início 
		 * 
		 * @param destroy Indica se é para remover o som por completo, ou apenas dar
		 * rewind na música */
		public function stop(destroy:Boolean){
			if(ocorreFadeIn) {
				channel.stop();
				completeHandler(null);
			} else {
				var timer:Timer = new Timer(100, 15);
				timer.addEventListener(TimerEvent.TIMER, fadeOutHandler);
				fadeOutVolume = channel.soundTransform.volume;
				timer.start();
			}
			
		}
		
		
		private function completeHandler(evt:Event){
			removeChannel();
			isPlaying = false;
			pausePoint = 0;
		}
		
		/* Retira o seu canal do array de canais do MusicControler */
		private function removeChannel(){
			var i,total:int;
			
			if (isEffect){
				total = musControlInstance.effectChannels.length;
				for(i=0; i<total; i++){
					if (channel == musControlInstance.effectChannels[i]){
						musControlInstance.effectChannels = musControlInstance.effectChannels.splice(i, 1);
						i = total; /*Sair do loop*/
					}
				}
			} else {
				total = musControlInstance.musicChannels.length;
				for(i=0; i<total; i++){
					if (channel == musControlInstance.musicChannels[i]){
						musControlInstance.musicChannels.splice(i, 1);
						i = total; /*Sair do loop*/
					}
				}
			}
		}
		
		/* Usado para dar o efeito de Fade In */
		private function fadeInHandler(e:TimerEvent){
			var transform : SoundTransform = new SoundTransform();
			transform.volume = channel.soundTransform.volume;
			transform.volume += 0.8/30;
			channel.soundTransform = transform;
		}
		
		private function fadeInComplete(e:TimerEvent) {
			ocorreFadeIn = false;
		}
		
		private function fadeOutHandler(e:TimerEvent){
			var transform : SoundTransform = new SoundTransform();
			transform.volume = channel.soundTransform.volume;
			transform.volume -= fadeOutVolume/15;
			channel.soundTransform = transform;
			
			/* Quando o volume já estiver em 0, destroi a música */
			if (transform.volume <= 0){
				channel.stop();			
				completeHandler(null);
			}	
		}
	}
}