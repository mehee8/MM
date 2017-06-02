package 
{
	/**
	 * LNから渡されたパラメータのデータクラス。
	 * 多分。
	 * @author ore
	 */
	public class MMParam 
	{
		public var url:String;	//BGMのurl
		
		public function MMParam() 
		{
			
		}
		/**
		 * LNからくるパラメタをパースする。
		 * パラメタが省略あるいは空文字の場合はセットしない。
		 * @param	lnParam
		 */
		public function SetLNParam(lnParam:Object)
		{
			if (lnParam.url != undefined)
				url = lnParam.url;
		}
	}

}