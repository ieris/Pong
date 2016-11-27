package
{
	import flash.events.IEventDispatcher;
	import flash.net.XMLSocket;
	import flash.events.*;
	import starling.display.Sprite;

	public class SocketConnection extends Sprite
	{
		private var serverSocket:XMLSocket;
		private var hostName:String = "localhost";
		private var port:uint = 8080;
		private var IP:String = "127.0.0.1";
		
		public function SocketConnection()
		{
			super();
			
			serverSocket = new XMLSocket();
			dispatcherFunc(serverSocket);
			if (hostName && port)
			{
				serverSocket.connect(hostName, port);
			}
		}
		
		protected function dispatcherFunc(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectHandler);
			dispatcher.addEventListener(DataEvent.DATA, dataHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("securityErrorHandler: " + event);			
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);	
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("ioErrorHandler: " + event);			
		}
		
		private function dataHandler(event:DataEvent):void
		{
			trace("dataHandler: " + event);			
		}
		
		private function connectHandler(event:Event):void
		{
			trace("connectHandler: " + event);			
		}
		
		private function closeHandler(event:Event):void
		{
			trace("closeHandler: " + event);			
		}
	}
}