CXX = g++
CXXFLAGS = -Wall -std=c++17

SRC = func.cpp main.cpp
OBJ = $(SRC:.cpp=.o)
EXEC = my_program

all: $(EXEC)

$(EXEC): $(OBJ)
    $(CXX) -o $@ $^
    
.cpp.o:
    $(CXX) $(CXXFLAGS) -c $< -o $@
    
clean:
    rm -f $(OBJ) $(EXEC)
