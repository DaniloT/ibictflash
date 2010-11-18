package Ibict.Profile.Data {

	public class FabricaData {
		private static const REF_CICLO = [1, 2, 2];
		private var ciclo_done : Array;

		public function FabricaData() {
			ciclo_done = [false, false, false];
		}

		public function getStarCount() : int {
			var cont : int = 0;
			for (var i : int = 0; i < ciclo_done.length; i++) {
				if (ciclo_done[i])
					cont += REF_CICLO[i];
			}

			return cont;
		}

		public function setCicloDone(i : int, value : Boolean) {
			if ((i < 0) || (i >= ciclo_done.length))
				throw new Error("Invalid index.");
			ciclo_done[i] = value;
		}

		public function getCicloDone(i : int) : Boolean {
			if ((i < 0) || (i >= ciclo_done.length))
				throw new Error("Invalid index.");
			return ciclo_done[i];
		}
	}
}
