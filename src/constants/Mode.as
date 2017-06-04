package constants 
{
	/**
	 * MMのmodeオプションのenum class.
	 * @author ore
	 */
	public class Mode 
	{
		//BGMをロードするよ
		public static const LOAD:Mode = new Mode();	
		
		//再生するよ
		public static const PLAY:Mode = new Mode();	
		
		//初期化するよ(最初にやる)
		public static const INIT:Mode = new Mode();
		
		//停止
		public static const STOP:Mode = new Mode();
		
	}

}