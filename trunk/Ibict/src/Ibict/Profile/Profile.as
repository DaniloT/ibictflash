package Ibict.Profile
{
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.system.System;
	
	/**
	 * Controla o "Profile" do personagem com os dados necessários assim
	 * como o "save/load" desse "profile".
	 * 
	 * @author Bruno Zumba
	 */	 
	public class Profile{
		
		/* Raiz da pasta onde estara o save */
		public static const ROOT : String = "/"
		
		/* Nome em disco do save, identificador por numeros inteiros começando pelo "0.sol" */
		private var saveID: int;
		public var name: String;
		public var points: int = 0;
		public var gameTime: int = 0;
		public var trophies : Array;
		
		/**
		 * Cria um novo perfil para o personagem
		 * 
		 * @param name Nome do personagem
		 */
		public function Profile(){			
			trophies = new Array();
		}
		
		public function create(n:String){
			name = n;
			
			saveID = getID();
		}
		
		private function getID():int{
			var continua = true;
			var so:SharedObject;
			var i : int = 0;
			while (continua){
				so = SharedObject.getLocal(i.toString(), ROOT);
				if (so.data.usado != true){
					continua = false;
				} else {
					i++;
				}
			}
			
			return (i);			
		}
		
		/**
		 * Adiciona um novo troféu ao perfil do jogador
		 * 
		 * @param c cor do troféu
		 * @param m miniGame no qual foi ganho
		 */
		public function newTrophy(color:int, minigame:String){
			var t:Trophy = new Trophy(color, minigame);
			trophies.push(t);
		}
		
		/** Salva esse perfil em disco */
		public function save(){
			var so:SharedObject;
			so = SharedObject.getLocal(saveID.toString(), ROOT);
			
			/* Salva todas as variáveis necessárias */
			so.data.usado = true;
			so.data.name = name;
			so.data.points = points;
			so.data.gameTime = gameTime;
			so.data.trophies = trophies;
			
			var flushResult:Object = so.flush();
			if ( flushResult == false){
				trace("As configurações do seu Flash Player não permitem a gravação.");
				trace("Mude as configurações para aceitar arquivos de pelo menos 100kb");
				Security.showSettings(SecurityPanel.LOCAL_STORAGE);
			} else if (flushResult == SharedObjectFlushStatus.PENDING){
				trace("É necessario mais espaço para gravar.");				
			} else if (flushResult == SharedObjectFlushStatus.FLUSHED){
				trace("Dados gravados com sucesso");
			}
		}
		
		/**
		 * Carrega para este perfil o arquivo em disco indicado pelo parametro da função
		 * 
		 * @param id Inteiro que indica o nome em disco do arquivo que deve ser carregado
		 */
		public function load(id:int){
			var so:SharedObject;
			so = SharedObject.getLocal(id.toString(), ROOT);
			
			if (so.data.usado != true){
				trace("Save inexistente");
				System.exit(0);
			}
			saveID = id;
			name = so.data.name;
			points = so.data.points;
			gameTime = so.data.gameTime;
			trophies = so.data.trophies;
		}
	}
}