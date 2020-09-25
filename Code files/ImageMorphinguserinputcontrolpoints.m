clear all
close all
clc
I1=imread('o.jpg');
I2=imread('f1.jpg');
I3=imresize(I2,[size(I1,1) size(I1,2)]); 
Image1 = im2double(I1);
Image2 = im2double(I3);
[key_pt1 , key_pt2] = cpselect(Image1, Image2, 'wait' , true);
save data.mat key_pt1 key_pt2
load data.mat
size(Image1)
size(Image2)
key_pt1 = key_pt1' 
key_pt2 = key_pt2' 
[h,w,~] = size(Image1);
key_pt1 = [key_pt1 [0 0]' [w 0]' [0 h]' [w h]'];
key_pt2 = [key_pt2 [0 0]' [w 0]' [0 h]' [w h]'];
half_pts = 0.5*key_pt1 + 0.5*key_pt2;  
d1 = half_pts(1,:)';
d2 = half_pts(2,:)';  
t1 = delaunay(d1, d2);
for nframes = 1:11
    t = (nframes-1)/10;     
    target = (1-t)*key_pt1 + t*key_pt2;   
    w1 = warp(Image1,key_pt1,target,t1);        
    w2 = warp(Image2,key_pt2,target,t1);             
    finaloutput = (1-t)*w1 + t*w2;                     
    finaloutput = (1-t)*w1 + t*w2;                
    clf; 
    imagesc(finaloutput); 
    drawnow;   
    imwrite(finaloutput,sprintf('frame_%1d.jpg',nframes),'jpg');   
  end




