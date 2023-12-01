clc, clear, close all

% Define the col vectors using the provided colx, coly, and colz
% retrived from IDE
Color1 = [0.6344531512448314, 0.7261423742445815, 0.26492725643456394];
Color2 = [0.368520526863156, 0.7899934094531404, 0.49000309621583493];
Color3 = [0.48444452726826853, 0.43633615713799406, 0.7582375999473198];
% Create the color vector matrix
colVectorID = [Color1; Color2; Color3];

ImgRGB                  = double(imread('test_case_3.png'));
DyeToBeRemovedID        = 0;
doIcross                = 1;

figure, imshow(uint8(ImgRGB), [], 'Border', 'Tight')
ImgR = ImgRGB(:,:,1);
ImgG = ImgRGB(:,:,2);
ImgB = ImgRGB(:,:,3);

[ImgR_back, ImgG_back, ImgB_back, Dye01_transmittance, Dye02_transmittance, Dye03_transmittance, LUTdye01, LUTdye02, LUTdye03, Q3x3Mat] = Colour_Seperation2(ImgR, ImgG, ImgB, colVectorID, DyeToBeRemovedID, doIcross);


% OUTPUT VISUALIZATION: RGB IMAGE RECONSTRUCTED BY REMOVING A DYE
ImgRGB_back(:,:,1) = ImgR_back;
ImgRGB_back(:,:,2) = ImgG_back;
ImgRGB_back(:,:,3) = ImgB_back;


% OUTPUT VISUALIZATION: SINGLE DYES: TRANSMITTANCE CHANNELS
figure, imshow(uint8(Dye03_transmittance), 'Border', 'Tight')

% OUTPUT VISUALIZATION: SINGLE DYES: TRANSMITTANCE CHANNELS VISUALISED WITH COLOURS
% Note: these images in colour should be never used for quantitative analysis!
figure, imshow(ind2rgb(uint8(Dye03_transmittance), LUTdye03), 'Border', 'Tight')

LUTStain01_ImageJ = round(LUTdye01.*255); 
LUTStain02_ImageJ = round(LUTdye02.*255); 
LUTStain03_ImageJ = round(LUTdye03.*255); 