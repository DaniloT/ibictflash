package Ibict.Profile.Data {

	public class QuebraCabecaData {
		private static const REF_DIFICULT = [1, 2, 4, 6];
		private var dificult_done : Array;

		public function QuebraCabecaData() {
			dificult_done = [false, false, false, false];
		}

		public function getStarCount() : int {
			for (var i : int = dificult_done.length - 1; i >= 0; --i) {
				if (dificult_done[i]) return REF_DIFICULT[i];
			}

			return 0;
		}

		public function setDificultDone(i : int, value : Boolean) {
			if ((i < 0) || (i >= dificult_done.length))
				throw new Error("Invalid index.");
			dificult_done[i] = value;
		}

		public function getDificultDone(i : int) : Boolean {
			if ((i < 0) || (i >= dificult_done.length))
				throw new Error("Invalid index.");
			return dificult_done[i];
		}
	}
}
