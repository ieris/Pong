//Server
//#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment(lib,"ws2_32.lib")
#include<WinSock2.h>
#include<iostream>
#include <WS2tcpip.h>

using namespace std;

SOCKET Connections[10];


int main()
{
	int noOfConnections = 0;
	WSAData wsaData;
	WORD DllVersion = MAKEWORD(2, 1);
	if (WSAStartup(DllVersion, &wsaData) != 0)
	{
		MessageBoxA(NULL, "Something went wrong...", "Error", MB_OK | MB_ICONERROR);
		exit(1);
	}
	SOCKADDR_IN addr;
	int addrlen = sizeof(addr);
	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
	addr.sin_port = htons(1234);
	addr.sin_family = AF_INET;

	SOCKET sListen = socket(AF_INET, SOCK_STREAM, NULL);
	bind(sListen, (SOCKADDR*)&addr, sizeof(addr));
	listen(sListen, SOMAXCONN);

	SOCKET newConnection;
	for (int i = 0; i < 10; i++)
	{
		newConnection = accept(sListen, (SOCKADDR*)&addr, &addrlen);
		if (newConnection == 0)
		{
			std::cout << "Failed to connect with client" << std::endl;
		}
		else
		{
			std::cout << " Connection Made" << std::endl;
			
			char servermsg[256] = "UP";
			send(newConnection, servermsg, sizeof(servermsg), NULL);
			Connections[i] = newConnection;
			noOfConnections += 1;
			cout << "Number of connections to the server: " << noOfConnections << endl;
		}
	}
	system("pause");
	return 0;
}