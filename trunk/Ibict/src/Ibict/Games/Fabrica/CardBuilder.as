package Ibict.Games.Fabrica
{
	import flash.display.Bitmap;

	public class CardBuilder
	{
		public static function build(index : int) : Bitmap
		{
			switch (index) {
				case 0:
					return new Bitmap(new fabArrow0(0, 0));
					break;
				case 1:
					return new Bitmap(new fabArrow1(0, 0));
					break;
				case 2:
					return new Bitmap(new fabArrow2(0, 0));
					break;
				case 3:
					return new Bitmap(new fabArrow3(0, 0));
					break;
				case 4:
					return new Bitmap(new fabArrow4(0, 0));
					break;
				case 5:
					return new Bitmap(new fabArrow5(0, 0));
					break;
				case 6:
					return new Bitmap(new fabArrow6(0, 0));
					break;
				case 7:
					return new Bitmap(new fabArrow7(0, 0));
					break;
				case 8:
					return new Bitmap(new fabCard8(0, 0));
					break;
				case 9:
					return new Bitmap(new fabCard9(0, 0));
					break;
				case 10:
					return new Bitmap(new fabCard10(0, 0));
					break;
				case 11:
					return new Bitmap(new fabCard11(0, 0));
					break;
				case 12:
					return new Bitmap(new fabCard12(0, 0));
					break;
				case 13:
					return new Bitmap(new fabCard13(0, 0));
					break;
				case 14:
					return new Bitmap(new fabCard14(0, 0));
					break;
				default:
					return null;
					break;
			}
		}
	}
}
