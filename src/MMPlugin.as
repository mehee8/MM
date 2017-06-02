package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.net.*;
	import flash.utils.ByteArray;
	import jp.hiiragi.managers.soundConductor.*;
	import jp.hiiragi.managers.soundConductor.constants.*;
	import jp.hiiragi.managers.soundConductor.error.*;
	import jp.hiiragi.managers.soundConductor.events.*;
	
	/**
	 * LemoNovel用のプラグインクラスで、oggを再生する。
	 * 
	 */
	public class MMPlugin extends MovieClip
	{
		private var m_lnExtIF:Object;
		private var m_paramObj:Object;
		private var m_url:String = "test.ogg";
		private var m_soundId:SoundId;
		private var m_soundPlayInfo:SoundPlayInfo;
		private var m_soundController:SoundController;
		
		/**
		* コンストラクタ。最初に読み込まれるので、ここで初期化する。
		*/	
		public function MMPlugin() 
		{
			SoundConductor.initialize(false, null, true);
		}
		
		/**
		 * データローダー。この関数を抜けてもロードが終わったという事ではないぞ
		 */
		public function LoadBGM():void
		{
			m_lnExtIF.LN_Trace("INFO", "MM:LoadBGM");
			var request:URLRequest = new URLRequest(m_url);
			var urlLoader:URLLoader = new URLLoader(request);
			//ロギング用
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
//			urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);

			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			//ロードが終わったら次へ
			urlLoader.addEventListener(Event.COMPLETE, SetBGM);
			m_lnExtIF.LN_Trace("INFO", "MM:LoadBGM end");
		}
		
		/**
		 * ロードが終わったBGMデータを再生可能な状態にする。
		 * @param	event
		 */
		public function SetBGM(event:Event):void
		{
			m_lnExtIF.LN_Trace("INFO", "MM:SetBGM");
			var oggData:ByteArray = URLLoader(event.target).data as ByteArray;
			m_soundId = SoundConductor.registerOggBinary(oggData);
			m_soundPlayInfo = new SoundPlayInfo(m_soundId);
			m_soundPlayInfo.soundPlayType = SoundPlayType.SINGLE_SOUND_GENERATOR;
			m_soundPlayInfo.loops = SoundLoopType.INFINITE_LOOP;
			m_lnExtIF.LN_Trace("INFO", "MM:SetBGM end");
		}
		/**
		 * BGM流す。
		 */
		public function PlayBGM():void
		{
			m_soundController = SoundConductor.play(m_soundPlayInfo);
		}
		
		/**
		 * コンストラクタが終了したあとにLoadMovieLvで呼び出される関数。
		 * @param	arg_lnExtIF
		 * @param	arg_paramObj
		 * @param	arg_volume
		 */
		public function Initialize(arg_lnExtIF:Object, arg_paramObj:Object, arg_volume:Number):void
		{
			m_lnExtIF = arg_lnExtIF;
			m_lnExtIF.LN_Trace("INFO", "MM:Initialize");
			m_url = arg_paramObj.url;
			LoadBGM();
			m_lnExtIF.LN_Trace("INFO", "MM:Initialize end");
		}
		/**
		 * UpdateSWFParamで呼び出される関数。
		 * @param	arg_paramObj
		 */
		public function NotifyParam(arg_paramObj:Object):void
		{
			m_lnExtIF.LN_Trace("INFO", "MM:NotifyParam");
			if (arg_paramObj.action == "play")
				PlayBGM();
			m_lnExtIF.LN_Trace("INFO", "MM:NotifyParam end");
		}
		
		//以下ログ用のハンドラ
		public function ioErrorHandler(event:Event):void
		{
			m_lnExtIF.LN_Trace("ERROR", "ioerror: " + event.toString());
		}
		public function securityErrorHandler(event:Event):void
		{
			m_lnExtIF.LN_Trace("ERROR", "securityerror: " + event.toString());
		}
		public function progressHandler(event:Event):void
		{
			m_lnExtIF.LN_Trace("INFO", "progression: " + event);
		}
	}
}