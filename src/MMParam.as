package 
{
	import mmConductor.constants.MMModeType;
	/**
	 * LNから渡されたパラメータのデータクラス。
	 * 
	 * @author ore
	 */
	public class MMParam 
	{
		private var _url:String;
		/**
		 * url. oggファイルのアドレスを取得する.
		 */
		public function get url():String { return _url; }
		
		private var _mode:MMModeType;
		/**
		 * mode. モードを取得する.
		 */
		public function get mode():MMModeType { return _mode; }
		
		/**
		 * パラメタを消す
		 */
		private function reset():void
		{
			_url = "";
			_mode = null;
		}

		/**
		 * LNのパラメタ文字列をパースする.
		 * @param	lnParam
		 */
		public function setLNParam(lnParam:Object):void
		{
			//以前に呼ばれた時にセットされたパラメタを消す
			reset();
			
			//取りうるパラメタのセットを限定する 例えばmode=initの時のみurlをセットするなど
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
	}

}