function ColorSeperation(colx, coly, imagePath)
    % Define the col vectors
    colz = [0.0017788203982774002, 0.37428637616843113, 0.6253306816801527];

    % Create the color vector matrix
    colVectorID = [colx; coly; colz];

    % Read the image
    ImgRGB = double(imread(imagePath));
    DyeToBeRemovedID = 0;
    doIcross = 1;

    % Display original image
    figure, imshow(uint8(ImgRGB), [], 'Border', 'Tight')
    ImgR = ImgRGB(:,:,1);
    ImgG = ImgRGB(:,:,2);
    ImgB = ImgRGB(:,:,3);

    % Perform Colour Deconvolution
    [ImgR_back, ImgG_back, ImgB_back, Dye01_transmittance, Dye02_transmittance, ~, LUTdye01, LUTdye02, ~, ~] = Colour_Seperation2(ImgR, ImgG, ImgB, colVectorID, DyeToBeRemovedID, doIcross);
    ImgRGB_back(:,:,1) = ImgR_back;
    ImgRGB_back(:,:,2) = ImgG_back;
    ImgRGB_back(:,:,3) = ImgB_back;

    % Display the results of color deconvolution
    figure, imshow(ind2rgb(uint8(Dye01_transmittance), LUTdye01), 'Border', 'Tight')
    figure, imshow(ind2rgb(uint8(Dye02_transmittance), LUTdye02), 'Border', 'Tight')
end
