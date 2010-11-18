package Ibict.Profile.Data {

	public class FabricaData {
		private static const REF_CICLO : Array = new Array(1, 2, 3);
		public var ciclos_done : Array;

		public function FabricaData() {
			ciclos_done = new Array(false, false, false);
		}

		public function getStarCount() : int {
			var cont : int = 0;
			for (var i : int = 0; i < ciclos_done.length; i++) {
				if (ciclos_done[i])
					cont += REF_CICLO[i];
			}

			return cont;
		}
	}
}
