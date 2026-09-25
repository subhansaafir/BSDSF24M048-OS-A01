CC = gcc
CFLAGS = -Wall -Wextra -Iinclude

OBJDIR = obj
BINDIR = bin
LIBDIR = lib

LIB = $(LIBDIR)/libmyutils.a
TARGET = $(BINDIR)/client_static

MAIN_OBJ = $(OBJDIR)/main.o
LIB_OBJS = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

all: $(TARGET)

$(TARGET): $(MAIN_OBJ) $(LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJ) -L$(LIBDIR) -lmyutils -o $(TARGET)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/main.o: src/main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJDIR)/*.o $(LIB) $(BINDIR)/client_static
