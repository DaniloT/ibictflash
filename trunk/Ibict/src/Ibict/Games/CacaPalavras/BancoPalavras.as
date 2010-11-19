
package Ibict.Games.CacaPalavras
{
	public class BancoPalavras
	{
		private var selecionadasFaceis, selecionadasMedias, selecionadasDificeis : Array;
		var total, nfaceis, nmedias, ndificeis : int;
		
		/*
		public var faceis : Array =
		["ar",           "Mistura de gases que compõem a atmosfera.",
		"flora",        "Conjunto de espécies vegetais.",
		"reciclar",     "Precisamos separar o lixo para depois r_____.",
		"energia",      "Deixar a TV ligada sem ninguém assistindo  desperdício de en______.",
		"consciência",  "Para preservarmos o ambiente, é preciso con________.",
		"desperdício",  "Banhos longos são des_______ de água.",
		"economia",     "É importante que façamos eco_____ de energia.",
		"terra",        "É necessário que nos preocupemos com a nossa mãe Te____.",
		"vida",     	"Preservar o ambiente é cuidar de nossa v___.",
		"árvores",   	"Plantar ar_____ é uma atitude que preserva a vida.",
		"doce",     	"Vivemos em um mundo com mais água _____ do que salgada.",
		"reduzir",   	"Precisamos r_____ o uso de energia.",
		"mobilização", 	"É necessária a mob______ das pessoas para a preservação ambiental.",
		"natureza",  	 "A nat_____ precisa ser conservada.",
		"planeta",   	"Nosso pl_____ precisa ser salvo com a participação de todos!",
		"desmatamento", "O des____ está acabando com nossas árvores.",
		"poluição",   	"A pol____ faz mal a saúde.",
		"cidades",   	"Nas cid__ grandes, há muita poluição",
		"educação",   	"A ed_____ ambiental é importante na preservação do planeta.",
		"consumo",   	"O con____ de energia deve ser reduzido para não faltar às futuras gerações."];
		
		public var medias : Array =
		[
		"ciclo",    	"O cic____ de vida são todas as fases da vida, desde o início até o fim.",
		"fauna",    	"Conjunto de espécies animais de uma determinada espécie.",
		"seletiva",   	"Cada lixo é de um tipo. É importante realizar a coleta _______.",
		"papel",    	"O pap_____ é um material reciclável.",
		"repensar",   	"Devemos rep_____ nossas ações ambientais.",
		"estufa",    	"O acúmulo de gás carbônico na atmosfera gera efeito _____.",
//		"reparar",   	"Quando inventar um produto, temos que pensar na facilidade de como ele será consertado e as peças trocadas.",
		"reutilizar",  	"Ao invés de jogar fora, é melhor r_______, ou seja, utilizar novamente.",
		"semente",   	"Grão ou a parte do fruto próprio para a reprodução.",
		"resíduos",   	"Restos, sobras. Podem ser sólidos, líquidos e gasosos.",
		"embalagens",  	"As emb____ dos produtos devem ser ecologicamente corretas.",
		"solar",    	"Energia _____ é aquela que vem do sol",
		"planta",    	"Qualquer vegetal que cresce no solo ou na água.",
		"extinção",   	"Devemos cuidar, proteger e tratar bem os animais em ex______."
		];
		
		public var dificeis : Array =
		[
		"chorume",   	"Caldo de cor escura, de mal cheiro que vem do lixo.",
		"ozônio",    	"A poluição está causando buracos na camada de ______.",
//		"clima",    	"Conjunto de condições atmosféricas que caracterizam uma região, como frio e calor. ",
		"cristal",   	"Material brilhante não reciclável.",
		"lâmpada",   	"Ilumina a casa, e não é reciclável.",
		"jornal",    	"Fornece notícias, e é reciclável.",
		"leis",     	"Regulamentações, normas.",
		"eólica",    	"Energia provida pela força dos ventos.",
		"agrotóxico",  	"Defensivo agrícola",
		"queimada",  	"Limpeza do terreno com uso de fogo de forma controlada.",
		"pecuária",  	"Atividades envolvidas na criação de animais domésticos.",
//		"contaminação", "É necessário cuidado com a c_____ de alimentos, porque eles podem ser prejudiciais à sua saúde.",
		"ecossistema", 	"Comunidade de organismos que interagem uns com os outros e com o meio ambiente."
		];
		
		*/
		
		public var faceis : Array =
		[
		"árvore",          "",
		"planta", 			"",
		"jardim",			"",
		"parque",			"",
		"praça",			"",
		"floresta",			"",
		"semente",			"",
		"papel",			"",
		"plástico",			"",
		"terra",			"",
		"vida",				"",
		"flor",				"",
		"metal",			"",
		"pássaro",			"",
		"animal",			"",
		"lixo",				"",
		"nuvem",			"",
		"sujo",				"",
		"limpo",			"",
		"lago",				""
		];
		
		public var medias : Array =
		[
		"semente",			"",
		"jornal",			"",
		"clima",			"",
		"lâmpada",			"",
		"queimada",			"",
		"cristal",			"",
		"energia",			"",
		"natureza",			"",
		"educação",			"",
		"areia",			"",
		"solo",				"",
		"sol",				"",
		"chuva",			"",
		"lixo",				"",
		"sucata",			"",
		"seca",				"",
		"frio",				"",
		"calor",			"",
		"vento",			"",
		"cidade",			""
		];
		
		public var dificeis : Array =
		[
		"repensar",		"",
		"repor",		"",
		"reciclar",		"",
		"reparar",		"",
		"reutilizar",	"",
		"reduzir",		""
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