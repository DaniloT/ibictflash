
package Ibict.Games.CacaPalavras
{
	public class BancoPalavras
	{
		private var selecionadasFaceis, selecionadasMedias, selecionadasDificeis : Array;
		var total, nfaceis, nmedias, ndificeis : int;
		
		public var faceis : Array =
		["ar",           "Aquilo que respiramos",
		"flora",        "Conjunto de táxons de\nplantas de uma região",
		"reciclar",     "Precisamos dividir o \nlixo para depois r_____",
		"energia",      "Deixar a TV ligada\nsem ninguém assistindo \ndesperdício de en______",
		"consciência",  "Para preservarmos o\nambiente, é preciso con________",
		"desperdício",  "Banhos longos são um\ndes_______ de água",
		"economia",     "É importante que façamos\n uma eco_____ de energia",
		"terra",        "È necessário que\n nos preocupemos com\n a nossa mãe Te____",
		"vida",         "Preservar o ambiente\né cuidar de nossa v___",
		"árvores",      "Plantar ar_____\n é uma atitude muito boa",
		"doce",         "Vivemos em um mundo\n com mais água _____\n do que salgada",
		"reduzir",      "Precisamos r_____\no uso de energia",
		"mobilização",  "É necessária mob______\n das pessoas para a\npreservação ambiental",
		"natureza",     "A nat_____ precisa ser preservada",
		"planeta",      "Nosso pl_____ precisa ser salvo!",
		"desmatamento", "O des____ está acabando\ncom nossas árvores",
		"poluição",     "A pol____ é uma característica\n de cidades grandes",
		"cidades",      "Nas cid__ grandes, há\nmuita poluição",
		"educação",     "É preciso que todos\ntenham ed_____ ambiental",
		"consumo",      "O con____ de energia\ndeve ser evitado"];
		
		public var medias : Array =
		[
		"ciclo",        "O cic____ de vida é o conjunto\nde transformações que\n indivíduos passam para assegurar\nsua continuidade",
		"responsabilidade", "O eq_______ ambiental dos\n ecossistemas envolve a fauna e\na flora estabilizadas",
		"fauna",        "Conjunto de animais de\numa determinada espécie",
		"seletiva",     "Cada lixo tem um tipo,\n por isso é importante realizar\na coleta _______.",
		"papel",        "O pap_____ é um material reciclável",
		"repensar",     "Devemos rep_____ nossas ações\n ambientais",
		"estufa",       "O acúmulo de gás carbônico\nna atmosfera gera efeito _____.",
		"reparar",      "Arranjar ou consertar objetos.",
		"reutilizar",   "Ao invés de jogar fora,\né melhor r_______.",
		"semente",      "Utilizada para plantar.",
		"resíduos",     "Restos.",
		"embalagens",   "As emb____ dos produtos devem\nser ecologicamente corretas.",
		"solar",        "Energia _____ é aquela\nvinda do sol",
		"planta",       "O resultado de uma plantação.",
		"extinção",      "Devemos salvar os animais\n em ex______."
		];
		
		public var dificeis : Array =
		[
		"chorume",      "Líquido poluente, de cor escura e odor nauseante",
		"ozônio",       "A poluição está causando\nburacos na camada de ______.",
		"clima",        "Tempo metereológico médio",
		"cristal",      "Material brilhante não\nreciclável.",
		"lâmpada",      "Ilumina a casa, e não é\nreciclável.",
		"jornal",       "Fornece notícias, e é\nreciclável.",
		"leis",         "Regulamentações",
		"repor",        "Recolocar.",
		"eólica",       "Energia provida\npela força\n dos ventos.",
		"agrotóxico",   "Defensivo agrícola",
		"queimada",     "Limpeza do terreno com uso\n de fogo de forma controlada.",
		"pecuária",     "Conjunto de técnicas para\n domesticação e criação de\nanimaiscom objetivos econômicos",
		"contaminação", "É necessário cuidado com a \nc_____ de alimentos devido a\npoluição",
		"ecossistema",  "Sistema onde se vive"
		];
		
		public function getWords() : Array {
			var array : Array;
			var i : int;
			array = new Array(0);
			
			
			for(i = 0; i < selecionadasFaceis.length; i++) {
				array.push(faceis[selecionadasFaceis[i]*2]);
			}
			
			for(i = 0; i < selecionadasMedias.length; i++) {
				array.push(medias[selecionadasMedias[i]*2]);
			}
			
			for(i = 0; i < selecionadasDificeis.length; i++) {
				array.push(dificeis[selecionadasDificeis[i]*2]);
			}
			
			return array;
				
		}
		
		public function getHints() : Array {
			var array : Array;
			var i : int;
			array = new Array(0);
			
			for(i = 0; i < selecionadasFaceis.length; i++) {
				array.push(faceis[selecionadasFaceis[i]*2 + 1]);
			}
			
			for(i = 0; i < selecionadasMedias.length; i++) {
				array.push(medias[selecionadasMedias[i]*2 + 1]);
			}
			
			for(i = 0; i < selecionadasDificeis.length; i++) {
				array.push(dificeis[selecionadasDificeis[i]*2 + 1]);
			}
			
			return array;
		}
		
		public function selectWords(nfaceis : int, nmedias : int, ndificeis : int) {
			var i, j : int;
			
			
			this.total = nfaceis + nmedias + ndificeis;
			
			
			
			if(nfaceis > faceis.length/2) nfaceis = faceis.length/2;
			if(nmedias > medias.length/2) nmedias = medias.length/2;
			if(ndificeis > dificeis.length/2) ndificeis = dificeis.length/2;
			
			this.ndificeis = ndificeis;
			this.nfaceis = nfaceis;
			this.nmedias = nmedias;
			
			selecionadasFaceis = new Array();
			selecionadasMedias = new Array();
			selecionadasDificeis = new Array();
			

			// selecionando as faceis
			var numbers : Array;
			var random : int;
			numbers = new Array(faceis.length/2);
			
			for(i = 0; i < faceis.length/2; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < nfaceis; i++) {
				
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadasFaceis.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
			
			
			numbers = new Array(medias.length/2);
			
			for(i = 0; i < medias.length/2; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < nmedias; i++) {
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadasMedias.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
			
			numbers = new Array(dificeis.length/2);
			
			for(i = 0; i < dificeis.length/2; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < ndificeis; i++) {
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadasDificeis.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
			
			trace("faceis");
			trace(selecionadasFaceis);
			trace("medias");
			trace(selecionadasMedias);
			trace("dificeis");
			trace(selecionadasDificeis);
				
		}
		
		public function BancoPalavras()
		{
			
		}

	}
}