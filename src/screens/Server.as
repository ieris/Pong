package screens
{
	import starling.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	
	public class Server extends Sprite
	{	
		private var myPaddlePosition:int;
		private var socket:Socket;
		private var multiplayer:Multiplayer = new Multiplayer();
		private var serverSocket:ServerSocket;
		private var clientSockets:Array = new Array(); 
		private var port:uint = 53000;
		private var ip:String = "127.0.0.1";
		
		//Creating simple game to focus on functionality
		//Pong is a real-time which meant that the game had to constantly send data from the game to the server. 
		//Communicating with leaderboard was simple
		//For authentification purposes, the desicion was made to use headers as it stores a token key. 
		//To create a secure communication channel between the game and the leaderboard headers were used. These headers can hold token keys
		//which are set in the game code. secure data was sent over
		//HTTP Requests were sent out to the leaderboard
		public function Server()
		{
			/*this.addEventListener(Event.ENTER_FRAME, sendDataToServer);
			trace(multiplayer.getPaddleYPosition());
			
			try
			{
				serverSocket = new ServerSocket();
				serverSocket.bind(port, ip);
				
				serverSocket.listen();
				trace("Listening on " + serverSocket.localPort);
			}
			catch(e:SecurityError)
			{
				trace(e);
			}*/
			
			 
			//socket = new Socket();
			
			//socket.addEventListener( Event.CONNECT, onConnect );
			
			//socket.connect( "127.0.0.1", 53000 );
		}
		
		private function onConnect(event:Event):void
		{
			trace( "The socket is now connected..." ); 
		}
		
		public function connectHandler(event:ServerSocketConnectEvent):void 
		{ 			 
			//The socket is provided by the event object 
			var socket:Socket = event.socket as Socket; 
			clientSockets.push( socket ); 
			
			socket.addEventListener( ProgressEvent.SOCKET_DATA, sendDataToServer);
			
			//socket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler); 
			//socket.addEventListener( Event.CLOSE, onClientClose ); 
			//socket.addEventListener( IOErrorEvent.IO_ERROR, onIOError ); 
			
			//Send a connect message 
			socket.writeUTFBytes("Connected."); 
			socket.flush(); 
			
			trace( "Sending connect message" ); 		
		}
		
		/*public function socketDataHandler(event:ProgressEvent):void 
		{ 
			var socket:Socket = event.target as Socket 
			
			//Read the message from the socket 
			var message:String = socket.readUTFBytes( socket.bytesAvailable ); 
			trace( "Received: " + message); 
			
			// Echo the received message back to the sender 
			message = "Echo -- " + message; 
			socket.writeUTFBytes( message ); 
			socket.flush(); 
			trace( "Sending: " + message ); 
		} */
		
		private function onClientClose( event:Event ):void 
		{ 
			trace( "Connection to client closed." ); 
			//Should also remove from clientSockets array... 
		}
		
		private function onIOError( errorEvent:IOErrorEvent ):void 
		{ 
			trace( "IOError: " + errorEvent.text ); 
		} 
		
		private function onClose( event:Event ):void 
		{ 
			trace( "Server socket closed by OS." ); 
		} 
		
		private function sendDataToServer(event:ProgressEvent):void
		{
			var positionData:int = multiplayer.getPaddleYPosition();
			trace("Position data: " + positionData);
			var socket:Socket = event.target as Socket
			socket.writeUTFBytes( "1" );
			socket.writeInt(1);
			
			socket.flush();
		}
	}}
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
	}
}