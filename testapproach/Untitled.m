% img = imread('D:\papers\Images\3\1.bmp');
% temp = rgb2hsv(img);
% temp(:,:,3) = temp(:,:,3).^.4;
% img2 = hsv2rgb(temp);

I = load_images('D:\papers\Images\3');
N = size(I,4);
for n =1:N
    temp = rgb2hsv(I(:,:,:,n));
    temp(:,:,3) = temp(:,:,3).^.4;
    img2 = hsv2rgb(temp);
    imwrite(img2,['../3_hsv_v_enhance' ,int2str(n), '.bmp']);
end