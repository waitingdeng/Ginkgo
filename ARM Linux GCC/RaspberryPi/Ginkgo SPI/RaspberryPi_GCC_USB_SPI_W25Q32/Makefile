# Instructions to the compiler and options
CC = g++
RM = rm
CFLAGS = -Wall
# Macro definition
DEFS = -D OS_UNIX
CFLAGS += $(DEFS)
# The target file  
TARGET = USB_SPI_W25Q32
# The source file
SRCS = USB_SPI_W25Q32.cpp 
# The header file search path
INC = -I./
# Dependent libraries,Select library file According to the operating system you using
LIBS += -L./lib -lGinkgo_Driver -lusb
LIBS += -L/lib/arm-linux-gnueabihf -lpthread 
# The target file
OBJS = $(SRCS:.cpp=.o)
# Link for the executable file
$(TARGET):$(OBJS)
	$(CC) -o $@ $^ $(LIBS)

clean:
	$(RM) -rf $(TARGET) $(OBJS) *~

%.o:%.cpp
	$(CC) $(CFLAGS) $(INC) -o $@ -c $<
