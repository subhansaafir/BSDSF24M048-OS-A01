CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

TARGET = bin/client

SRC = src/main.c src/mystrfunctions.c src/myfilefunctions.c

all:
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

clean:
	rm -f $(TARGET)
