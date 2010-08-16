
package Ibict.Games.CacaPalavras
{
	public class BancoPalavras
	{
		private var selecionadas : Array;
		
		public var faceis : Array =
		["ar",           "Aquilo que respiramos",
		"flora",        "Conjunto de táxons de\nplantas de uma região",
		"reciclar",     "Precisamos dividir o lixo para depois r_____",
		"energia",      "Deixar a TV ligada\nsem ninguém assistindo \ndesperdício de en______",
		"consciência",  "Para preservarmos o\nambiente, é preciso con________",
		"desperdício",  "Banhos longos são um\ndes_______ de água",
		"economia",     "É importante que façamos uma eco_____ de energia",
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
		"ciclo",        "O cic____ de vida é o conjunto\nde transformações que indivíduos\n passam para assegurar\nsua continuidade"
		"responsabilidade", "O eq_______ ambiental dos\n ecossistemas envolve a fauna e a flora\n estabilizadas"
		"fauna",        "Conjunto de animais de uma\ndeterminada espécie",
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
		"extinção"      "Devemos salvar os animais em ex______."
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
		"eólica",       "Energia provida\npela força dos ventos.",
		"agrotóxico",   "Defensivo agrícola",
		"queimada",     "Limpeza do terreno com uso\n de fogo de forma controlada."
		"pecuária",     "Conjunto de técnicas para\n domesticação e criação de animais\ncom objetivos econômicos",
		"contaminação", "É necessário cuidado com a c_____\n de alimentos devido a poluição",
		"ecossistema",  "Sistema onde se vive"
		];
		
		public function selectWords(nfaceis : int, nmedias : int, ndificeis : int) {
			var i, j : int;
			selecionadas = new Array(faceis + medias + dificeis);
			
			if(nfaceis > faceis.length) nfaceis = faceis.length;
			if(nmedias > medias.length) nmedias = medias.length;
			if(ndificeis > dificeis.length) ndificeis = dificeis.length;
			

			// selecionando as faceis
			var numbers : Array;
			numbers = new Array(faceis.length);
			
			for(i = 0; i < faceis.length; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < nfaceis; i++) {
				var random : int;
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadas.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
			
			
			numbers = new Array(medias.length);
			
			for(i = 0; i < medias.length; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < nmedias; i++) {
				var random : int;
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadas.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
			
			numbers = new Array(dificeis.length);
			
			for(i = 0; i < dificeis.length; i++) {
				numbers[i] = i;
			}
			
			for(i = 0; i < ndificeis; i++) {
				var random : int;
				
				random = Math.floor(Math.random()*numbers.length);
				selecionadas.push(numbers[random]);
				numbers.splice(random, 1);
				
			}
				
		}
		
		public function BancoPalavras()
		{
			
		}

	}
}