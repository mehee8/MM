package
{
	import flash.display.MovieClip;
	import mmConductor.constants.MMModeType;
	import mmConductor.MMConductor;
	import nlExternalInterface.LNExtIF;
	
	/**
	 * LemoNovel用、oggを再生するプラグインクラス.
	 *
	 * 
	 */
	public class MMPlugin extends MovieClip
	{
		//パラメータオブジェクト
		private var _mmParam:MMParam;
		
		//音楽操作オブジェクト
		private var _mmConductor:MMConductor;
		
		/**
		 * コンストラクタ.
		 *
		 * LemoNovelから読み込まれた時、最初に始まる。
		 */
		public function MMPlugin()
		{
			//Init & load
			_mmParam = new MMParam();
			_mmConductor = new MMConductor();
		}
		
		/**
		 * LoadMovieLvで呼び出される関数。
		 * @param	arg_lnExtIF		LNの内部インターフェース。
		 * @param	arg_paramObj	LoadMovieLvから与えられるパラメータ。
		 * @param	arg_volume		LN側のBGMの音量設定。0~1の値。TODO
		 */
		public function Initialize(arg_lnExtIF:Object, arg_paramObj:Object, arg_volume:Number):void
		{
			//NL外部インタフェイスを取得
			nlExternalInterface.LNExtIF.lnExtIF = arg_lnExtIF;
//			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "Initialize");

			//LNのパラメタ文字列をパース
			_mmParam.setLNParam(arg_paramObj);
			
			//パラメタに従って操作
			execute();
//			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "Initialize end");
		}
		
		/**
		 * UpdateSWFParamで呼び出される関数。
		 * @param	arg_paramObj	UpdateSWFParamから与えられるパラメータ。
		 */
		public function NotifyParam(arg_paramObj:Object):void
		{
			//LNのパラメタ文字列をパース
			_mmParam.setLNParam(arg_paramObj);

			//パラメタに従って操作
			execute();
		}
		
		/**
		 * 実行部分.パラメタで振る舞いを変える。
		 */
		private function execute():void
		{
			//mode=?
			switch (_mmParam.mode)
			{
			case MMModeType.LOAD: 
				_mmConductor.load(_mmParam.url);
				break;
			case MMModeType.PLAY: 
				_mmConductor.play();
				break;
			case MMModeType.INIT:
				break;
			}
		}
	}
}