clear all; close all;

fname = input('file name: ', 's');
inputimage=single(uint8(imread(fname)/256));
fillcell
boundary
normals3swee
polarplotmanual2 %this is default
findcontour
outputcoord