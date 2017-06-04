package 
{
	import constants.Mode;
	/**
	 * LNから渡されたパラメータをパースして一時的に保持するクラス.
	 * 
	 * 単にLNのパラメタ文字列を扱いやすいようにしただけ。
	 * 
	 * @author ore
	 */
	public class Parameters 
	{
		private var _url:String;
		/**
		 * url. oggファイルのアドレスを取得する.
		 */
		public function get url():String { return _url; }
		
		private var _mode:Mode;
		/**
		 * mode. モードを取得する.
		 */
		public function get mode():Mode { return _mode; }
		
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
			
			//mode=
			if (lnParam.mode == "init")
				_mode = Mode.INIT;
			if (lnParam.mode == "load")
				_mode = Mode.LOAD;
			if (lnParam.mode == "play")
				_mode = Mode.PLAY;

			//url=
			_url = lnParam.url;
		}
	}

}