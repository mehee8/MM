package conductor 
{
	import jp.hiiragi.managers.soundConductor.*;
	import jp.hiiragi.managers.soundConductor.constants.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import nlExternalInterface.LNExtIF;

	/**
	 * MMの動作をになうクラス.
	 * @author ore
	 */
	public class Conductor 
	{
		//ロードした音楽を指すid
		private var _soundId:SoundId;
		
		//BGMの再生方法など
		private var _soundPlayInfo:SoundPlayInfo;
		
		//再生するBGMはここにいれる
		private var _soundController:SoundController;

		/**
		 * コンストラクタ.
		 * 
		 */
		public function Conductor() 
		{
			//SoundConductorを初期化する。oggを使用できるようにする。
			SoundConductor.initialize(false, null, true);
		}
		
		/**
		 * oggをロードする.
		 * @param	url	oggファイルの場所
		 */
		public function load(url:String):void
		{
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "MM:LoadBGM");
			//URLrequestをつくって
			var request:URLRequest = new URLRequest(url);
			
			//ダウンロードする
			var urlLoader:URLLoader = new URLLoader(request);
			
			//データがバイナリであると言っとく
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			//ロギング用のハンドラを追加する
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
//			urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);

			//ロードが終わったら次へ
			urlLoader.addEventListener(Event.COMPLETE, completeHandler);

			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "MM:LoadBGM end");
			
		}
		/**
		 * ロードが終わった時のハンドラ.
		 * @param	event
		 */
		private function completeHandler(event:Event):void
		{
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "MM:SetBGM");
			//ロードしたバイナリデータをByteArrayに入れる
			var oggData:ByteArray = URLLoader(event.target).data as ByteArray;
			
			//ByteArrayをSoundConductorに登録してIDをもらう
			_soundId = SoundConductor.registerOggBinary(oggData);
			
			//SoundPlayInfoを作る
			_soundPlayInfo = new SoundPlayInfo(_soundId);
			
			//部分ループを可能にする
			_soundPlayInfo.soundPlayType = SoundPlayType.SINGLE_SOUND_GENERATOR;
			
			//無限ループにする
			_soundPlayInfo.loops = SoundLoopType.INFINITE_LOOP;
			
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "MM:SetBGM end");
		}
		/**
		 * 音楽を再生する.
		 */
		public function play():void
		{
			//詳しくはSoundConductorのAPIをみてくれ。
			_soundController = SoundConductor.play(_soundPlayInfo);
		}
		
		
		//以下はロギング用ハンドラ
		private function ioErrorHandler(event:Event):void
		{
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("ERROR", "ioerror: " + event.toString());
		}
		private function securityErrorHandler(event:Event):void
		{
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("ERROR", "securityerror: " + event.toString());
		}
		private function progressHandler(event:Event):void
		{
			nlExternalInterface.LNExtIF.lnExtIF.LN_Trace("INFO", "progression: " + event);
		}
		
	}

}