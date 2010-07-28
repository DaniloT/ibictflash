package Ibict.Games.Coleta.Entities
{
	public final class TrashTypesEnum
	{
		public static const METAL = 0;
		public static const GLASS = METAL + 1;
		public static const PLASTIC = GLASS + 1;
		public static const PAPER = PLASTIC + 1;
		public static const NOT_REC = PAPER + 1;
		public static const ORGANIC = NOT_REC + 1;
		
		public static const size = ORGANIC + 1;
		
		public function TrashTypesEnum()
		{
		}
	}
}
