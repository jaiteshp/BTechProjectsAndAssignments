#include <unistd.h> 
#include <stdio.h> 
#include <sys/socket.h> 
#include <stdlib.h> 
#include <netinet/in.h> 
#include <string.h> 
#include <netdb.h>
#include <arpa/inet.h> 
#include "proxy_parse.c"

int main(int argc, char const *argv[])
{
	int PORT = atoi(argv[1]);
	int port2;
	int ps_fd;
	int ps_fd2;
	int listening_socket;
	struct sockaddr_in ps_Address;
	struct sockaddr_in cl_Address;
	int opt = 1;
	int addrlen = sizeof(ps_Address);
	char buffer[102400] = {0};
	char buffer2[102400] = {0};


	char ip[16];
	struct hostent* host;
	struct sockaddr_in server_Address;
	server_Address.sin_family = AF_INET; 

	ps_fd = socket(AF_INET, SOCK_STREAM, 0);

	setsockopt(ps_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));

	ps_Address.sin_family = AF_INET; 
	ps_Address.sin_addr.s_addr = INADDR_ANY; 
	ps_Address.sin_port = htons( PORT );

	bind(ps_fd, (struct sockaddr *)&ps_Address, sizeof(ps_Address));

	listen(ps_fd, 3);

	int cpid;
	int forkcount = 0;
	while(1)
	{
		forkcount++;
		if(forkcount == 100)
		{
			printf("No of processes exceeded 100\n");
			return 0;
		}
		listening_socket = accept(ps_fd, (struct sockaddr *)&cl_Address,(socklen_t*)&addrlen); 
		
		if(listening_socket < 0)	exit(1);
		
		if((cpid = fork()) == 0)
		{
			close(ps_fd);
		
			read(listening_socket, buffer, 102400);

			//printf("%s\n", buffer);

			//DO PARSING HERE.

			struct ParsedRequest *req = ParsedRequest_create();

			strcat(buffer, "\r\n");
			int len = strlen(buffer); 
			int ec = 1;
		   	if ((ec = ParsedRequest_parse(req, buffer, len)) < 0) 
		   	{
				if(ec == -1)	send(listening_socket, "Bad Request 400", strlen("Bad Request 400"), 0);
				else if(ec == -2)	send(listening_socket, "Not Implemented 501", strlen("Not Implemented 501"), 0);
		    	return -1;
		   	}
		   	ParsedHeader_set(req, "Host", req->host);
		   	ParsedHeader_set(req, "Connection", "close");

		   	server_Address.sin_port = htons(80); 
			if(req->port != NULL)
			{
				server_Address.sin_port = htons(atoi(req->port));
			}


		   	int rlen = ParsedRequest_totalLen(req);
			char *b = (char *)malloc(rlen+1);
			if (ParsedRequest_unparse(req, b, rlen) < 0) 
			{
				printf("unparse failed\n");
			    return -1;
			}
			b[rlen]='\0';

			 //printf("%s\n", b);

			///////////////////

			host = gethostbyname(req->host);
			server_Address.sin_addr = *((struct in_addr*) (host->h_addr_list[0]));
			inet_ntop(AF_INET, &server_Address.sin_addr, ip, sizeof(ip));

			inet_pton(AF_INET, ip, &server_Address.sin_addr);

			ps_fd2 = socket(AF_INET, SOCK_STREAM, 0);
			setsockopt(ps_fd2, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));
			
			connect(ps_fd2, (struct sockaddr *)&server_Address, sizeof(server_Address));

			send(ps_fd2, b, strlen(b), 0);

			sleep(1);
			int count = 0;
			while(recv(ps_fd2, buffer2, 102400,0))
			{
				sleep(1);
				send(listening_socket, buffer2, strlen(buffer2), 0);
				count++;
				
			}
			close(listening_socket);
			exit(1);
		}
		else
		{
			close(listening_socket);
		}

	} 


}
