close all; clear all;

wsize = 7; % size of local window used in ROPE
tau = 2; % maximum number of iterations

filename = '1.png';
Cin = imread(filename);
Cout = rope(Cin, wsize, tau);
imwrite(Cout, ['Cout.' filename]);

%figure(1); imshow(Cin); title('Input'); drawnow
%figure(2); imshow(Cout); title('Output'); drawnow
