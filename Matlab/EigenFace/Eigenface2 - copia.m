%% Reconocimiento de Rostros
%@felipeseguel Abril-2015 PHP
clear all; close all; clc;
N=128;          %Tamaño de la imagen  --> Jugar y dar dos valores
M=9;            %Numero de rostros
scrsz = get(0,'ScreenSize');  %Permite mostrar las figuras CuadroxCuadro
ancho = scrsz(3);    %1366px
alto  = scrsz(4);    %768px
ancho=round(ancho/3);
alto=round(alto/2)-40;

% Paso01 Cargar la imagenes y redimensionar a NxN
%% Rostro 01
Rostro01Normal= imread('eigen/SetEntremamiento/subject01.normal.jpg');
Rostro01Normal=imresize(Rostro01Normal,[N N]);   % Se ajusta tamaño
figure('Position',[10 alto ancho alto]);set(gcf,'Name','Base de Datos') 
subplot 331;imshow(Rostro01Normal,'Initialmagnification','fit');
title('Sujeto1','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 02
Rostro02Normal= imread('eigen/SetEntremamiento/subject02.normal.jpg');
Rostro02Normal=imresize(Rostro02Normal,[N N] );
subplot 332;imshow(Rostro02Normal,'Initialmagnification','fit'); 
title('Sujeto2','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 03
Rostro03Normal= imread('eigen/SetEntremamiento/subject03.normal.jpg');
Rostro03Normal=imresize(Rostro03Normal,[N N] );
subplot 333;imshow(Rostro03Normal,'Initialmagnification','fit'); 
title('Sujeto3','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 04
Rostro04Normal= imread('eigen/SetEntremamiento/subject04.normal.jpg');
Rostro04Normal=imresize(Rostro04Normal,[N N] );
subplot 334;imshow(Rostro04Normal,'Initialmagnification','fit'); 
title('Sujeto4','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 05
Rostro05Normal= imread('eigen/SetEntremamiento/subject05.normal.jpg');
Rostro05Normal=imresize(Rostro05Normal,[N N] );
subplot 335;imshow(Rostro05Normal,'Initialmagnification','fit');
title('Sujeto5','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 06
Rostro06Normal= imread('eigen/SetEntremamiento/subject06.normal.jpg');
Rostro06Normal=imresize(Rostro06Normal,[N N] );
subplot 336;imshow(Rostro06Normal,'Initialmagnification','fit'); 
title('Sujeto6','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 07
Rostro07Normal= imread('eigen/SetEntremamiento/subject07.normal.jpg');
Rostro07Normal=imresize(Rostro07Normal,[N N] );
subplot 337;imshow(Rostro07Normal,'Initialmagnification','fit'); 
title('Sujeto7','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 08
Rostro08Normal= imread('eigen/SetEntremamiento/subject08.normal.jpg');
Rostro08Normal=imresize(Rostro08Normal,[N N] );
subplot 338;imshow(Rostro08Normal,'Initialmagnification','fit'); 
title('Sujeto8','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 09
Rostro09Normal= imread('eigen/SetEntremamiento/subject09.normal.jpg');
Rostro09Normal=imresize(Rostro09Normal,[N N] );
subplot 339;imshow(Rostro09Normal,'Initialmagnification','fit'); 
title('Sujeto9','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Concatenar imagenes 
MC(:,1)=Rostro01Normal(:);
MC(:,2)=Rostro02Normal(:);
MC(:,3)=Rostro03Normal(:);
MC(:,4)=Rostro04Normal(:);
MC(:,5)=Rostro05Normal(:);
MC(:,6)=Rostro06Normal(:);     
MC(:,7)=Rostro07Normal(:);
MC(:,8)=Rostro08Normal(:);
MC(:,9)=Rostro09Normal(:);
% Creamos estructura  
Gamma.names = {'subject01','subject02','subject03',...
                'subject04','subject05','subject06'};
%% Paso02 : Calculo de rostro promedio
Psi=zeros(N);
figure('Position',[ancho alto ancho alto])
set(gcf,'Name','Calculo de rostro promedio') 
Psi=mean(MC,2);
imshow(reshape(Psi,[N N]),[],'Initialmagnification','fit');

%% Paso 03: Resta del rostro promedio a cada una de las imagenes
for k=1:M
    Phi.dataAvg{k} = double(MC(:,k)) - Psi;  
end
% Declaración matriz ^ de NxNxM
Lambda=[Phi.dataAvg{1} Phi.dataAvg{2} Phi.dataAvg{3} ...
        Phi.dataAvg{4} Phi.dataAvg{5} Phi.dataAvg{6} ...
        Phi.dataAvg{7} Phi.dataAvg{8} Phi.dataAvg{9}];

figure('Position',[2*(ancho) alto ancho alto]); % Figure3
set(gcf,'Name','Resta del rostro promedio a cada una de las imagenes') 
for k=1:M
    subplot(3,3,k)
    imshow(reshape(Phi.dataAvg{k},[N N]),[],'Initialmagnification','fit'); 
end
pause(1);
%% Paso 04:Autovectores de la matriz de covarianza Lambda
% Paso a)
%Se obtiene la matriz de covarianza reducida
L=(1/M)*(Lambda).'*(Lambda);  % Matriz de MxM
% L=cov(Lambda.'); 
%Paso b)
% Calculo  autovectores y autovalores  
[autovectores,autovalores] = eig(L); 

%Paso c) u=\Lambda v
u = Lambda*autovectores;  %Cada calumna u representa vectPropio

%% reshape de EigenFace
eigenfaces=[];
for k=1:M
    c=u(:,k);
    eigenfaces{k} = reshape(c,N,N);
end
x=diag(autovalores);
[xc,xci]=sort(x,'descend'); 
LambdaNew= [eigenfaces{xci(1)} eigenfaces{xci(2)} eigenfaces{xci(3)};
            eigenfaces{xci(4)} eigenfaces{xci(5)} eigenfaces{xci(6)};
            eigenfaces{xci(7)} eigenfaces{xci(8)} eigenfaces{xci(9)}]; %Ordenado
figure('Position',[10 10 ancho alto]); %Figure4
set(gcf,'Name','Eigenfaces');
%imshow(LambdaNew,[]);
for k=1:3
    subplot(1,3,k)
    imshow(eigenfaces{xci(k)},[]);
end
figure('Position',[10 10 ancho alto]); %Figure4
set(gcf,'Name','Eigenfaces');
for s=4:6
    subplot(1,3,s)
    imshow(eigenfaces{xci(s)},[]);
end
figure('Position',[10 10 ancho alto]); %Figure4
set(gcf,'Name','Eigenfaces');
for x=7:9
    subplot(1,3,x)
    imshow(eigenfaces{xci(x)},[]);
end


%% Paso  05 Patrones de reconocimiento
% nsel=M;
% for var=1:M
%     for k=1:nsel 
%         wi(var,k) = sum(LLambda(:,var).* eigenfaces{xci(k)}(:));
%     end
% end
%%
% Clasificador de una nueva imagen
testFaceMic = imread('eigen/SetPrueba/subject01.happy.jpg');
testFaceMic =imresize(testFaceMic,[N N] );
testFaceMic =im2single(testFaceMic);

% Reconocimiento por camara web
% video1= videoinput('winvideo',1,'YUY2_320x240');
% info1=imaqhwinfo('winvideo',1);
% video1.BayerSensorAlignment='grbg';
% set(video1,'SelectedsourceName','input1')
% preview(video1)
% pause(2)
% s=getsnapshot(video1);
% s=s( :, :,1);
% imwrite(s,'eigen/Fotocamara.jpg');
% closepreview(video1)
% testFaceMic = imresize(s,[N N]);
% testFaceMic = im2single(testFaceMic);

figure('Position',[ancho 10 ancho alto])
set(gcf,'Name','Imagen a detectar');
imshow(testFaceMic,'Initialmagnification','fit')
pause(1)
%
PhiFace = testFaceMic(:)-Psi(:);  % Le restamos la media de los datos

% Proyección de la imagen normalizada en el espacio caracteristico.
for tt=1:nsel
    PhiBarra(tt) = sum(PhiFace.* eigenfaces{xci(tt)}(:));  %Multiplicación por eigenfaces
end

% Calcula la distancia minima
for mi=1:M
    fsumcur=0;
    for(tt=1:nsel)
        fsumcur = fsumcur + (PhiBarra(tt)- wi(mi,tt)).^2;
    end
    diferencia(mi)=sqrt(fsumcur);
end
[val, in]= min(diferencia);

figure('Position',[2*ancho 10 ancho alto])
set(gcf,'Name','Sujeto detectado');
% Detecta Sujeto
imshow(reshape(MC(:,in),[N N]),[]);title(['La imagen corresponde a ',Gamma.names{in}])















