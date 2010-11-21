package Ibict.Profile
{
	import Ibict.InputManager;
	import Ibict.Main;
	import Ibict.States.GameState;
	import Ibict.States.State;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.ui.Mouse;
	
	
	/**
	 * Controla a tela de Load do Jogo
	 * 
	 * @author Bruno Zumba
	 */
	public class LoadState extends State{
		private const SAVESPERPAGE = 3;
		
		private var fundoSemGlass : MovieClip;
		private var fundoCima : MovieClip;
		private var alpha : Number;
		
		/* Array que vai armazenar tds os saves */
		private var saves : Array; //Armazena tds os saves que estao em disco
		private var sv: Save; //auxiliar para ajudar a manipular os saves
		private var savesCP : Array = new Array(SAVESPERPAGE); //Armazena os saves que estao na "currentPage" 
		
		private var totalPages : int;
		private var currentPage : int = 1;
		/* Variavel que determinar o que acontece quando o jogador clica em um save
		(carregar o save, ou deleta-lo, caso o jogador tenha clicado antes no botao "delete" */
		private var deletar : Boolean = false;
		
		/*Botao que cria 3 saves. Feito apenas para testes*/
		//private var criaSave : ldCriaSaveBt = new ldCriaSaveBt();
		
		/* Pontos onde estara cada elemento da pagina de save (3 saves por pagina)*/
		private var savePt : Array = new Array(SAVESPERPAGE);
		private const save1Pt : Point = new Point(163, 27);
		private const save2Pt : Point = new Point(163, 197);
		private const save3Pt : Point = new Point(163, 370);
		private const prevPt: Point = new Point(37, 266);
		private const nextPt: Point = new Point(682, 266);
		private const backPt: Point = new Point(72, 532);
		private const delPt: Point = new Point(580, 532);
		
		private var  prev : ldPrevPage = new ldPrevPage();
		private var next : ldNextPage = new ldNextPage();
		private var back : ldBackBt = new ldBackBt();
		private var del : ldDeleteBt = new ldDeleteBt();
		
		private var mainInstance : Main;
		
		/* Cursor do mouse. E publico pois o input manager deve conseguir
		modifica-lo */
		public static var myCursor : ldCursor;		
		
		public function LoadState(){
			mainInstance = Main.getInstance();
			root = new MovieClip();
			
			//myCursor =  new ldCursor();
			
			fundoSemGlass = new mainMenuFundoSemGlass();
			fundoCima = new mainMenuFundoSemGlass();

			savePt[0] = save1Pt;
			savePt[1] = save2Pt;
			savePt[2] = save3Pt;
		}
		
		public override function assume(previousState : State) {
			deletar = false;
			del.gotoAndStop(1);
			currentPage = 1;
			
			root.addChild(fundoSemGlass);
			//root.addChild(myCursor);
			
			//Mouse.hide();
			/* myCursor.visible = false;
			myCursor.x = Main.WIDTH/2;
			myCursor.y = Main.HEIGHT/2; */
			
			alpha = 1;
			fundoCima.x = 0;
			fundoCima.alpha = 1;
			
			if (previousState != null){
				mainInstance.stage.removeChild(previousState.getGraphicsRoot());
			}
			
			mainInstance.stage.addChild(this.root);
			
			loadSaveArray();
			displayLayout();
			displaySaves();
			root.addChild(fundoCima);
		}
		
		public override function leave(){
			Mouse.show()
		}
		
		public override function enterFrame(e : Event){
			var i:int;
			var input : InputManager = InputManager.getInstance();
			
			alpha -= 0.1;
			if(alpha < 0) {
				alpha = 0;	
				fundoCima.x = 1200;
			}
			fundoCima.alpha = alpha;
			
			//trace("CP: "+currentPage);
			if(input.mouseClick()) {
				/*Testa se o jogador clicou em algum save*/
				for (i=0; i < savesCP.length; i++){
					if (input.getMouseTarget() == savesCP[i].mc.cover){
						if (deletar){
							var indice:int = (currentPage-1)*SAVESPERPAGE;
							deleteSave(i+indice);
							deletar = false;
							del.gotoAndStop(1);
						}else{
							//trace("Carregou save: "+(i+(currentPage-1)*SAVESPERPAGE));
							GameState.profile.load(i+(currentPage-1)*SAVESPERPAGE);
							mainInstance.setState(Main.ST_GAME);
						}
					}
				}
				
				/*Testa se o jogador clicou em algum botao da tela de load*/
				if(input.getMouseTarget() == next){
					if (currentPage != totalPages){
						currentPage++;
						displaySaves();
					}
				}
				
				else if (input.getMouseTarget() == prev){
					if (currentPage != 1){
						currentPage--;
						displaySaves();
					}
				}
				
				else if (input.getMouseTarget() == back){
					Main.getInstance().setState(Main.ST_MENU);
				}
				
				else if (input.getMouseTarget() == del){
					/*Toggle a var "deletar"*/
					if(deletar == false){
						deletar = true;
						del.gotoAndStop(2);
					}else{
						deletar = false;
						del.gotoAndStop(1);
					}
				}
				/*Apenas para testes: qnd aperta espaço adiciona 3 saves*/
				/* else if (input.getMouseTarget() == criaSave){
					newSave1();
					newSave2();
					totalPages = Math.ceil(saves.length / 3);
					displaySaves();
				} */
			}
			
			
			/* Atualiza a posicao do mouse na tela */
			/* myCursor.x = input.getMousePoint().x;
			myCursor.y = input.getMousePoint().y; */
			
			/*Seta a visibilidade do cursor*/
			//myCursor.visible = input.isMouseInside();
		}
		
		/* faz aparecer a informacao dos saves */
		private function displaySaves():void{
			var i, total, inicio : int;
			inicio = (currentPage-1)*SAVESPERPAGE ;
			
			/* Retira da tela os saves que estao lah*/
			for( i = 0; i< savesCP.length;i++){
				if(savesCP[i] != null){
					root.removeChild(savesCP[i].mc);
				}
			}
			
			savesCP = saves.slice(inicio, inicio+SAVESPERPAGE);
			
			/*Se, ao deletar um save, uma pagina ficar vazia (esse save for o ultima desta
			pagina), retorna a pagina anterior*/
			if((savesCP.length == 0) && (currentPage > 1)){
				currentPage--;
				inicio = (currentPage-1)*SAVESPERPAGE ;
				savesCP = saves.slice(inicio, inicio+SAVESPERPAGE);
			}

			/*Mostra na tela os dados dos saves*/
			for (i = 0; i<savesCP.length; i++){
				sv = savesCP[i];
				if (sv.so.data.usado != undefined){
					sv.mc.x = savePt[i].x;
					sv.mc.y = savePt[i].y;
					root.addChild(sv.mc);
					/* linha necessaria para que o cursor do mouse nao fique atras dos outros elementos */
					//root.swapChildren(sv.mc, myCursor);
				} else {
					trace("Não deveria ter entrado aqui");
				}
			}
		}
		
		/* faz aparecer os elementos graficos (botoes, figura de fundo, armacao, etc) */
		private function displayLayout():void{
			if (saves.length > SAVESPERPAGE) {
				prev.x = prevPt.x;
				prev.y = prevPt.y;
				root.addChild(prev);
				//root.swapChildren(prev, myCursor);
				
				next.x = nextPt.x;
				next.y = nextPt.y;
				root.addChild(next);
				//root.swapChildren(next, myCursor);
			}
			
			del.x = delPt.x;
			del.y = delPt.y;
			root.addChild(del);
			//root.swapChildren(del, myCursor);
			
			back.x = backPt.x;
			back.y = backPt.y;
			root.addChild(back);
			//root.swapChildren(back, myCursor);
			
			/* criaSave.x = 315;
			criaSave.y = 500;
			root.addChild(criaSave);
			root.swapChildren(criaSave, myCursor); */
			
		}
		
		/* Funcao que le os saves em disco e preenche o array "saves" */
		private function loadSaveArray():void{
			var sair:Boolean = false;
			var i:int = 0;
			saves = new Array();
			
			while (!sair){
				sv = new Save(i.toString());
				if (sv.so.data.usado != undefined){
					i++;
					saves.push(sv);
				}else{
					sair = true;
				}
			}
			totalPages = Math.ceil(saves.length / 3);
		}
		
		public static function getSaveCount() : int {
			var sair:Boolean = false;
			var i : int = 0;
			var so : SharedObject;
			
			while (!sair){
				 so = SharedObject.getLocal(i.toString(), Profile.ROOT);
				if (so.data.usado != undefined){
					i++;
				}else{
					sair = true;
				}
			}
			
			return i;
		
		}
		
		private function save(obj:SharedObject):void{
			/* Ajeita as variaveis que tiverem que tiverem q ser setadas*/
			var flushResult:Object = obj.flush();
			if ( flushResult == false){
				trace("As configurações do seu Flash Player nao permitem a gravação.");
				trace("Mude as configurações para aceitar arquivos de pelo menos 100kb");
				Security.showSettings(SecurityPanel.LOCAL_STORAGE);
			} else if (flushResult == SharedObjectFlushStatus.FLUSHED){
				//trace("Dados gravados com sucesso");
			} else if (flushResult == SharedObjectFlushStatus.PENDING){
				trace("É necessario mais espaço para gravar.");				
			}
		}
		
		/* Cria um "novo arquivo" de save. SOH PARA TESTE */
		private function newSave1():void{
			var i : int;
			i = saves.length;
			sv = new Save(i.toString());
			sv.so.data.usado = true;
			sv.so.data.name = "a";
			sv.so.data.points = 1;
			sv.so.data.gameTime = 1000;
			saves.push(sv);
			save(sv.so);
			sv.setaMC();
		}private function newSave2():void{
			var i : int;
			i = saves.length;
			sv = new Save(i.toString());
			sv.so.data.usado = true;
			sv.so.data.name = "b";
			sv.so.data.points = 2;
			sv.so.data.gameTime = 2000;
			saves.push(sv);
			save(sv.so);
			sv.setaMC();
		}private function newSave3():void{
			var i : int;
			i = saves.length;
			sv = new Save(i.toString());
			sv.so.data.usado = true;
			sv.so.data.name = "c";
			sv.so.data.points = 3;
			sv.so.data.gameTime = 3000;
			saves.push(sv);
			save(sv.so);
			sv.setaMC();
		}
		
		/*Deleta o save que esta no vetor "saves" na posicao "indice" (saves[indice])*/
		private function deleteSave(indice:int):void{
			var i:int;
			var variable : Object;
			
			/* trasnfere os dados do sharedObject i+i para o SO i*/
			for(i=indice; i<saves.length-1; i++){
				for (variable in saves[i].so.data){
					saves[i].so.data[variable] = saves[i+1].so.data[variable];
				}
				save(saves[i].so);
				saves[i].setaMC();
			}

			/*Elimina o ultimo SO do disco e o apaga do vetor "saves"*/
			saves[i].so.clear();
			saves.pop();
			
			totalPages = Math.ceil(saves.length / 3);
			
			if (saves.length <= SAVESPERPAGE) {
				if (root.contains(prev)){
					root.removeChild(prev);
				}
				
				if (root.contains(next)){				
					root.removeChild(next);
				}
			}
			
			if (saves.length == 0){
				Main.getInstance().setState(Main.ST_MENU);
			}
			displaySaves();
		}
	}
}