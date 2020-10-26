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
int s_pid;
int nproc = 0;
void * shmem;

int main(int argc, char * argv[])
{
	//printf("g 16\n");
	s_pid = atoi(argv[2]);
	shmem = argv[1];
	char * nw_pid_string = (char *) malloc(1000);
	strcpy(nw_pid_string, "");
	
	FILE * fp;
	fp = fopen("input.txt", "r");
	//printf("g 24\n");
	
	int n[1000],m[1000];
	float p[1000],t[1000],a[1000];
	
	while(EOF != fscanf(fp, "%f %d %d %f %f", &a[nproc], &m[nproc], &n[nproc], &p[nproc], &t[nproc]))
	{
		nproc++;
	}
	int nrc[nproc];
	int nw_pid[nproc];
	int i = 0;
	char* name = "cs3500";
	  int size = 1280;
	  //int pid = getpid();

	  int fd = shm_open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	  ftruncate(fd, size);
	  
	  shmem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED , fd, 0);
	for(i = 0; i < nproc; i++)
	{
		nrc[i] = fork();
		
		if(nrc[i] == 0)
		{		
			//printf("g 51\n");
			char * exec_argv[8];
			exec_argv[0]=(char *)malloc(100);
			exec_argv[1]=(char *)malloc(100);
			exec_argv[2]=(char *)malloc(100);
			exec_argv[3]=(char *)malloc(100);
			exec_argv[4]=(char *)malloc(100);
			exec_argv[5]=(char *)malloc(100);
			exec_argv[6]=(char *)malloc(100);
			exec_argv[7]=(char *)malloc(100);
			exec_argv[0] = "./w";
			sprintf(exec_argv[1],"%f",a[i]);
			sprintf(exec_argv[2],"%d",m[i]);
			sprintf(exec_argv[3],"%d",n[i]);
			sprintf(exec_argv[4],"%f",p[i]);
			sprintf(exec_argv[5],"%f",t[i]);
			sprintf(exec_argv[6],"%d", s_pid);
			exec_argv[7] = 0;
			//printf("g 60\n");
			execvp("./w", exec_argv);
		}
		else
		{
			//wait(NULL);
			//sleep(2);
			//printf("g 56 %d\n", nrc[i]);
			
			char * temp = (char *) malloc(100);
			strcpy(temp, "");
			sprintf(temp, "%d", nrc[i]);
			strcat(nw_pid_string, temp);
			if(i != nproc - 1)	strcat(nw_pid_string, "~");
		}
	}
	
	//printf("g 66\n");
	memcpy(shmem, nw_pid_string, strlen(nw_pid_string)+10);
	//printf("g 69 shmem is %s\n", shmem);
	//printf("g 70 shmem is %s\n", nw_pid_string);
	
	kill(s_pid, SIGALRM);	//Tells s that it has created all w processes.
	//printf("g 70->%d\n", getpid());

	return 0;
}
