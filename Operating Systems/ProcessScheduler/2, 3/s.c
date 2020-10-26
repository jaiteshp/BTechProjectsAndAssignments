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
struct timeval t;
struct timeval t00;
struct timeval t0;
char * csv;
int nproc = 0;
int g_pid;
int w_state[1000];	//0 just created; 1 ready; 2 waiting(sleeping); 
					//3 running; 4 stopped; 5 completed;
char * nw_pid_string[1000];
int w_pid[1000];
float ready_time[1000];
void * shmem;
int completed_count;

void addNumber(int type, float num, int id)
{
	//printf("s 27 long num is %f\n", num);
	char * temp = (char *) malloc(100);
	strcpy(temp, "");
	
	if(type == 0)
	{
		sprintf(temp, "%f", num);
		strcat(temp, ",");
	}
	else if(type == 1)
	{
		sprintf(temp, "%f", num);
		strcat(temp, ",");		
	}
	else if(type == 2)
	{
		sprintf(temp, "%d", id);
		strcat(temp, "\n");		
	}
	strcat(csv, temp);
	strcpy(temp, "");
}

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
		ready_time[i] = 100000000000000;
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
		printf("%d -> %d -> %f\n", i, w_state[i], ready_time[i]);
	}
	float min = 10000000000000000;
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
	if(reqRow != -1)
	{
	kill(w_pid[reqRow], SIGUSR2);
	gettimeofday(&t,NULL);
	addNumber(0, (float)((float)(t.tv_sec - t00.tv_sec) + ((float)(t.tv_usec - t00.tv_usec))/1000000), -1);
	printf("s 97 sent running signal to %d\n", w_pid[reqRow]);
	w_state[reqRow] = 3;
	}
	
}

void	sig_handler2(int sig, siginfo_t *info, void *context)
{
	switch(sig){
	case SIGUSR1:
    printf("s received wait signal from %d \n", info->si_pid);
    w_state[findRow(info->si_pid)] = 2;
    gettimeofday(&t,NULL);
	addNumber(1, (float)((float)(t.tv_sec - t00.tv_sec) + ((float)(t.tv_usec - t00.tv_usec))/1000000), -1);
    addNumber(2, (float) findRow(info->si_pid), findRow(info->si_pid));
    scheduler();
    break;
    
    case SIGUSR2:
    gettimeofday(&t,NULL);
    printf("s received ready signal from %d\n", info->si_pid);
    w_state[findRow(info->si_pid)] = 1;
    //printf("s 116 set w_state[%d] = 1\n", info->si_pid);
    //printf("s 117 rowfound is %d\n", findRow(info->si_pid));
    ready_time[findRow(info->si_pid)] = (float)(t.tv_sec - (t.tv_usec)/1000000);
    
    if(noRunning())		
    {
    	printf("s 121\n");
    	scheduler();
    	printf("s 130\n");
    }
    break;
    
    case SIGALRM:
    printf("s received created signal from %d\n", info->si_pid);
    
    if(info->si_pid == g_pid)	
    {
    	getpid_of_allws(shmem);printf("s 118\n");
    	gettimeofday(&t00, NULL);
	}
    else    w_state[findRow(info->si_pid)] = 0;
    
	printf("s 131\n");
    
	break;
	
	case SIGTERM:
    printf("s received completed signal from %d\n", info->si_pid);
    w_state[findRow(info->si_pid)] = 5;
    gettimeofday(&t,NULL);
	addNumber(1, (float)((float)(t.tv_sec - t00.tv_sec) + ((float)(t.tv_usec - t00.tv_usec))/1000000), -1);
    addNumber(2, (long long) findRow(info->si_pid), findRow(info->si_pid));
    completed_count++;
    if(completed_count == nproc)
    {
    	printf("s 150 all processes completed\n");
    	printf("csv is \n%s", csv);
    	FILE * fp1;
    	fp1 = fopen("schedule.csv", "w");
    	//strcat(csv, (char) EOF);
    	fprintf(fp1, csv);
    	fclose(fp1);
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
	  //gettimeofday(&t00, NULL);
	  csv = (char *) malloc(1000);
	  strcpy(csv, "");
		
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
