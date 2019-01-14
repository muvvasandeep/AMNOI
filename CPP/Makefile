CFLAGS=-g -DDEBUG
CC=g++

all:AMNOI

lex.yy.c:AMNOI.l 
	lex AMNOI.l

AMNOI:lex.yy.c 
	$(CC) $(CFLAGS) AMNOI.cpp -o AMNOI lex.yy.c -ll

check:input.cpp
	$(CC) $(CFLAGS) input.cpp -o check

clean:
	rm -f *.o AMNOI lex.yy.c

clear:
	rm -f check
