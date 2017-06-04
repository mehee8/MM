package nlExternalInterface 
{
	/**
	 * LNの外部インターフェースを保持するstaticクラス.
	 * @author ore
	 */
	public class LNExtIF 
	{
		private static var _lnExtIF:Object = null;
		/**
		 * 外部インターフェースそれそのまま.
		 */
		public static function set lnExtIF(arg:Object):void { _lnExtIF = arg; }
		public static function get lnExtIF():Object { return _lnExtIF; }
	}

}