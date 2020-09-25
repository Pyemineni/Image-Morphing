clear all
close all
clc
I1=imread('o.jpg');
I2=imread('f1.jpg');
I3=imresize(I2,[size(I1,1) size(I1,2)]); 
Image1 = im2double(I1);
Image2 = im2double(I3);
key_pt1 = [541.645496535797,375.038106235566;771.322170900693,387.047344110855;937.950346420323,501.135103926097;975.479214780601,735.315242494226;918.435334872979,868.918013856813;733.793302540416,915.453810623557;535.640877598152,924.460739030023;375.017321016166,886.931870669746;272.938799076212,777.347575057737;268.435334872979,624.229792147806;354.001154734411,465.107390300231]
key_pt2 = [576.172055427252,378.040415704388;723.285219399538,381.042725173210;867.396073903002,453.098152424942;901.922632794457,601.712471131640;880.906466512702,735.315242494226;774.324480369515,792.359122401848;604.693995381062,802.867205542725;469.590069284065,742.821016166282;412.546189376443,615.222863741339;412.546189376443,514.645496535797;462.084295612009,427.578521939954]
cpselect(Image1, Image2);
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




