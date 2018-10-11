#!/bin/bash 
## to build 3520 sde1 project
bison -d lambda1.y
flex lambda1.in
gcc lambda1.c -Wall -lfl -o lambda1
