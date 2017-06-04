package constants 
{
	/**
	 * MMのmodeオプションのenum class.
	 * @author ore
	 */
	public class Mode 
	{
		/**
		 * oggファイルをロードする
		 */
		public static const LOAD:Mode = new Mode();	
		
		/**
		 * ロードしたのを再生
		 */
		public static const PLAY:Mode = new Mode();	
		
		/**
		 * 初期化
		 */
		public static const INIT:Mode = new Mode();
		
		/**
		 * 停止
		 */
		public static const STOP:Mode = new Mode();
		
		/**
		 * 再生中のBGMの音量変更
		 */
		public static const ADJUST:Mode = new Mode();
		
		/**
		 * 再生中の一時停止
		 */
		public static const PAUSE:Mode = new Mode();
		
		/**
		 * 再生再開
		 */
		public static const RESUME:Mode = new Mode();
	}

}