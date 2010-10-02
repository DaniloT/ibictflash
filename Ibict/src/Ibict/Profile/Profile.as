package Ibict.Profile
{
	import Ibict.Profile.Data.*;
	
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
		
		/* Shared Object usado para as gravações */
		private var so : SharedObject;
		
		/* Nome em disco do save, identificador por numeros inteiros começando pelo "0.sol" */
		private var saveID: int;
		public var name: String;
		public var points: int = 0;
		public var gameTime: int = 0;
		//public var trophies : Array;
		
		public var sexo : String;
		
		/* Inteiro que indicam as peças do avatar que o jogador criou. */
		private var cabeloId;
		private var cabecaId;
		private var oculosId;
		private var olhoId;
		private var roupaId;
		private var sapatoId; 
		
		/* armazenagem dos dados que serão salvos de cada um dos jogos */
		public var selecaoColetaData : SelecaoColetaData;
		public var cacaPalavrasData : CacaPalavrasData;
		public var errosData : ErrosData;
		public var cooperativaData : CooperativaData;
		public var memoriaData : MemoriaData;
		public var quebraCabecaData : QuebraCabecaData;
		public var fabricaData : FabricaData;
		
		/**
		 * Cria um novo perfil para o personagem
		 * 
		 * @param name Nome do personagem
		 */
		public function Profile(){			
			//trophies = new Array();
			selecaoColetaData = new SelecaoColetaData();
			cacaPalavrasData = new CacaPalavrasData();
			errosData = new ErrosData();
			cooperativaData = new CooperativaData();
			memoriaData = new MemoriaData();
			quebraCabecaData = new QuebraCabecaData();
			fabricaData = new FabricaData();
		}
		
		public function create(n:String, s:String){
			name = n;
			sexo = s;
			
			saveID = getID();
		}
		
		private function getID():int{
			var continua = true;
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
		/* public function newTrophy(color:int, minigame:String){
			var t:Trophy = new Trophy(color, minigame);
			trophies.push(t);
		} */
		
		/** Salva esse perfil em disco */
		public function save(){
			so = SharedObject.getLocal(saveID.toString(), ROOT);
			
			/* Salva todas as variáveis necessárias */
			so.data.usado = true;
			
			
			salvaDadosCacaPalavras();
			salvaDadosErros();
			salvaDadosCooperativa();
			salvaDadosMemoria();
			salvaDadosQuebraCabeca();
			salvaDadosSelecaoColeta();
			salvaDadosFabrica();
			
			salvaPerfil();
			
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
			so = SharedObject.getLocal(id.toString(), ROOT);
			
			if (so.data.usado != true){
				trace("Save inexistente");
				System.exit(0);
			}
			saveID = id;
			
			carregaPerfil();
			
			carregaDadosCacaPalavras();
			carregaDadosErros();
			carregaDadosCooperativa();
			carregaDadosMemoria();
			carregaDadosQuebraCabeca();
			carregaDadosSelecaoColeta();
			carregaDadosFabrica();
		}
		
		// Grava algumas informações do perfil.
		private function salvaPerfil(){
			so.data.name = name;
			so.data.sexo = sexo;
			so.data.totalStar = getTotalStarCount();
			//so.data.trophies = trophies;
			so.data.cabeloId = cabeloId;
			so.data.cabecaId = cabecaId;
			so.data.oculosId = oculosId;
			so.data.olhoId = olhoId;
			so.data.roupaId = roupaId;
			so.data.sapatoId = sapatoId;
		}
		// Carrega algumas informações do perfil.
		private function carregaPerfil(){
			name = so.data.name;
			sexo = so.data.sexo;
			//trophies = so.data.trophies;
			cabeloId = so.data.cabeloId;
			cabecaId = so.data.cabecaId;
			oculosId = so.data.oculosId;
			olhoId = so.data.olhoId;
			roupaId = so.data.roupaId;
			sapatoId = so.data.sapatoId;
		}
		
		public function getTotalStarCount():int{
			var starCount: int = 0;
			
			starCount += cacaPalavrasData.getStarCount();
			starCount += errosData.getStarCount();
			starCount += cooperativaData.getStarCount();
			starCount += memoriaData.getStarCount();
			starCount += quebraCabecaData.getStarCount();
			starCount += selecaoColetaData.getStarCount();
			starCount += fabricaData.getStarCount();
			
			return starCount;
			
		}
		
		
		//Setters para os itens do avatar
		public function setCabelo(id:int){
			this.cabeloId = id;
		}
		public function setCabeca(id:int){
			this.cabecaId = id;
		}
		public function setOculos(id:int){
			this.oculosId = id;
		}
		public function setOlho(id:int){
			this.olhoId =id;
		}
		public function setRoupa(id:int){
			this.roupaId = id;
		}
		public function setSapato(id:int){
			this.sapatoId = id;
		}
		
		//getters para os itens do avatar
		public function getCabelo():int{
			return this.cabeloId;
		}
		public function getCabeca():int{
			return this.cabecaId;
		}
		public function getOculos():int{
			return this.oculosId;
		}
		public function getOlho():int{
			return olhoId;
		}
		public function getRoupa():int{
			return roupaId;
		}
		public function getSapato():int{
			return sapatoId;
		}
		
		/* Funções que salvam e carregam os dados de cada 
		 * jogo.
		 *
		 * Os dados devem ser salvados/carregados no "caminho" 'so.data.NomeDoMiniJogoNomeDaVariavel'
		 * conforme exemplo abaixo.
		 */
		private function salvaDadosSelecaoColeta(){
			so.data.SelecaoColetaPontuacaoColeta1 = selecaoColetaData.points[0];
			so.data.SelecaoColetaPontuacaoColeta2 = selecaoColetaData.points[1];
			so.data.SelecaoColetaPontuacaoColeta3 = selecaoColetaData.points[2];
			so.data.SelecaoColetaPontuacaoColeta4 = selecaoColetaData.points[3];
			so.data.SelecaoColetaPontuacaoColeta5 = selecaoColetaData.points[4];
			so.data.SelecaoColetaTerminouFase1 = selecaoColetaData.completed[0];
			so.data.SelecaoColetaTerminouFase2 = selecaoColetaData.completed[1];
			so.data.SelecaoColetaTerminouFase3 = selecaoColetaData.completed[2];
			so.data.SelecaoColetaTerminouFase4 = selecaoColetaData.completed[3];
			so.data.SelecaoColetaTerminouFase5 = selecaoColetaData.completed[4];
		}
		private function carregaDadosSelecaoColeta(){
			selecaoColetaData.points[0] = so.data.SelecaoColetaPontuacaoColeta1;
			selecaoColetaData.points[1] = so.data.SelecaoColetaPontuacaoColeta2;
			selecaoColetaData.points[2] = so.data.SelecaoColetaPontuacaoColeta3;
			selecaoColetaData.points[3] = so.data.SelecaoColetaPontuacaoColeta4;
			selecaoColetaData.points[4] = so.data.SelecaoColetaPontuacaoColeta5;

			selecaoColetaData.completed[0] = so.data.SelecaoColetaTerminouFase1;
			selecaoColetaData.completed[1] = so.data.SelecaoColetaTerminouFase2;
			selecaoColetaData.completed[2] = so.data.SelecaoColetaTerminouFase3;
			selecaoColetaData.completed[3] = so.data.SelecaoColetaTerminouFase4;
			selecaoColetaData.completed[4] = so.data.SelecaoColetaTerminouFase5;
			
		}
		
		/* Caça Palavras */
		private function salvaDadosCacaPalavras(){
			so.data.CacaPalavrasPontuacao1 = cacaPalavrasData.pontuacao[0];
			so.data.CacaPalavrasPontuacao2 = cacaPalavrasData.pontuacao[1];
			so.data.CacaPalavrasPontuacao3 = cacaPalavrasData.pontuacao[2];
			so.data.CacaPalavrasPontuacao4 = cacaPalavrasData.pontuacao[3];
			so.data.CacaPalavrasPontuacao5 = cacaPalavrasData.pontuacao[4];
		}
		private function carregaDadosCacaPalavras(){
			cacaPalavrasData.pontuacao[0] = so.data.CacaPalavrasPontuacao1;
			cacaPalavrasData.pontuacao[1] = so.data.CacaPalavrasPontuacao2;
			cacaPalavrasData.pontuacao[2] = so.data.CacaPalavrasPontuacao3;
			cacaPalavrasData.pontuacao[3] = so.data.CacaPalavrasPontuacao4;
			cacaPalavrasData.pontuacao[4] = so.data.CacaPalavrasPontuacao5;
		}
		
		/* Jogo dos Erros */
		private function salvaDadosErros(){
			so.data.ErrosEstrela = errosData.getStar();
			
		}
		private function carregaDadosErros(){
			errosData.setStar(so.data.ErrosEstrela);
			
		}
		
		/* Cooperativa */
		private function salvaDadosCooperativa(){
			
		}
		private function carregaDadosCooperativa(){
			
		}
		
		/* Jogo da Memória */
		private function salvaDadosMemoria(){
			
		}
		private function carregaDadosMemoria(){
			
		}
		
		/* Quebra Cabeça */
		private function salvaDadosQuebraCabeca(){
			
		}
		private function carregaDadosQuebraCabeca(){
			
		}
		
		/* Fábrica */
		private function salvaDadosFabrica(){
			
		}
		private function carregaDadosFabrica(){
			
		}
		
		
		
	}
}