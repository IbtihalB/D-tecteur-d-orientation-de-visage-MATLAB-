%close all
%clear;
camera=webcam();
img= snapshot(camera);figure;imshow(img);
img0=rgb2gray(img);
img1=im2bw(img0);
%%%%%%%%%%%%MORPHOLOGICAL OPERATIONS FOR CONTOUR%%%%%%%%%%%%%%%%
 im1=edge(img1,'Sobel');
 es=strel('rectangle',[3 3]);
 im=imdilate(im1,es);imshow(im);
%%%%%%%%%%%%%%%calculating dimensions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im2=bwareaopen(im,2200);
img2=bwperim(im2);figure;imshow(img2);
[L, n]=bwlabel(im2);
r=regionprops(L,'BoundingBox');   
rectangle('Position',r(1).BoundingBox,'Edgecolor','g');figure;imshow(img2);
rb=r(1).BoundingBox(3);
%%%%%%%%%%%%%%%%%%%%%%%%DETECTION OF ORIENTATION%%%%%%%%%%%%%%%%%%%%%%%%%%
faceDetector4 = vision.CascadeObjectDetector('EyePairBig');
bbox4 = step(faceDetector4, img);
faceDetector1.MergeThreshold=20;
b=isempty(bbox4);
if b==0
%%%%%%%%DETECTION OF NORTH DIRECTION %%%%%%%%%%%
faceDetector1 = vision.CascadeObjectDetector('Nose');
faceDetector1.MergeThreshold=50;
bbox1 = step(faceDetector1, img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
faceDetector2 = vision.CascadeObjectDetector('Mouth');
faceDetector2.MergeThreshold=250;
bbox2 = step(faceDetector2, img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label={'pair eye' 'Nose' 'Mouth'};
if(isempty(bbox4)==0 || isempty(bbox1)==0 || isempty(bbox2)==0)
figure,imshow(img0);title('detected north orientation');
end
%%%%%%%%%%%%%%%DETECTION OF PROFILE FACE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
faceDetector5 = vision.CascadeObjectDetector('LeftEye');faceDetector5.MergeThreshold=20;
bbox5 = step(faceDetector5, img);
k=isempty(bbox5);
faceDetector7 = vision.CascadeObjectDetector('RightEye');faceDetector7.MergeThreshold=20;
bbox7 = step(faceDetector7, img);
p=isempty(bbox7);
if (( p==0 && k~=0) ||(k ==0 && p~=0))
%     figure;imshow(img);title('detected profil face');
sta= regionprops(im2,'Extrema');
cent= regionprops('table',im2,'Centroid');
a=class(sta);
g=table2array(cent);
 ri=sta.Extrema(3,1);
 l=sta.Extrema(8,1);
 c=g(1,1);
 r1=abs(l -c);
 r2=abs(ri-c);
 if r2>r1 
        figure;imshow(img);title('detected est direction');
 else
        figure;imshow(img);title('detected west direction'); 
 end
end
%%%%%%%%DETECTION OF SOUTH DIRECTION %%%%%%%%%%%

if (b==1 && p==1&& k==1)
    imshow(img);title('detected south face');
end   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






