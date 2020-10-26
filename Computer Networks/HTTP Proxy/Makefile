CC=g++
CFLAGS= -g 

all : ps2.c
	$(CC) $(CFLAGS) -o proxy_parse.o -c proxy_parse.c
	gcc $(CFLAGS) -o ps2.o -c ps2.c
	$(CC) $(CFLAGS) -o ps2 proxy_parse.o ps2.o