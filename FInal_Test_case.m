clc, clear, close all


% Define the col vectors using the provided colx, coly, and colz
% retrived from IDE
colx = [0.8301138850593545, 0.5783477546143274, 0.6280330384736862];
coly = [0.5575910451483735, 0.7248610786538819, 0.46318035486724285];
colz = [0.0017788203982774002, 0.37428637616843113, 0.6253306816801527];

% Create the color vector matrix

colVectorID = [colx; coly; colz];

ImgRGB                  = double(imread('test_image_1.png'));
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


%representation of Image by Removing desired and undesired componenet from
figure, imshow(ind2rgb(uint8(Dye01_transmittance), LUTdye01), 'Border', 'Tight')
figure, imshow(ind2rgb(uint8(Dye02_transmittance), LUTdye02), 'Border', 'Tight')
