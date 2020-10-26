#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <time.h> 
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <math.h>
int s_pid;
int running = 0;

void signal_handler1(int signal_no)
{
	if(signal_no == SIGUSR2)
	{
		//Now change state of w to running
		printf("w received running signal from s\n");
	}
	if(signal_no == SIGCONT)
	{
		printf("w recieved continue from s\n");
	}
}

void io_emulation(float t)
{
	//Now, w signals s that it starts sleeping
	kill(s_pid, SIGUSR1);
	
	//Now w sleeps for 't' time
	sleep(t);
	
	//Now, tell s that it is ready
	kill(s_pid, SIGUSR2);	
	
	//if(signal(SIGUSR2, signal_handler1));
	pause();
	//The above is when w recieves signal form s,
	//w changes from ready to running and starts doing work	
}

int main(int argc, char * argv[])
{		
	//printf("w 53\n");
	s_pid = atoi(argv[6]);
	float a = atof(argv[1]);
	int m = atoi(argv[2]);
	int n = atof(argv[3]);
	float p = atof(argv[4]);
	float t = atof(argv[5]);
	//printf("w 54 %d %d %d %f %t %d\n", a,m,n,p,t,s_pid);
	
	sleep(a);
	printf("%d arrived\n", getpid());
	//Now tells s that it is asleep
	kill(s_pid, SIGALRM);
	kill(s_pid, SIGUSR2);
	
	
	signal(SIGUSR2, signal_handler1);
	signal(SIGCONT, signal_handler1);
	
	//kill(s_pid, SIGUSR2);
	kill(s_pid, SIGUSR2);	//w tells Sched that w is ready.	
	pause();
	
	//The above is when w recieves running signal form s,
	//w changes from ready to running and starts doing work
	
	int i = 0, j = 0;
	for(i = 0; i < n; i++)
	{
		
		int a1[m];
		int a2[m];
		for(j = 0; j < m; j++)
		{
			a1[j] = rand();
			a2[j] = rand();
		}		
		int junk = 0;
		for(j = 0; j < m; j++)
		{
			junk += a1[j] * a2[j];
		}
		
		if(rand()<(pow(2,31)-1)*p) io_emulation(t);
		//printf("i in w is %d\n",i);
	}	
	
	kill(s_pid, SIGTERM);
	//Now, w signalled s that it is completed.
	
	
	return 0;
}
