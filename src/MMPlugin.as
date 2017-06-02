package
{
	import flash.display.MovieClip;
	
	/**
	 * LemoNovel用、oggを再生するプラグインクラス.
	 * 
	 */
	public class MMPlugin extends MovieClip
	{
		private var m_lnExtIF:Object;	//LNの外部インターフェース
		private var m_paramObj:Object;	//LNから来たパラメータ
		
		/**
		* コンストラクタ.
		* 
		* LemoNovelから読み込まれた時、最初に始まる。
		*/	
		public function MMPlugin() 
		{
			//some initialization
		}
		
		/**
		 * LoadMovieLvで呼び出される関数。
		 * @param	arg_lnExtIF		LNの内部インターフェース。
		 * @param	arg_paramObj	LoadMovieLvから与えられるパラメータ。
		 * @param	arg_volume		LN側のBGMの音量設定。0~1の値。TODO
		 */
		public function Initialize(arg_lnExtIF:Object, arg_paramObj:Object, arg_volume:Number):void
		{
			//parse parameters
			//work with them
		}
		/**
		 * UpdateSWFParamで呼び出される関数。
		 * @param	arg_paramObj	UpdateSWFParamから与えられるパラメータ。
		 */
		public function NotifyParam(arg_paramObj:Object):void
		{
			//same as initialize
		}
		
	}
}