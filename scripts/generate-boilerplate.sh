#!/bin/sh

# Generates boilerplate for a new solution. Copy the input data to clipboard before running.
# Don't forget to import the new module inside Main and include it in the list of solutions.


# Default input data placeholder
inputData="INSERT INPUT DATA HERE"


# Try to autodetect whether to use Linux/X or macOS clipboard paste command. If a suitable command
# is found, insert the clipboard content as the input data. 
which xclip > /dev/null
if [ $? -eq 0 ]
then
  inputData=`xclip -selection c -o`
else
  which pbpaste > /dev/null
  if [ $? -eq 0 ]
  then
    inputData=`pbpaste`
  else
    echo "Unable to paste clipboard content. Add input data manually to src/Data/Day$1.elm"  
  fi
fi


# Boilerplate for the input data
data="module Data.Day$1 exposing (data)


data : String
data =
    \"\"\"$inputData\"\"\"
"


# Boilerplate for the solution module
module="module Day$1 exposing (heading, solutions)


import Data.Day$1 exposing (data)


parsedData : List String
parsedData =
    String.split \"\\\n\" data


heading : String
heading =
    \"Day $1: $2\"
    
    
solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]
    
    
part1 : Int
part1 =
    0


part2 : Int
part2 =
    0
"


echo "$data" > ./src/Data/Day$1.elm
echo "$module" > ./src/Day$1.elm
