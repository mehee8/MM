package
{
	import flash.display.MovieClip;
	import constants.Mode;
	import conductor.Conductor;
	import nlExternalInterface.LNExtIF;
	
	/**
	 * LemoNovel用、oggを再生するプラグインクラス.
	 *
	 * <p><code>[LoadMovieLv level=... path=... param="mode=init" wait=NONE volType=BGM]</code>
	 * で始める(但し...には適宜必要な値を入れる)。
	 * この処理は時間がかかる。initが終わった直後にちょろっと音が出てるときがある…？(TODO)</p>
	 * 
	 * <p>次以降は<code>[UpdateSWFParam dstLayer=OVERLAY dstIdx=... param=...]</code>で指示を出す。
	 * paramには次のいずれかのセットを入れる：
	 * <li><code>mode=load url=...</code>
	 * 		<p>urlのoggを読み込む</p></li>
	 * <li><code>mode=play volume=... time=...</code>
	 * 		<p>読み込んだ音楽をvolumeで再生する.volumeは省略可(デフォで1)timeで設定された時間(ms)をかけてフェードインする（デフォは0）.</p></li>
	 * <li><code>mode=stop time=...</code>
	 * 		<p>音楽を停止する。timeで設定された時間(ms)をかけてフェードアウトする（デフォは0).</p></li>
	 * .</p>
	 * 
	 * <p>明示的にこのプラグインを終了させるには<code>[DelMovieLv level=...]</code>を使う。</p>
	 * 
	 */
	public class Plugin extends MovieClip
	{
		//パラメータオブジェクト
		private var _param:Parameters;
				
		//音楽操作オブジェクト
		private var _conductor:Conductor;
		
		/**
		 * コンストラクタ.
		 *
		 * LemoNovelから読み込まれた時、最初に始まる。
		 */
		public function Plugin()
		{
			//Init & load
			_param = new Parameters();
			_conductor = new Conductor();
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
			_param.setLNParam(arg_paramObj);
			
			//_conductorのマスターボリュームとNLのBGMvolumeを合わせる
			_conductor.setMasterVolume(arg_volume);
			
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
			_param.setLNParam(arg_paramObj);

			//パラメタに従って操作
			execute();
		}
		/**
		 * NLのBGMVolumeが変更されたとき([SetSystem bgmVolume=...])に呼ばれる関数
		 * @param	arg_volume
		 */
		public function NotifyChangeVolume(arg_volume:Number):void
		{
			//_conductorのマスターボリュームとNLのBGMvolumeを合わせる
			_conductor.setMasterVolume(arg_volume);			
		}
		
		/**
		 * 実行部分.パラメタで振る舞いを変える。
		 */
		private function execute():void
		{
			//mode=?
			switch (_param.mode)
			{
			case Mode.LOAD: 
				_conductor.load(_param.url);
				break;
			case Mode.PLAY: 
				_conductor.play(_param.volume, _param.time);
				break;
			case Mode.INIT:
				break;
			case Mode.STOP:
				_conductor.stop(_param.time);
				break;
			}
		}
	}
}