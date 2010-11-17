package Ibict.Games.CacaPalavras
{
	import Ibict.Util.Temporizador;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class GridElement
	{
		var caractere : String;
		var usado : Boolean;
		var palavrastart : Array; 
		var palavrafim : Array;
		var palavrameio : Array;
		var pertencePalavra : Boolean;
		var brilhante : Boolean;
		var piscando : Boolean;
		
		var posx, posy : int;
		
		var gridChar : TextField;
		
		var format : TextFormat;
		var timerPiscando : Temporizador;	
		
		public function GridElement(caractere : String)
		{
			if(caractere != null) {
				this.caractere = caractere;
				this.usado = true;
			} else {
				this.usado = false;
				this.caractere = " ";
				
			}
			
			palavrastart = new Array();
			palavrafim = new Array();
			palavrameio = new Array();
			
			// é inicializado com "pertence palavra"
			// só não será palavra se for randomizado
			// o que é tratado no método randomizeChar
			pertencePalavra = true;
			
			brilhante = false;
			piscando = false;
			
			format = new TextFormat();
			format.font = "tahoma";
			format.size = 26;
			format.color = 0xFFFFFF;
			
			timerPiscando = new Temporizador();
			
		}
		
		public function addInicioPalavra(nro : int) {
			palavrastart[palavrastart.length] = nro;
		}
		
		public function addFimPalavra(nro : int) {
			palavrafim[palavrafim.length] = nro;
		}
		
		public function addPalavraMeio(nro : int) {
			palavrameio[palavrameio.length] = nro;
		}
		
		public function update(dt : int) {
			if(brilhante) {
				format.color = 0xF8F623;
				format.bold = true;
				gridChar.defaultTextFormat = format;
				
				gridChar.text = gridChar.text;
			} else if(piscando) {
				timerPiscando.start();
				
				if(timerPiscando.getCount() < 200) {
					format.color = 0xFF7900;
					format.bold = true;
					gridChar.defaultTextFormat = format;
					
					gridChar.text = gridChar.text;
					
				} else {
					format.color = 0xFFFFFF;
					format.bold = false;
					gridChar.defaultTextFormat = format;
					
					gridChar.text = gridChar.text;
				}
			}
		}
		
		public function setGridChar(gridChar : TextField) {
			this.gridChar = gridChar;
		}
		
		
		/* Atribui um caractere aleatorio da tabela ASCII para o elemento
		 * do grid */
		public function randomizeChar() 
		{
			usado = true;
			caractere = String.fromCharCode(Math.floor(Math.random() * 26) + 65);
			
			// se foi randomizado, significa que não é palavra
			pertencePalavra = false;
		}

	}
}