CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
PICFLAGS = -fPIC

OBJDIR = obj
BINDIR = bin
LIBDIR = lib

STATIC_LIB = $(LIBDIR)/libmyutils.a
DYNAMIC_LIB = $(LIBDIR)/libmyutils.so

TARGET = $(BINDIR)/client_dynamic

MAIN_OBJ = $(OBJDIR)/main.o
LIB_OBJS = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

all: $(TARGET)

$(TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJ) -L$(LIBDIR) -lmyutils -o $(TARGET)

$(DYNAMIC_LIB): $(LIB_OBJS)
	$(CC) -shared -o $(DYNAMIC_LIB) $(LIB_OBJS)

$(OBJDIR)/main.o: src/main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c $< -o $@

$(OBJDIR)/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c $< -o $@

clean:
	rm -f $(OBJDIR)/*.o $(DYNAMIC_LIB) $(BINDIR)/client_dynamic
