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
		
		private var _volume:Number;
		/**
		 * volume.
		 */
		public function get volume():Number { return _volume; }
		
		private var _time:Number;
		/**
		 * time. フェードイン：アウトにかける時間(ms).
		 */
		public function get time():Number { return _time; }
		/**
		 * パラメタを消す
		 */
		private function reset():void
		{
			_url = "";
			_mode = null;
			_volume = 1.0;
			_time = 0;
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
			if (lnParam.mode == "stop")
				_mode = Mode.STOP;
			if (lnParam.mode == "adjust")
				_mode = Mode.ADJUST;
			if (lnParam.mode == "pause")
				_mode = Mode.PAUSE;
			if (lnParam.mode == "resume")
				_mode = Mode.RESUME;

			//url=
			if (lnParam.url != undefined)
				_url = lnParam.url;
			
			//volume=
			if (lnParam.volume != undefined)
				_volume = Number(lnParam.volume);
			
			//time=
			if (lnParam.time != undefined)
				_time = Number(lnParam.time);
			
		}
	}

}