function [ImgR_back, ImgG_back, ImgB_back, Dye01_transmittance, Dye02_transmittance, Dye03_transmittance, LUTdye01, LUTdye02, LUTdye03, Q3x3Mat] = Colour_Seperation2(ImgR, ImgG, ImgB, colVectorID, DyeToBeRemovedID, doIcross)


%% INTERNAL PARAMETERS:
format long
[rowR, colR, nchR]  = size(ImgR);
Dye01_transmittance = zeros(rowR, colR);
Dye02_transmittance = zeros(rowR, colR);
Dye03_transmittance = zeros(rowR, colR);
ImgR_back           = zeros(rowR, colR);
ImgG_back           = zeros(rowR, colR);
ImgB_back          	= zeros(rowR, colR);
Const1ForNoLog0     = 0;
Const2ForNoLog0     = 0;


%% COEFFICIENTS CONNECTED TO THE colVectorID:
[SMrow, SMcol, SMnch]  = size(colVectorID);
if (SMrow==3 && SMcol==3 && SMnch==1)
    SM = colVectorID;
else
    
        error('ERROR: colVectorID is not correctly defined!');
    
end
        
    % "User values"
    MODx = [SM(1,1), SM(1,2), SM(1,3)];
    MODy = [SM(2,1), SM(2,2), SM(2,3)];
    MODz = [SM(3,1), SM(3,2), SM(3,3)];


%% COEFFICIENTS NORMALIZATION:

% Column-vector normalization to have 1 as final length of the columns in the 3D space.
len  = [0, 0, 0];
cosx = [0, 0, 0];
cosy = [0, 0, 0];
cosz = [0, 0, 0];
for i = 1:3
    len(i) = sqrt(MODx(i)*MODx(i) + MODy(i)*MODy(i) + MODz(i)*MODz(i)); % Normalization to have the lenght of the column equal to 1.
    if (len(i) ~= 0)
        cosx(i) = MODx(i)/len(i);
        cosy(i) = MODy(i)/len(i);
        cosz(i) = MODz(i)/len(i);
    end
end

% translation matrix
if (cosx(2)==0.0)
    if (cosy(2)==0.0)
        if (cosz(2)==0.0)
            %2nd colour is unspecified
            cosx(2)=cosz(1);
            cosy(2)=cosx(1);
            cosz(2)=cosy(1);
        end
    end
end

if cosx(3)==0.0
    if cosy(3)==0.0
        if cosz(3)==0.0
            %3rd colour is unspecified
            if doIcross==1
                cosx(3) = cosy(1) * cosz(2) - cosz(1) * cosy(2);
                cosy(3) = cosz(1) * cosx(2) - cosx(1) * cosz(2);
                cosz(3) = cosx(1) * cosy(2) - cosy(1) * cosx(2);
            else
                if ((cosx(1)*cosx(1) + cosx(2)*cosx(2))> 1)
                    %Colour_3 has a negative R component
                    cosx(3)=0.0;
                else
                    cosx(3)=sqrt(1.0-(cosx(1)*cosx(1))-(cosx(2)*cosx(2)));
                end

                if ((cosy(1)*cosy(1) + cosy(2)*cosy(2))> 1)
                    %Colour_3 has a negative G component
                    cosy(3)=0.0;
                else
                    cosy(3)=sqrt(1.0-(cosy(1)*cosy(1))-(cosy(2)*cosy(2)));
                end

                if ((cosz(1)*cosz(1) + cosz(2)*cosz(2))> 1)
                    %Colour_3 has a negative B component
                    cosz(3)=0.0;
                else 
                    cosz(3)=sqrt(1.0-(cosz(1)*cosz(1))-(cosz(2)*cosz(2)));
                end
            end
        end
    end
end

leng = sqrt(cosx(3)*cosx(3) + cosy(3)*cosy(3) + cosz(3)*cosz(3));
if (leng ~= 0 && leng ~= 1)
    cosx(3)= cosx(3)/leng;
    cosy(3)= cosy(3)/leng;
    cosz(3)= cosz(3)/leng;
end

COS3x3Mat = [cosx(1) cosy(1) cosz(1); ...
             cosx(2) cosy(2) cosz(2); ...
             cosx(3) cosy(3) cosz(3)];


%% MATRIX Q USED FOR THE COLOUR DECONVOLUTION:

