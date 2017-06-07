package
{
	import flash.display.MovieClip;
	import constants.Mode;
	import nlExternalInterface.LNExtIF;
	import jp.gr.java_conf.ennea.sound.*;
	
	/**
	 * LemoNovel用、oggを再生するプラグインクラス.
	 *
	 * <p><code>[LoadMovieLv level=... path=... param="mode=init" wait=NONE volType=BGM]</code>
	 * で始める(但し...には適宜必要な値を入れる)。
	 * この処理は時間がかかる。initが終わった直後にちょろっと音が出てるときがある…？(TODO)</p>
	 * 
	 * <p>次以降は<code>[UpdateSWFParam dstLayer=OVERLAY dstIdx=... param=...]</code>で指示を出す。
	 * paramには次のいずれかのセットを入れる：
	 * <li><code>id=... mode=load url=...</code>
	 * 		<p>idにurlのoggを読み込む</p></li>
	 * <li><code>mode=play volume=... time=...</code>
	 * 		<p>idに読み込んだ音楽をvolumeで再生する.volumeは省略可(デフォで1)timeで設定された時間(ms)をかけて二次関数的にフェードインする（デフォは0）.</p></li>
	 * <li><code>mode=stop time=...</code>
	 * 		<p>idの音楽を停止する。timeで設定された時間(ms)をかけて二次関数的にフェードアウトする（デフォは0).</p></li>
	 * <li><code>mode=adjust volume=... time=...</code>
	 * 		<p>idで再生中の音楽の音量をvolume(0~1)へ変更する。timeで設定された時間(ms)をかけて二次関数的に変化させる（デフォは0).</p></li>
	 * .</p>
	 * 
	 * <p>明示的にこのプラグインを終了させるには<code>[DelMovieLv level=...]</code>を使う。</p>
	 * 
	 */
	public class Plugin extends MovieClip
	{
		//パラメータオブジェクト
		private var _param:Parameters;
						
		/**
		 * コンストラクタ.
		 *
		 * LemoNovelから読み込まれた時、最初に始まる。
		 */
		public function Plugin()
		{
			//Init & load
			_param = new Parameters();

			//VorbisASを使えるようにする
			haxe.initSwc(this);
			VorbisAS.initialize();
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
			LNExtIF.lnExtIF = arg_lnExtIF;

			//LNのパラメタ文字列をパース
			_param.setLNParam(arg_paramObj);
			
			//VorbisASのマスターボリュームとNLのBGMvolumeを合わせる
			VorbisAS.masterVolume = arg_volume;
			
			//パラメタに従って操作
			execute();
		}
		
		/**
		 * UpdateSWFParamで呼び出される関数。
		 * @param	arg_paramObj	UpdateSWFParamから与えられるパラメータ。
		 */
		public function NotifyParam(arg_paramObj:Object):void
		{
			LNExtIF.lnExtIF.LN_Trace("INFO", "arg_param:id= " + arg_paramObj.id);
			LNExtIF.lnExtIF.LN_Trace("INFO", "arg_param:volume= " + arg_paramObj.volume);

			//LNのパラメタ文字列をパース
			_param.setLNParam(arg_paramObj);

			LNExtIF.lnExtIF.LN_Trace("INFO", "_param:id= " + _param.id);
			LNExtIF.lnExtIF.LN_Trace("INFO", "_param:volume= " + _param.volume.toString());

			//パラメタに従って操作
			execute();

		}
		/**
		 * NLのBGMVolumeが変更されたとき([SetSystem bgmVolume=...])に呼ばれる関数
		 * @param	arg_volume
		 */
		public function NotifyChangeVolume(arg_volume:Number):void
		{
			//VorbisASのマスターボリュームとNLのBGMvolumeを合わせる
			VorbisAS.masterVolume = arg_volume;
		}
		
		/**
		 * 実行部分.パラメタで振る舞いを変える。
		 */
		private function execute():void
		{
			//mode=?
			switch (_param.mode)
			{

			case Mode.INIT:
				break;
			case Mode.LOAD: 
				VorbisAS.loadSound(_param.url, _param.id);
					//loadに失敗した時は何もしない。idがヘンでも何もしない。
				break;
			case Mode.UNLOAD:	//まだ音が鳴っててもぶつ切り。
				VorbisAS.removeSound(_param.id);	//すでに無いときは何もしない
				break;
			case Mode.PLAY: 
				VorbisAS.playLoop(_param.id, 0).fadeTo(_param.volume, _param.time, false);
					//idが違うorロード出来てないなどの時は例外を投げてる。
				break;
			case Mode.STOP:
				VorbisAS.fadeTo(_param.id, 0, _param.time);
				break;
			case Mode.ADJUST:
				VorbisAS.fadeTo(_param.id, _param.volume, _param.time, false);
				break;
			case Mode.PAUSE:
				VorbisAS.fadeTo(_param.id, 0, _param.time, false)
				
						//note: addOnceで多分1回きりってことだろうけど、実はendedがdispatchされた後はremoveAllされてる(VorbisTween参照)
						.fade.ended.addOnce(function(instance:VorbisInstance):void
							{
								
								//fade.endedは、ポーズ以外のモードのfade終了も使ってる。
								//なので、ポーズのfadeがendしたかどうかを特定しなければならない。
								//それが分からんので、とりあえず「音量が0かどうか」を条件とする。
								if (instance.volume == 0)
									instance.pause();
							}
						);
				break;
			case Mode.RESUME:		
				VorbisAS.resume(_param.id).fadeTo(_param.volume, _param.time, false);
				break;
				
			}
		}
	}
}