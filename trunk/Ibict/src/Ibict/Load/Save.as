package Ibict.Load
{	
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.text.TextField;
	
	public class Save extends Sprite{
		public var mc : ldSaveInfo;
		public var so : SharedObject;
		
		public function Save(str:String){
			so = SharedObject.getLocal(str, "/");
			mc = new ldSaveInfo();
			
			if (so.data.usado != undefined){
				setaMC();
			}
		}
		
		public function setaMC(){
			mc.svName.text = so.data.name;
			mc.svLevel.text = so.data.level;
			mc.svPoints.text = so.data.points;
		}

	}
}