% Check the determinant to understand if the matrix is invertible
if det(COS3x3Mat)>=-0.001 && det(COS3x3Mat)<=0.001
    % Check column 1
    if (COS3x3Mat(1,1)+COS3x3Mat(2,1)+COS3x3Mat(3,1)==0)
        cosx(1) = 0.001;
        cosx(2) = 0.001;
        cosx(3) = 0.001;
    end
    % Check column 2
    if (COS3x3Mat(1,2)+COS3x3Mat(2,2)+COS3x3Mat(3,2)==0)
        cosy(1) = 0.001;
        cosy(2) = 0.001;
        cosy(3) = 0.001;
    end
    % Check column 3
    if (COS3x3Mat(1,3)+COS3x3Mat(2,3)+COS3x3Mat(3,3)==0)
        cosz(1) = 0.001;
        cosz(2) = 0.001;
        cosz(3) = 0.001;
    end
    % Check row 1
    if (COS3x3Mat(1,1)+COS3x3Mat(1,2)+COS3x3Mat(1,3)==0)
        cosx(1) = 0.001;
        cosy(1) = 0.001;
        cosz(1) = 0.001;
    end
    % Check row 2
    if (COS3x3Mat(2,1)+COS3x3Mat(2,2)+COS3x3Mat(2,3)==0)
        cosx(2) = 0.001;
        cosy(2) = 0.001;
        cosz(2) = 0.001;
    end
    % Check row 3
    if (COS3x3Mat(3,1)+COS3x3Mat(3,2)+COS3x3Mat(3,3)==0)
        cosx(3) = 0.001;
        cosy(3) = 0.001;
        cosz(3) = 0.001;
    end
    % Check diagonal 1
    if (COS3x3Mat(1,1)+COS3x3Mat(2,2)+COS3x3Mat(3,3)==0)
        cosx(1) = 0.001;
        cosy(2) = 0.001;
        cosz(3) = 0.001;
    end
    % Check diagonal 2
    if (COS3x3Mat(1,3)+COS3x3Mat(2,2)+COS3x3Mat(3,1)==0)
        cosz(1) = 0.001;
        cosy(2) = 0.001;
        cosx(3) = 0.001;
    end
    
    COS3x3Mat = [cosx(1) cosy(1) cosz(1); ...
                 cosx(2) cosy(2) cosz(2); ...
                 cosx(3) cosy(3) cosz(3)];
    
    if det(COS3x3Mat)>=-0.001 && det(COS3x3Mat)<=0.001
        for k = 1:3
            if (cosx(k)==0); cosx(k)=0.001; end
            if (cosy(k)==0); cosy(k)=0.001; end
            if (cosz(k)==0); cosy(k)=0.001; end
        end
        
        COS3x3Mat = [cosx(1) cosy(1) cosz(1); ...
                     cosx(2) cosy(2) cosz(2); ...
                     cosx(3) cosy(3) cosz(3)];
                 
        if det(COS3x3Mat)>=-0.001 && det(COS3x3Mat)<=0.001         
            disp('WARNING: the vector matrix is non invertible! So, the images of the cols (e.r. images with names: Stain0#_transmittance, and Stain0#_LUT) are OK, but the images with name "Img#_back" are unreliable!');
        end
    end
end

A = cosy(2) - cosx(2) * cosy(1) / cosx(1);
V = cosz(2) - cosx(2) * cosz(1) / cosx(1);
C = cosz(3) - cosy(3) * V/A + cosx(3) * (V/A * cosy(1) / cosx(1) - cosz(1) / cosx(1));
q2 = (-cosx(3) / cosx(1) - cosx(3) / A * cosx(2) / cosx(1) * cosy(1) / cosx(1) + cosy(3) / A * cosx(2) / cosx(1)) / C;
q1 = -q2 * V / A - cosx(2) / (cosx(1) * A);
q0 = 1.0 / cosx(1) - q1 * cosy(1) / cosx(1) - q2 * cosz(1) / cosx(1);
q5 = (-cosy(3) / A + cosx(3) / A * cosy(1) / cosx(1)) / C;
q4 = -q5 * V / A + 1.0 / A;
q3 = -q4 * cosy(1) / cosx(1) - q5 * cosz(1) / cosx(1);
q8 = 1.0 / C;
q7 = -q8 * V / A;
q6 = -q7 * cosy(1) / cosx(1) - q8 * cosz(1) / cosx(1);
Q3x3Mat = [q0, q3, q6; q1, q4, q7; q2, q5, q8]; 
Q3x3MatInverted = COS3x3Mat; 

