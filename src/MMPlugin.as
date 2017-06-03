package
{
	import flash.display.MovieClip;
	import constants.MMModeType;
	
	/**
	 * LemoNovel用、oggを再生するプラグインクラス.
	 *
	 */
	public class MMPlugin extends MovieClip
	{
		private var _mmParam:MMParam;	//LNから受け取ったパラメタがパース・格納されている
		private var _mmConductor:MMConductor;	//音楽再生などの主な動作を司るヤツ
		
		/**
		 * コンストラクタ.
		 *
		 * LemoNovelから読み込まれた時、最初に始まる。
		 */
		public function MMPlugin()
		{
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
			LNExtIF.lnExtIF = arg_lnExtIF;
			LNExtIF.lnExtIF.LN_Trace("INFO", "Initialize");
			_mmParam.setLNParam(arg_paramObj);
			execute();
			LNExtIF.lnExtIF.LN_Trace("INFO", "Initialize end");
		}
		
		/**
		 * UpdateSWFParamで呼び出される関数。
		 * @param	arg_paramObj	UpdateSWFParamから与えられるパラメータ。
		 */
		public function NotifyParam(arg_paramObj:Object):void
		{
			_mmParam.setLNParam(arg_paramObj);
			execute();
		}
		
		/**
		 * パラメータに従って行う動作.
		 */
		private function execute():void
		{
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