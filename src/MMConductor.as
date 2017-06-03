package 
{
	import jp.hiiragi.managers.soundConductor.*;
	import jp.hiiragi.managers.soundConductor.constants.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;

	/**
	 * MMの動作をになうクラス.
	 * @author ore
	 */
	public class MMConductor 
	{
		private var _soundId:SoundId;	//ロードした音楽を指すid
		private var _soundPlayInfo:SoundPlayInfo;	//BGMの再生方法など
		private var _soundController:SoundController;

		/**
		 * コンストラクタ.
		 * SoundConductorを初期化する。
		 */
		public function MMConductor() 
		{
			SoundConductor.initialize(false, null, true);
		}
		
		/**
		 * oggをロードする.
		 * @param	url	oggファイルの場所
		 */
		public function load(url:String):void
		{
			LNExtIF.lnExtIF.LN_Trace("INFO", "MM:LoadBGM");
			var request:URLRequest = new URLRequest(url);
			var urlLoader:URLLoader = new URLLoader(request);
			//ロギング用
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
//			urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);

			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			//ロードが終わったら次へ
			urlLoader.addEventListener(Event.COMPLETE, completeHandler);
			LNExtIF.lnExtIF.LN_Trace("INFO", "MM:LoadBGM end");
			
		}
		public function play():void
		{
			_soundController = SoundConductor.play(_soundPlayInfo);
		}
		/**
		 * ロードが終わった時のハンドラ.
		 * @param	event
		 */
		private function completeHandler(event:Event):void
		{
			LNExtIF.lnExtIF.LN_Trace("INFO", "MM:SetBGM");
			var oggData:ByteArray = URLLoader(event.target).data as ByteArray;
			_soundId = SoundConductor.registerOggBinary(oggData);
			_soundPlayInfo = new SoundPlayInfo(_soundId);
			_soundPlayInfo.soundPlayType = SoundPlayType.SINGLE_SOUND_GENERATOR;
			_soundPlayInfo.loops = SoundLoopType.INFINITE_LOOP;
			LNExtIF.lnExtIF.LN_Trace("INFO", "MM:SetBGM end");
		}
		
		private function ioErrorHandler(event:Event):void
		{
			LNExtIF.lnExtIF.LN_Trace("ERROR", "ioerror: " + event.toString());
		}
		private function securityErrorHandler(event:Event):void
		{
			LNExtIF.lnExtIF.LN_Trace("ERROR", "securityerror: " + event.toString());
		}
		private function progressHandler(event:Event):void
		{
			LNExtIF.lnExtIF.LN_Trace("INFO", "progression: " + event);
		}
		
	}

}