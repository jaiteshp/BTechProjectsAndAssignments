#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <time.h> 
#include <sys/mman.h>
#include <sys/stat.h>
#include <math.h>
#include <fcntl.h>
int nproc = 0;
int g_pid;
int w_state[1000];	//0 just created; 1 ready; 2 waiting(sleeping); 
					//3 running; 4 stopped; 5 completed;
char * nw_pid_string[1000];
int w_pid[1000];
long long ready_time[1000];
void * shmem;
int completed_count;

void getpid_of_allws(char * shmem1)
{
	char * nw_pid_string1 = (char *) malloc(1000);
	strcpy(nw_pid_string, shmem1);
	strcpy(nw_pid_string1, shmem1);
	char * token;
	//printf("s 27 %s\n",nw_pid_string);
	printf("s 28 %s\n",shmem);
	
	token = strtok(nw_pid_string1, "~");
	
	while(token != NULL)
	{
		w_pid[nproc] = atoi(token);
		nproc++;
		token = strtok(NULL, "~");
	}
	//printf("s 36 nproc = %d\n",nproc);
	int i;
	for(i = 0; i < nproc; i++)	
	{
		//printf("w_pid[%d] is %d\n", i,w_pid[i]);
		ready_time[i] = 10000000000000;
	}	
	
	
	return;
}

int findRow(int w_pid1)
{
	int i;
	for(i = 0; i < nproc; i++)
	{
		if(w_pid[i] == w_pid1)	return i;
	}
	if(i == nproc)
	{
		printf("No w_pid found in table\n");
		return 0;
	}
	else return 0;
}
int noRunning()	//Returns 0 if there is some process running
{
	int i = 0;
	for(i = 0; i < nproc; i++)	if(w_state[i] == 3)	return 0;
	
	return 1;
}
void scheduler()
{
	int i = 0;
	printf("s 73 table is \n");
	for(i = 0; i < nproc; i++)
	{
		printf("%d -> %d -> %lld\n", w_pid[i], w_state[i], ready_time[i]);
	}
	long long min = 100000000000000;
	int reqRow = -1;
	int count = 0;
	
	for(i = 0; i < nproc; i++)
	{
		if(w_state[i] == 1)
		{
			count++;
			if(ready_time[i] < min)
			{
				min = ready_time[i];
				reqRow = i;
			}
		}
	}
	
	if(count == 0)	
	{
		printf("No ready process available for s to run\n");
		return;
	}
	kill(w_pid[reqRow], SIGUSR2);
	printf("s 97 sent running signal to %d\n", w_pid[reqRow]);
	w_state[reqRow] = 3;
	
}

void	sig_handler2(int sig, siginfo_t *info, void *context)
{
    struct timeval t;
	switch(sig){
	case SIGUSR1:
    printf("s received wait signal from %d \n", info->si_pid);
    w_state[findRow(info->si_pid)] = 2;
    scheduler();
    break;
    
    case SIGUSR2:
    gettimeofday(&t,NULL);
    printf("s received ready signal from %d\n", info->si_pid);
    w_state[findRow(info->si_pid)] = 1;
    printf("s 116 set w_state[%d] = 1\n", info->si_pid);
    printf("s 117 rowfound is %d\n", findRow(info->si_pid));
    ready_time[findRow(info->si_pid)] = (long long)t.tv_sec;
    
    if(noRunning())		
    {
    	printf("s 121\n");
    	scheduler();
    	printf("s 130\n");
    }
    break;
    
    case SIGALRM:
    printf("s received created signal from %d\n", info->si_pid);
    
    if(info->si_pid == g_pid)	{getpid_of_allws(shmem);printf("s 118\n");}
    else    w_state[findRow(info->si_pid)] = 0;
    
	printf("s 131\n");
    
	break;
	
	case SIGTERM:
    printf("s received completed signal from %d\n", info->si_pid);
    w_state[findRow(info->si_pid)] = 5;
    completed_count++;
    if(completed_count == nproc)
    {
    	printf("s 150 all processes completed\n");
    	exit(0);
    }
    if(noRunning)
    {
    	printf("s 142\n");
    	scheduler();
	}
    printf("s 135\n");
	break;
	}
}

int main(int argc, char * argv[])
{
	  char * s_pid_string = (char *) malloc(1000);
	  strcpy(s_pid_string, "");
	  sprintf(s_pid_string, "%d", getpid());
	  
	  char* name = "cs3500";
	  int size = 1280;
	  //int pid = getpid();

	  int fd = shm_open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	  ftruncate(fd, size);
	  
	  shmem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED , fd, 0);
	  
	  char * nw_pid_string = (char *) malloc(1000);
	  strcpy(nw_pid_string, "");
	
	g_pid = fork();

	if(g_pid == 0)
	{
		char * exec[4];
	    exec[0] = "something";
   	    exec[1] = shmem;
   	    exec[2] = s_pid_string;
	    exec[3] = 0;
		
		execvp("./g",exec);
		exit(0);
	}
	else
	{
		//this is scheduler.
		struct sigaction sa;
		sa.sa_flags = SA_SIGINFO;
    	sa.sa_sigaction = sig_handler2;
    	sigaction(SIGUSR1, &sa, NULL);
    	sigaction(SIGUSR2, &sa, NULL);
    	sigaction(SIGALRM, &sa, NULL);
    	sigaction(SIGTERM, &sa, NULL);

    	//wait(NULL);
		while(1)	sleep(1);		
	}
	
	return 0;
}
