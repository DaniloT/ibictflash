package Ibict.States
{
	import Ibict.InputManager;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	
	/**
	 * Classe que monta uma mensagem em uma caixa de diálogo.
	 * Essa caixa de dialogo pode possuir 1 ou 2 botões. ("OK" e "Cancel" ou apenas "OK", por exemplo)
	 * 
	 * @author Bruno Zumba
	 */
	 
	 /*import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;*/
	
	/*Sempre que o flash atualiza sozinho essa lista de importação,
	ele substitui as importações de Tween por uma importação do pacote
	"mx" ou deixa só a importação do ...easing.* 
	Sempre que isso acontecer, copie as tres importações comentadas acima e subsitua*/
	
	public class Message extends MovieClip{
		/* Posicoes iniciais e finais da caixa de mensagem na tela. */
		private const POS_X_INICIO : int = 0;
		private const POS_X_FIM: int = 0;
		private const POS_Y_INICIO : int = 750;
		private const POS_Y_FIM: int = 450;
		/* caixa de dialogo */
		public var msgBox : messageBox = new messageBox();
		
		/* Posicao dos botoes dentro da caixa de dialogo*/
		private const OKBTPOS : Point = new Point(590, 15);
		private const CANCELBTPOS : Point = new Point(590, 80);
		private const ONEBTPOS : Point = new Point(590, 50);
		/* Tempo, em milissegundos, antes de apagar algumas mensagens que sumirão sozinhas */
		private const TIMEOUT : int = 5000;
		
		private var okBt : messageBoxBt = new messageBoxBt();
		private var cancelBt : messageBoxBt = new messageBoxBt();
		
		/* Root a qual a mensagem será subordinada (do gameState) */
		private var root_g : MovieClip;
		/* tempo inicial, usado como referencia para quando a mensagem deve sumir sozinha */
		private var inicial : int;
		
		/**
		 * Cria uma caixa de diálogo
		 * 
		 * @param msg A mensagem que será exibida.
		 * @param pos A posição na tela que a caixa aparecerá.
		 * @param hasOk Se possui botão de "Ok".
		 * @param okText O texto que aparecerá no botão (Ex.: Ok, Aceitar, etc).
		 * @param hasCancel Se possui o botão de "Cancelar".
		 * @param cancelText O texto que aparecerá no botão (Ex.: Cancela, Ignorar, etc).
		 * @param willVanish Indica se a mensagem será destruída sozinha depois de um terminado tempo.
		 * @param rt Raiz da árvore de gráficos no qual a mensagem será adicionada/retirada
		 */
		public function Message(msg:String, pos:Point, hasOk:Boolean, okText:String, 
		hasCancel:Boolean, cancelText:String, willVanish:Boolean, rt:MovieClip, cursor:MovieClip){
			
			root_g = rt;
			
			/*Monta a mensagem*/
			msgBox.texto.text = msg;
			msgBox.x = POS_X_INICIO;
			msgBox.y = POS_Y_INICIO;
			
			/*Monta os botoes da caixa de mensagem, se houver*/
			if(hasOk){
				okBt.texto.text = okText;
				msgBox.addChild(okBt);
				if(hasCancel){
					okBt.x = OKBTPOS.x;
					okBt.y = OKBTPOS.y;
					
					cancelBt.name = "lala";
					cancelBt.texto.text = cancelText;
					cancelBt.x = CANCELBTPOS.x;
					cancelBt.y = CANCELBTPOS.y;
					msgBox.addChild(cancelBt);
				} else {
					okBt.x = ONEBTPOS.x;
					okBt.y = ONEBTPOS.y;
				}
			}
			
			/* adiciona a caixa de dialogo ao root */
			root_g.addChild(msgBox);
			root_g.swapChildren(msgBox, cursor);
			/* Faz a mensagem deslizar pra cima, aparecendo na tela. */
			mostrarMsg();
			 
			
			/* Inicia a contagem de tempo e faz o controle quando a mensagem deve sumir sozinha*/
			if(willVanish){
				inicial = getTimer();
				root_g.addEventListener(Event.ENTER_FRAME, vanishHandler);
			}
			
		}
		
		private function mostrarMsg(){
			var tween : Tween = new Tween(msgBox, "y", Regular.easeOut, POS_Y_INICIO, POS_Y_FIM, 0.5, true);
			tween.addEventListener(TweenEvent.MOTION_FINISH, mostraTrace);
		}
		private function mostraTrace(evt:TweenEvent){
			trace("terminou de subir");
		}
		
		private function vanishHandler(evt: Event){
			var atual : int = getTimer();
			
			if((atual - inicial) > 5000){
				root_g.removeEventListener(Event.ENTER_FRAME, vanishHandler);
				destroy();
			}
		}
		
		/**
		 * Checa se o botao de Ok foi pressionado
		 * 
		 * @return Booleano informando o clique
		 */
		public function okPressed():Boolean{
			var input : InputManager = InputManager.getInstance();
			
			if((input.mouseClick()) && (input.getMouseTarget() == okBt.bt)){
				return true;
			} 
			return false
		}
		
		/**
		 * Checa se o botao de cancelar foi pressionado
		 * 
		 * @return Booleano informando o clique
		 */ 
		public function cancelPressed():Boolean{
			var input : InputManager = InputManager.getInstance();
			
			if((input.mouseClick()) && (input.getMouseTarget() == cancelBt.bt)){
				return true;
			}
			return false;
		}

		/**
		 * Destroi a mensagem.
		 */
		public function destroy(){
			var tween : Tween = new Tween(msgBox, "y", Regular.easeOut, msgBox.y, POS_Y_INICIO, 0.5, true);
			tween.addEventListener(TweenEvent.MOTION_FINISH, destroyAux);
			//tween.start();
		}
		private function destroyAux(evt:TweenEvent){
			trace("terminou de descer");
			/*Talvez apresente uma animação que esteja no movieClip do .fla*/
			if(root_g.contains(msgBox)){
				root_g.removeChild(msgBox);
			}
		}
	}
}