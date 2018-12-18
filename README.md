# Distribution fitting using Matlab

## Requirements:

* Matlab R2017b or later
* Matlab Global optimization toolkit


## Setup:
* Create a file with the fullpath of all the traces you want to run and assign the path of this file to the fid variable in glbl_all.m
* Run glbl_all fle in matlab command prompt
* It should run for all the distribution given in the for loop and create a csv file for each of them. Each of the csv file contains the jsd, ks, r3 and the parameters of the distribution for each of the trace in one line.

