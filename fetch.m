folder='C:\matlab\pixort\cbir_images'
I=dir(fullfile(folder,'*.jpg'))
lbp_pix=[];

for k=1:numel(I)
  filename=fullfile(folder,I(k).name);
  I2{k}=imread(filename);
  pic = imresize(I2{k},[256 256]);
  imshow(pic);
  cform = makecform('srgb2lab');
  lab = applycform(pic,cform);
  ll = lab(:,:,1);
  a = ll;
  [m,n] = size(a);  
  for i = 2:m-1
    for j = 2:n-1
        b = a(i-1:i+1,j-1:j+1);
        B(i-1:i+1,j-1:j+1) = LBP(b);
    end
  end
 
  lbp = mean(mean(B))
  lbp_pix =[lbp_pix lbp];
  save lbp_pix lbp_pix;
end


% target =[];
% 
% for o=1:100
%    target = [target 1 2 3 4];
% end
% 
% save target target 


