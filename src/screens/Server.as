package screens
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class Server extends Sprite
	{	
		private var loader:URLLoader
		private var serverSocket:Socket;
		private var hostName:String = "localhost";
		private var port:uint = 5656;
		//private var ip:String = "127.0.0.1";
		private var ip:String = "46.101.88.96";
		
		public function Server()
		{
			super();
			
			serverSocket = new Socket();
			loader = new URLLoader();
			configureListeners(loader);
			
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://http://iveta.coventry.domains/testingServerConnection.html";
			var urlRequest:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables();
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(header);
			
			variables.ball_x_position = 0;
			variables.ball_y_position = 0;
			variables.player_one_y_position = 0;
			variables.player_two_y_position = 0;
			
			urlRequest.data = variables;
			
			try
			{
				loader.load(urlRequest);
			}
			catch(error:Error)
			{
				trace("Unable to load the data from the leaderboard");
			}
			
			serverSocket.addEventListener(Event.CONNECT,socketConnected);
			serverSocket.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			serverSocket.connect(ip, port);
		}
		
		protected function socketConnected(e:Event):void
		{
			trace("client - socket connected");
		}
		
		protected function socketData(e:ProgressEvent):void
		{
			trace("client - socket data");
			// read the string from the socket
			trace(serverSocket.readUTF());
		}
		
		protected function configureListeners(dispatcher:IEventDispatcher):void
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
	
		
		/*private function onConnect( event:ServerSocketConnectEvent ):void
		{
			serverSocket = event.socket;
			serverSocket.addEventListener( ProgressEvent.SOCKET_DATA, onClientSocketData );
			log( "Connection from " + serverSocket.remoteAddress + ":" + serverSocket.remotePort );
		}
		
		private function onClientSocketData( event:ProgressEvent ):void
		{
			var buffer:ByteArray = new ByteArray();
			serverSocket.readBytes( buffer, 0, serverSocket.bytesAvailable );
			log( "Received: " + buffer.toString() );
		}
		
		private function bind( event:Event ):void
		{
			if( serverSocket.bound ) 
			{
				serverSocket.close();
				serverSocket = new ServerSocket();
				
			}
			serverSocket.bind( parseInt( localPort.text ), localIP.text );
			serverSocket.addEventListener( ServerSocketConnectEvent.CONNECT, onConnect );
			serverSocket.listen();
			log( "Bound to: " + serverSocket.localAddress + ":" + serverSocket.localPort );
		}*/
		
		/*private function send( event:Event ):void
		{
			try
			{
				if( clientSocket != null && clientSocket.connected )
				{
					clientSocket.writeUTFBytes( message.text );
					clientSocket.flush(); 
					log( "Sent message to " + clientSocket.remoteAddress + ":" + clientSocket.remotePort );
				}
				else log("No socket connection.");
			}
			catch ( error:Error )
			{
				log( error.message );
			}
		}*/
		
		/*private function log( text:String ):void
		{
			logField.appendText( text + "\n" );
			logField.scrollV = logField.maxScrollV;
			trace( text );
		}
		
		private function setupUI():void
		{
			localIP = createTextField( 10, 10, "Local IP", "0.0.0.0");
			localPort = createTextField( 10, 35, "Local port", "0" );
			createTextButton( 170, 60, "Bind", bind );
			message = createTextField( 10, 85, "Message", "Lucy can't drink milk." );
			createTextButton( 170, 110, "Send", send );
			logField = createTextField( 10, 135, "Log", "", false, 200 )
			
			this.stage.nativeWindow.activate();
		}
		
		private function createTextField( x:int, y:int, label:String, defaultValue:String = '', editable:Boolean = true, height:int = 20 ):TextField
		{
			var labelField:TextField = new TextField();
			labelField.text = label;
			labelField.type = TextFieldType.DYNAMIC;
			labelField.width = 100;
			labelField.x = x;
			labelField.y = y;
			
			var input:TextField = new TextField();
			input.text = defaultValue;
			input.type = TextFieldType.INPUT;
			input.border = editable;
			input.selectable = editable;
			input.width = 280;
			input.height = height;
			input.x = x + labelField.width;
			input.y = y;
			
			this.addChild( labelField );
			this.addChild( input );
			
			return input;
		}
		
		private function createTextButton( x:int, y:int, label:String, clickHandler:Function ):TextField
		{
			var button:TextField = new TextField();
			button.htmlText = "<u><b>" + label + "</b></u>";
			button.type = TextFieldType.DYNAMIC;
			button.selectable = false;
			button.width = 180;
			button.x = x;
			button.y = y;
			button.addEventListener( MouseEvent.CLICK, clickHandler );
			
			this.addChild( button );
			return button;
		} */      
	
}