%% TRANSMITTANCE COMPUTATION:

for r = 1:rowR
    for c = 1:colR
        RGB1 = [ImgR(r,c), ImgG(r,c), ImgB(r,c)];
        if Const1ForNoLog0==0
            RGB1(RGB1==0)=1;
        end
        
        % Version1
        ACC = -log((RGB1+Const1ForNoLog0)./(255+Const1ForNoLog0));
        Dye01Dye02Dye03_Transmittance_v1 = 255.*exp(-ACC*Q3x3Mat);
        
        % Creation of the single mono-channels for the transmittance
        Dye01_transmittance(r,c) = Dye01Dye02Dye03_Transmittance_v1(1);
        Dye02_transmittance(r,c) = Dye01Dye02Dye03_Transmittance_v1(2);
        Dye03_transmittance(r,c) = Dye01Dye02Dye03_Transmittance_v1(3);
    end
end


rLUT = double(zeros(256,3));
gLUT = double(zeros(256,3));
bLUT = double(zeros(256,3));
for i= 1:3
    for j = 0:255
        if cosx(i)<0
            rLUT(256-j, i) = 255 + (j * cosx(i));
        else
            rLUT(256-j, i) = 255 - (j * cosx(i));
        end
        
        if cosy(i)<0
            gLUT(256-j, i) = 255 + (j * cosy(i));
        else
            gLUT(256-j, i) = 255 - (j * cosy(i));
        end
        
        if cosz(i)<0
            bLUT(256-j, i) = 255 + (j * cosz(i));
        else
            bLUT(256-j, i) = 255 - (j * cosz(i));
        end
    end
end

LUTdye01(:,1) = rLUT(:,1);
LUTdye01(:,2) = gLUT(:,1);
LUTdye01(:,3) = bLUT(:,1);
LUTdye02(:,1) = rLUT(:,2);
LUTdye02(:,2) = gLUT(:,2);
LUTdye02(:,3) = bLUT(:,2);
LUTdye03(:,1) = rLUT(:,3);
LUTdye03(:,2) = gLUT(:,3);
LUTdye03(:,3) = bLUT(:,3);
LUTdye01 = LUTdye01./255;
LUTdye02 = LUTdye02./255;
LUTdye03 = LUTdye03./255;

%% REMOVE THE CONTRIBUTION OF A col FROM THE RGB IMAGE:

% Select the stain to be removed:
if DyeToBeRemovedID == 1
    Dye01_transmittance = double(255.*ones(rowR, colR, 1));
elseif DyeToBeRemovedID == 2
    Dye02_transmittance = double(255.*ones(rowR, colR, 1));
elseif DyeToBeRemovedID == 3
    Dye03_transmittance = double(255.*ones(rowR, colR, 1));
end
    
% Use the Q3x3MatInverted to go back in RGB
for r = 1:rowR
    for c = 1:colR
        Dye01Dye02Dye03_transmittance = [Dye01_transmittance(r,c), Dye02_transmittance(r,c), Dye03_transmittance(r,c)];
        ACC2 = -log((Dye01Dye02Dye03_transmittance+Const2ForNoLog0)./(255+Const2ForNoLog0))*Q3x3MatInverted;
        RGB_backNoNorm = exp(-ACC2);
        RGB_back = (255.*RGB_backNoNorm);
        ImgR_back(r,c) = RGB_back(1);
        ImgG_back(r,c) = RGB_back(2);
        ImgB_back(r,c) = RGB_back(3);
    end
end
ImgR_back(ImgR_back>255) = 255;
ImgG_back(ImgG_back>255) = 255;
ImgB_back(ImgB_back>255) = 255;
ImgR_back(ImgR_back<0) = 0;
ImgG_back(ImgG_back<0) = 0;
ImgB_back(ImgB_back<0) = 0;
ImgR_back = floor(ImgR_back); 
ImgG_back = floor(ImgG_back); 
ImgB_back = floor(ImgB_back); 

%% OUTPUT SETTINGS:

format short
