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
		private var _url:String;	//BGMのurl
		private var _modeType:MMModeType;
		
		public function get modeType():MMModeType { return _modeType; }
		public function get url():String { return _url; }
		/**
		 * LNからくるパラメタをパースする。
		 * パラメタが省略あるいは空文字の場合はセットしない。
		 * @param	lnParam
		 */
		public function setLNParam(lnParam:Object):void
		{
			LNExtIF.lnExtIF.LN_Trace("INFO", "setLNParam");
			if (lnParam.url != undefined)
				_url = lnParam.url;
			if (lnParam.mode == "load")
				_modeType = MMModeType.LOAD;
			if (lnParam.mode == "play")
				_modeType = MMModeType.PLAY;
			LNExtIF.lnExtIF.LN_Trace("INFO", "setLNParam end");
		}
	}

}