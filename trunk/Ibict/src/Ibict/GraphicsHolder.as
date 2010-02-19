package Ibict
{
	import flash.display.DisplayObject;
	
	/**
	 * Uma interface simples que expões os métodos para adicionar e remover objetos
	 * gráficos de uma classe qualquer (que não herde DisplayObjectContainer mas possua
	 * um dentro de si).
	 * 
	 * @author Luciano Santos
	 * 
	 * @see DisplayObject
	 * @see DisplayObjectContainer
	 */
	public interface GraphicsHolder {
		/**
		 * Adiciona o objeto gráfico dado à árvore de gráficos.
		 * 
		 * Se o objeto já for filho dessa classe, nada será feito.
		 * 
		 * @param g o objeto a ser adicionado.
		 */
		function addGraphics(g : DisplayObject);
		
		/**
		 * Remove o objeto gráfico dado da árvore de gráficos.
		 * 
		 * Se o objeto não for filho dessa classe, nada será feito.
		 * 
		 * @param
		 */
		function removeGraphics(g : DisplayObject);
	}
}
