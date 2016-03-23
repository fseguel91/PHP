%% Reconocimiento de rostros
% Abril-2015 PHP Clasificador Euclidiano 

close all; clear all; clc;

N=200;         %Tamaño de la imagen  --> Jugar y dar dos valores
M=6;           %Numero de rostros
scrsz = get(0,'ScreenSize');  %Permite mostrar las figuras CuadroxCuadro
ancho = scrsz(3);    %1366px
alto  = scrsz(4);    %768px
ancho=round(ancho/3);
alto=round(alto/2)-40;

%% Paso01 Cargar la imagenes de 2 Sujetos
%% Rostro 01
Rostro01= imread('eigen/SetEntremamiento/subject01.normal.jpg');
Rostro01=Rostro01( :, :,1);
Rostro01=imresize(Rostro01,[N N]);   % Se ajusta tamaño NxN
h1=imhist(Rostro01);
figure('Position',[10 alto ancho alto]);
set(gcf,'Name','Base de Datos') ;
subplot 231;
imshow(Rostro01,'Initialmagnification','fit');
title('Sujeto1Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 02
Rostro01Sad= imread('eigen/SetEntremamiento/subject01.sad.jpg');
Rostro01Sad=Rostro01Sad( :, :,1);
Rostro01Sad=imresize(Rostro01Sad,[N N] );
h2=imhist(Rostro01Sad);
subplot 232;
imshow(Rostro01Sad,'Initialmagnification','fit'); 
title('Sujeto1Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 03
Rostro01Sleepy= imread('eigen/SetEntremamiento/subject01.sleepy.jpg');
Rostro01Sleepy=Rostro01Sleepy( :, :,1);
Rostro01Sleepy=imresize(Rostro01Sleepy,[N N] );
h3=imhist(Rostro01Sleepy);
subplot 233;
imshow(Rostro01Sleepy,'Initialmagnification','fit'); 
title('Sujeto1sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 04
Rostro02= imread('eigen/SetEntremamiento/subject02.normal.jpg');
Rostro02=Rostro02( :, :,1);
Rostro02=imresize(Rostro02,[N N] );
h4=imhist(Rostro02);
subplot 234;
imshow(Rostro02,'Initialmagnification','fit'); 
title('Sujeto2Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 05
Rostro02Sad= imread('eigen/SetEntremamiento/subject02.sad.jpg');
Rostro02Sad=Rostro02Sad( :, :,1);
Rostro02Sad=imresize(Rostro02Sad,[N N] );
h5=imhist(Rostro02Sad);
subplot 235;
imshow(Rostro02Sad,'Initialmagnification','fit');
title('Sujeto2Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 06
Rostro02Sleepy= imread('eigen/SetEntremamiento/subject02.sleepy.jpg');
Rostro02Sleepy=Rostro02Sleepy( :, :,1);
Rostro02Sleepy=imresize(Rostro02Sleepy,[N N] );
h6=imhist(Rostro02Sleepy);
subplot 236;
imshow(Rostro02Sleepy,'Initialmagnification','fit'); 
title('Sujeto2Sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');


%% Creamos estructura 
st.names = {'subject01','subject02','subject03',...
            'subject04','subject05','subject06'};
st.data{1}=Rostro01;
st.data{2}=Rostro01Sad;
st.data{3}=Rostro01Sleepy;
st.data{4}=Rostro02;
st.data{5}=Rostro02Sad;
st.data{6}=Rostro02Sleepy;
% 
% % Calculo de la media de Clases
% avImgSujeto1=zeros(N);
% avImgSujeto2=zeros(N);
% figure('Position',[ancho alto ancho alto])
% set(gcf,'Name','Calculo de promedio Clase 1 y 2');
% %Promedio Clase 1
% for k=1:3
%     st.data{k}=im2single(st.data{k});
%     avImgSujeto1= avImgSujeto1+(1/3)*st.data{k};
%     subplot(2,3,k)
%     imshow(avImgSujeto1,'Initialmagnification','fit');
%     pause(1)
% end
% %Promedio Clase 2
% for k=4:M
%     st.data{k}=im2single(st.data{k});
%     avImgSujeto2= avImgSujeto2+(1/3)*st.data{k};
%     subplot(2,3,k)
%     imshow(avImgSujeto2,'Initialmagnification','fit');
%     pause(1)
% end

%% Nueva imagen
testFaceMic = imread('eigen/SetPrueba/subject01.happy.jpg');
testFaceMic =testFaceMic( :, :,1);
testFaceMic =imresize(testFaceMic,[N N] );
h7=imhist(testFaceMic);
%testFaceMic =im2single(testFaceMic);
figure('Position',[2*(ancho) alto ancho alto]);
set(gcf,'Name','Imagen a Clasificar');
imshow(testFaceMic,'Initialmagnification','fit')
%%

E1_distancia=sqrt(sum((h1-h7).^2));
E2_distancia=sqrt(sum((h2-h7).^2));
E3_distancia=sqrt(sum((h3-h7).^2));
E4_distancia=sqrt(sum((h4-h7).^2));
E5_distancia=sqrt(sum((h5-h7).^2));
E6_distancia=sqrt(sum((h6-h7).^2));

%% Calcula la distancia minima
EucliMin=[E1_distancia E2_distancia E3_distancia,...
             E4_distancia E5_distancia E6_distancia];
%figure('Position',[ancho 10 ancho alto])
ImagenElegidaMin=min(EucliMin);
figure('Position',[2*ancho 10 ancho alto])
for k=1:6
    if ImagenElegidaMin==EucliMin(k)
    imshow(st.data{k},'Initialmagnification','fit');  
    title(['La imagen corresponde a ',st.names{k}])
    end
end






    
    
