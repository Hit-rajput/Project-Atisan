clc, clear, close all


% Define the col vectors using the provided colx, coly, and colz
% retrived from IDE
Color1 = [0.592132, 0.4580393, 0.6630081];
Color2 = [0.39982012, 0.55231196, 0.7315021];
Color3 = [0.69965965, 0.6965282, 0.15913807];

% Create the color vector matrix
colVectorID = [Color1; Color2; Color3];


ImgRGB                  = double(imread('test_image_4.png'));
DyeToBeRemovedID        = 0;
doIcross                = 1;

figure, imshow(uint8(ImgRGB), [], 'Border', 'Tight')
ImgR = ImgRGB(:,:,1);
ImgG = ImgRGB(:,:,2);
ImgB = ImgRGB(:,:,3);

[ImgR_back, ImgG_back, ImgB_back, Dye01_transmittance, Dye02_transmittance, Dye03_transmittance, LUTdye01, LUTdye02, LUTdye03, Q3x3Mat] = Colour_Seperation2(ImgR, ImgG, ImgB, colVectorID, DyeToBeRemovedID, doIcross);


ImgRGB_back(:,:,1) = ImgR_back;
ImgRGB_back(:,:,2) = ImgG_back;
ImgRGB_back(:,:,3) = ImgB_back;


figure, imshow(ind2rgb(uint8(Dye02_transmittance), LUTdye02), 'Border', 'Tight')
figure, imshow(ind2rgb(uint8(Dye03_transmittance), LUTdye03), 'Border', 'Tight')

% OUTPUT VISUALIZATION: LUTs IN THE IMAGEJFORMAT
LUTStain01_ImageJ = round(LUTdye01.*255); % Use this to obtain the same values of the ImageJ Colour Deconvolution plugin. Basically, it is a uint8 conversion with rounded values.
LUTStain02_ImageJ = round(LUTdye02.*255); % Use this to obtain the same values of the ImageJ Colour Deconvolution plugin. Basically, it is a uint8 conversion with rounded values.
LUTStain03_ImageJ = round(LUTdye03.*255); 