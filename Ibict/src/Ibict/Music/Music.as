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
		/* Indica a quantidade de tempo para esperar entre uma 
		 * uma chamada das funções de fade-in e fade-out (em milissegundos) */
		private const INTERVALO : int = 100;
		 /* O quanto um som aumenta ou diminui a cada vez que entrar
		  * em uma função de fade-in ou fade-out */
		private const FADE_RATE : Number = 0.05;
		
		/* Estado quando o som está tocando */
		private const ST_PLAYING : int = 0; 
		/* Estado quando o som está pausado */
		private const ST_PAUSED : int = 1;
		/* Estado quando o som está em Fade-in */
		private const ST_FADING_IN : int = 2;
		/* Estado quando o som está em Fade-out */
		private const ST_FADING_OUT : int = 3;
		
		/* Variavél que guarda o estado atual do som */
		private var state : int;
		
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
		
		/* Timer usados para fade-in e fade-out.
		 * São necessários para poder usar "removeEventListener" quando
		 * um dos "fades" forem cancelados */
		private var timerFadeIn : Timer;
		private var timerFadeOut : Timer;
		
		/* Quando a música faz fade-out, indica se é para dar
		 * "pause" ou "stop" na música */
		private var isPause : Boolean;
				

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
			
			timerFadeIn = new Timer(INTERVALO);
			timerFadeOut = new Timer(INTERVALO);
			
			play(times);
		}
		
		private function play(times:int){
			var transform : SoundTransform = new SoundTransform();
			
			/* Ajusta o volume */
			if (isEffect){
				transform.volume = MusicController.effectVolume;
				//channel.soundTransform = transform;
			} else {
				transform.volume = 0;
			}
			
			if(times != -1){
				channel = sound.play(0, times, transform);
			} else {
				channel = sound.play(pausePoint);
				channel.soundTransform = transform;
			}
			fadeIn();
			
			/* Adiciona o canal ao vetor de canais do MusicController e adiciona */
			musControlInstance.addChannel(channel, isEffect);
			
			channel.addEventListener(Event.SOUND_COMPLETE, fadeOutComplete);
		}
		
		/** Continua ou pausa a música */
		public function playPause(){
			switch(state){
				case ST_PLAYING:
					isPause = true;
					fadeOut();
				break;
				case ST_PAUSED:
					play(-1);
				break;
				case ST_FADING_IN:
					fadeOut();
				break;
				case ST_FADING_OUT:
					fadeIn();
				break;
			}
		}
		
		/* gerencia o fade in do som */
		private function fadeIn(){
			state = ST_FADING_IN;
			timerFadeOut.removeEventListener(TimerEvent.TIMER, fadeOutHandler);
			var qtd : int = Math.floor(Math.abs(MusicController.musicVolume - channel.soundTransform.volume) / FADE_RATE);			
			timerFadeIn = new Timer(INTERVALO, qtd);
			timerFadeIn.addEventListener(TimerEvent.TIMER, fadeInHandler);
			timerFadeIn.addEventListener(TimerEvent.TIMER_COMPLETE, fadeInComplete);
			timerFadeIn.start();
		}
		/* gerencia o fade out do som */
		private function fadeOut(){
			state = ST_FADING_OUT;
			timerFadeIn.removeEventListener(TimerEvent.TIMER, fadeInHandler);
			timerFadeIn.removeEventListener(TimerEvent.TIMER_COMPLETE, fadeInComplete);
			var qtd : int = Math.floor(channel.soundTransform.volume / FADE_RATE);
			timerFadeOut = new Timer(INTERVALO, qtd);
			timerFadeOut.addEventListener(TimerEvent.TIMER, fadeOutHandler);
			timerFadeOut.start();
		}
		
		/** Encerra a música. Colocando seu ponto de execução no início 
		 * TODO: Acho que esse parâmetro é inútil. Analisar depois.
		 * 
		 * @param destroy Indica se é para remover o som por completo, ou apenas dar
		 * rewind na música */
		public function stop(destroy:Boolean){
			isPause = false;
			fadeOut();
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
			transform.volume += FADE_RATE;
			channel.soundTransform = transform;
		}
		
		private function fadeOutHandler(e:TimerEvent){
			var transform : SoundTransform = new SoundTransform();
			transform.volume = channel.soundTransform.volume;
			transform.volume -= FADE_RATE;
			channel.soundTransform = transform;
			
			/* Quando o volume já estiver em 0, destroi a música */
			if (transform.volume <= 0){
				fadeOutComplete(null);
			}
		}
		
		private function fadeOutComplete(evt:Event){
			channel.stop();
			isPlaying = false;
			state = ST_PAUSED;
			if(isPause){
				pausePoint = channel.position;
			} else {
				removeChannel();
				pausePoint = 0;
			}
		}
		
		private function fadeInComplete(evt:TimerEvent){
			state = ST_PLAYING;
		}
	}
}