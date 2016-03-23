%% Reconocimiento de rostros
%@felipeseguel Abril-2015 PHP
% Pasos:
%1) Cambiar el tamaño de todas las imagenes .
%2) Calcular y Eliminar el promedio de todas las imagenes.
%3) Crearla matriz A de las imagenes cada fila N *N tamaño total es (N*N)*M
%4) Calcular la media cara
%5) Normaliza: Se toma una imagen, se le quita el promedio de todas las
%imagenes y se obtiene una nueva matriz 
%6) Con la nueva matriz se obtiene la matriz de covarianza C A'*A, tamaño C es M*M
%7) Calcular valores propios y vectores propios, para calcular los eigen
%8) Calcular la combinación lineal de cada rostro original


clear all; close all; clc;
N=100;          %Tamaño de la imagen  --> Jugar y dar dos valores
M=6;            %Numero de rostros
scrsz = get(0,'ScreenSize');  %Permite mostrar las figuras CuadroxCuadro
ancho = scrsz(3);    %1366px
alto  = scrsz(4);    %768px
ancho=round(ancho/3);
alto=round(alto/2)-40;

%% Paso01 Cargar la imagenes y redimensionar a NxN=80x80

%% Rostro 01

Rostro01= imread('eigen/SetEntremamiento/subject01.normal.jpg');
Rostro01=Rostro01( :, :,1);
Rostro01=imresize(Rostro01,[N N]);   % Se ajusta tamaño
figure('Position',[10 alto ancho alto]);
set(gcf,'Name','Base de Datos') 
subplot 231;
imshow(Rostro01,'Initialmagnification','fit');
title('Sujeto1Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

% Rostro 02
Rostro02Normal= imread('eigen/SetEntremamiento/subject02.normal.jpg');
Rostro02Normal=Rostro02Normal( :, :,1);
Rostro02Normal=imresize(Rostro02Normal,[N N] );
subplot 232;
imshow(Rostro02Normal,'Initialmagnification','fit'); 
title('Sujeto1Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

% Rostro 03
Rostro03Normal= imread('eigen/SetEntremamiento/subject03.normal.jpg');
Rostro03Normal=Rostro03Normal( :, :,1);
Rostro03Normal=imresize(Rostro03Normal,[N N] );
subplot 233;
imshow(Rostro03Normal,'Initialmagnification','fit'); 
title('Sujeto1sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

% Rostro 04
Rostro04Normal= imread('eigen/SetEntremamiento/subject04.normal.jpg');
Rostro04Normal=Rostro04Normal( :, :,1);
Rostro04Normal=imresize(Rostro04Normal,[N N] );
subplot 234;
imshow(Rostro04Normal,'Initialmagnification','fit'); 
title('Sujeto2Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

% Rostro 05
Rostro05Normal= imread('eigen/SetEntremamiento/subject05.normal.jpg');
Rostro05Normal=Rostro05Normal( :, :,1);
Rostro05Normal=imresize(Rostro05Normal,[N N] );
subplot 235;
imshow(Rostro05Normal,'Initialmagnification','fit');
title('Sujeto2Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

% Rostro 06
Rostro06Normal= imread('eigen/SetEntremamiento/subject06.normal.jpg');
Rostro06Normal=Rostro06Normal( :, :,1);
Rostro06Normal=imresize(Rostro06Normal,[N N] );
subplot 236;
imshow(Rostro06Normal,'Initialmagnification','fit'); 
title('Sujeto2Sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
grid on;axis tight;

%% Paso 02: Concatenar imagenes NxNxM
MC(:,:,1)=Rostro01;
MC(:,:,2)=Rostro02Normal;
MC(:,:,3)=Rostro03Normal;
MC(:,:,4)=Rostro04Normal;
MC(:,:,5)=Rostro05Normal;
MC(:,:,6)=Rostro06Normal;     %MC Matriz de NxNxM 80x80x6
%% Creamos estructura 
st.names = {'subject01','subject02','subject03',...
            'subject04','subject05','subject06'};
st.data{1}=Rostro01;
st.data{2}=Rostro02Normal;
st.data{3}=Rostro03Normal;
st.data{4}=Rostro04Normal;
st.data{5}=Rostro05Normal;
st.data{6}=Rostro06Normal;

%% Paso03 : Calculo de rostro promedio
avImg=zeros(N);
figure('Position',[ancho alto ancho alto])
set(gcf,'Name','Calculo de rostro promedio') 

for k=1:M
    st.data{k}=im2single(st.data{k});    %Convert image to single precision 
    avImg     = avImg + (1/M)*st.data{k}; 
    % Ultima iteración contiene promedio de todas las imagenes
    subplot(2,3,k),imshow(avImg,'Initialmagnification','fit');
    pause(1)
end
pause(3)

%% Paso 04: Resta del promedio a cada una de las imagenes

for k=1:M
    st.dataAvg{k} = st.data{k} - avImg;  %dataAvg= cada imagen- promedio total
end
% Declaración vector
z=[ st.dataAvg{1} st.dataAvg{2} st.dataAvg{3} st.dataAvg{4} st.dataAvg{5}...
    st.dataAvg{6}];
ZC(:,:,1)=st.dataAvg{1};
ZC(:,:,2)=st.dataAvg{2};
ZC(:,:,3)=st.dataAvg{3};
ZC(:,:,4)=st.dataAvg{4};
ZC(:,:,5)=st.dataAvg{5};
ZC(:,:,6)=st.dataAvg{6};
%%
figure('Position',[2*(ancho) alto ancho alto]); % Figure3
set(gcf,'Name','Resta del promedio a cada una de las imagenes') 
for k=1:M
    subplot(2,3,k)
    imshow(st.dataAvg{k},'Initialmagnification','fit');     %imshow(z)
    %pause(1)
end
pause(2);

%% Paso 04+1: Calculo de autovectores matriz de covarianza
% Generar vector A = [img1(:) img2(:)... imgM(:)];
A=zeros(N*N,M);   %Se llena vector con ceros

for k=1:M
    A(:,k)=st.dataAvg{k}(:);
end
%Matriz de covarianza de pequeña dimension (trasnpuesta)
C= A'*A;

% Vectores eigen en pequeñas dimensiones
[Veigvec,Deigval] = eig(C); 
%devuelve matriz diagonal Veigvec de valores propios y la matriz Deigval cuyas...
%columnas son los vectores propios correspondientes derecha
%%
Vlarge = A*Veigvec;
eigenfaces=[];

for k=1:M
    c=Vlarge(:,k);
    eigenfaces{k} = reshape(c,N,N); %Cambiar la forma de matriz
end
%%
x=diag(Deigval);
[xc,xci]=sort(x,'descend'); 
z= [eigenfaces{xci(1)} eigenfaces{xci(2)} eigenfaces{xci(3)};
    eigenfaces{xci(4)} eigenfaces{xci(5)} eigenfaces{xci(6)}];
figure('Position',[10 10 ancho alto]),
set(gcf,'Name','Eigenfaces');
imshow(z,'Initialmagnification','fit');
pause(5)

%%Patrones de reconocimiento
nsel=6 
for mi=1:M
    for k=1:nsel 
        wi(mi,k) = sum(A(:,mi).* eigenfaces{xci(k)}(:));
    end
end

%% Prueba de reconocimiento
% Clasificador de una nueva imagen
testFaceMic = imread('eigen/SetPrueba/subject01.glasses.jpg');

testFaceMic =testFaceMic( :, :,1);
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
% imwrite(s,'eigen/camara.jpg');
% closepreview(video1)
% testFaceMic = imresize(s,[N N]);
% testFaceMic = im2single(testFaceMic);

figure('Position',[ancho 10 ancho alto])
set(gcf,'Name','Imagen a detectar');
imshow(testFaceMic,'Initialmagnification','fit')
pause(3)
%%
Aface = testFaceMic(:)-avImg(:);  % Le restamos la media de los datos

for tt=1:nsel
    wface(tt) = sum(Aface.* eigenfaces{xci(tt)}(:));  %Multiplicación por eigenfaces
end

%% Calcula la distancia minima

for mi=1:M
    fsumcur=0;
    for(tt=1:nsel)
        fsumcur = fsumcur + (wface(tt)- wi(mi,tt)).^2;
    end
    diferencia(mi)=sqrt(fsumcur);
end
[val in]= min(diferencia);
figure('Position',[2*ancho 10 ancho alto])
%% Detecta Sujeto 01 o 02
if in<=3
imshow(st.data{1});   %in
title(['La imagen corresponde a ',st.names{1}])
else
imshow(st.data{4});   
title(['La imagen corresponde a ',st.names{4}])
end














