clc, clear, close all


% Define the col vectors using the provided colx, coly, and colz
% retrived from IDE
Color1 = [0.714445899844093, 0.6521404449332814, 0.2535348028933823];
Color2 = [0.610549470898804, 0.6370947609356951, 0.47046743688961123];
Color3 = [0.0017788203982774002, 0.37428637616843113, 0.6253306816801527];

% Create the col vector matrix
colVectorID = [Color1; Color2; Color3];

ImgRGB                  = double(imread('FInger_print.png'));
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

% OUTPUT VISUALIZATION: SINGLE DYES: TRANSMITTANCE CHANNELS VISUALISED WITH COLOURS
% Note: these images in colour should be never used for quantitative analysis!
figure, imshow(ind2rgb(uint8(Dye01_transmittance), LUTdye01), 'Border', 'Tight')
figure, imshow(ind2rgb(uint8(Dye02_transmittance), LUTdye02), 'Border', 'Tight')

% OUTPUT VISUALIZATION: LUTs IN THE IMAGEJFORMAT
LUTStain01_ImageJ = round(LUTdye01.*255); % Use this to obtain the same values of the ImageJ Colour Deconvolution plugin. Basically, it is a uint8 conversion with rounded values.
LUTStain02_ImageJ = round(LUTdye02.*255); % Use this to obtain the same values of the ImageJ Colour Deconvolution plugin. Basically, it is a uint8 conversion with rounded values.
LUTStain03_ImageJ = round(LUTdye03.*255); %