package 
{
	import constants.MMModeType;
	/**
	 * LNから渡されたパラメータのデータクラス。
	 * 多分。
	 * @author ore
	 */
	public class MMParam 
	{
		private var _url:String;
		/**
		 * oggファイルのアドレスを取得する.
		 */
		public function get url():String { return _url; }
		
		private var _mode:MMModeType;
		/**
		 * モードを取得する.
		 */
		public function get mode():MMModeType { return _mode; }
		
		/**
		 * LNからくるパラメタをパースする。
		 * パラメタが省略あるいは空文字の場合はセットしない。
		 * @param	lnParam
		 */
		public function setLNParam(lnParam:Object):void
		{
			reset();

			if (lnParam.mode == "init")
				_mode = MMModeType.INIT;
			if (lnParam.mode == "load")
			{
				_mode = MMModeType.LOAD;
				_url = lnParam.url;
			}
			if (lnParam.mode == "play")
				_mode = MMModeType.PLAY;
		}
		/**
		 * リセット.
		 */
		private function reset():void
		{
			_url = "";
			_mode = null;
		}
	}

}