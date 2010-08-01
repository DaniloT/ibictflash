package Ibict.Profile{	
	import flash.display.Sprite;
	import flash.net.SharedObject;
	/**
	 * Controla um único arquivo de Save
	 * 
	 * @author Bruno Zumba
	 */
	public class Save extends Sprite{
		/** MovieClip que mostrará alguns dados do save na tela */
		public var mc : ldSaveInfo;
		/** SharedObject que intermediará o acesso ao save com o disco */
		public var so : SharedObject;
		
		/**
		 * Cria uma nova instância para controlar um arquivo em disco
		 * 
		 * @param str Nome do arquivo em disco que esta instância controlará
		 */
		public function Save(str:String){
			so = SharedObject.getLocal(str, Profile.ROOT);
			mc = new ldSaveInfo();
			
			if (so.data.usado != undefined){
				setaMC();
			}
		}
		
		/** Controla o que aparecá na tela com os dados desse arquivo */
		public function setaMC(){
			mc.svName.text = so.data.name;
			mc.svGameTime.text = so.data.gameTime;
			mc.svPoints.text = so.data.points;
		}

	}
}