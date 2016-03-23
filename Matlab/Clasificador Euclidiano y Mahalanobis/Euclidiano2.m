%% Reconocimiento de rostros
% Abril-2015 PHP Clasificador Euclidiano y Mahalanobis

close all; clear all; clc;

N=128;         %Tamaño de la imagen  --> Jugar y dar dos valores
M=9;           %Numero de rostros
scrsz = get(0,'ScreenSize');  %Permite mostrar las figuras CuadroxCuadro
ancho = scrsz(3);    %1366px
alto  = scrsz(4);    %768px
ancho=round(ancho/3);
alto=round(alto/2)-40;

% Paso01 Cargar la imagenes de 2 Sujetos
% Rostro 01
X01= imread('eigen/SetEntremamiento/subject01.normal.jpg');
X01=imresize(X01,[N N]);   % Se ajusta tamaño NxN
figure('Position',[10 alto ancho alto]);set(gcf,'Name','Base de Datos') ;
subplot 331;imshow(X01,'Initialmagnification','fit');
title('Sujeto1Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 02
X02= imread('eigen/SetEntremamiento/subject01.sad.jpg');
X02=imresize(X02,[N N] );
subplot 332;imshow(X02,'Initialmagnification','fit'); 
title('Sujeto1Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 03
X03= imread('eigen/SetEntremamiento/subject01.sleepy.jpg');
X03=imresize(X03,[N N] );
subplot 333;imshow(X03,'Initialmagnification','fit'); 
title('Sujeto1sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 04
Y01= imread('eigen/SetEntremamiento/subject02.normal.jpg');
Y01=imresize(Y01,[N N] );
subplot 334;imshow(Y01,'Initialmagnification','fit'); 
title('Sujeto2Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 05
Y02= imread('eigen/SetEntremamiento/subject02.sad.jpg');
Y02=imresize(Y02,[N N] );
subplot 335;imshow(Y02,'Initialmagnification','fit');
title('Sujeto2Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 06
Y03= imread('eigen/SetEntremamiento/subject02.sleepy.jpg');
Y03=imresize(Y03,[N N] );
subplot 336;imshow(Y03,'Initialmagnification','fit'); 
title('Sujeto2Sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 07
S01= imread('eigen/SetEntremamiento/subject03.normal.jpg');
S01=imresize(S01,[N N] );
subplot 337;imshow(S01,'Initialmagnification','fit'); 
title('Sujeto3Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 08
S02= imread('eigen/SetEntremamiento/subject03.sad.jpg');
S02=imresize(S02,[N N] );
subplot 338;imshow(S02,'Initialmagnification','fit'); 
title('Sujeto3Sad','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% Rostro 09
S03= imread('eigen/SetEntremamiento/subject03.sleepy.jpg');
S03=imresize(S03,[N N] );
subplot 339;imshow(S03,'Initialmagnification','fit'); 
title('Sujeto3Sleepy','Fontsize',12,'FontName','Helvetica','FontWeight','demi');

%% Paso02
%Concatenar imagenes NxNxM(Cubo)
XBarra(:,1)=X01(:);XBarra(:,2)=X02(:);XBarra(:,3)=X03(:);
YBarra(:,1)=Y01(:);YBarra(:,2)=Y02(:);YBarra(:,3)=Y03(:);
SBarra(:,1)=S01(:);SBarra(:,2)=S02(:);SBarra(:,3)=S03(:);    
%% Paso03
XEntrenamiento=mean(double(XBarra),2);
YEntrenamiento=mean(double(YBarra),2);
SEntrenamiento=mean(double(SBarra),2);
%% Paso04Nueva imagen
Z01 = imread('eigen/SetPrueba/subject03.wink.jpg');
Z01 =imresize(Z01,[N N] );
ZBarra(:,1)=Z01(:);
figure('Position',[(ancho) alto ancho alto]);
set(gcf,'Name','Imagen de Prueba');
imshow(Z01,'Initialmagnification','fit')
% Euclidiano
DxEuclidian=norm(XEntrenamiento-double(ZBarra));
DyEuclidian=norm(YEntrenamiento-double(ZBarra));
DsEuclidian=norm(SEntrenamiento-double(ZBarra));
DminE=min([DxEuclidian,DyEuclidian,DsEuclidian]);

figure('Position',[2*(ancho) alto ancho alto]); % Figure3
set(gcf,'Name','Sujeto Clasificador Euclidiano') 
    if DminE==DxEuclidian
       imshow(X01,'Initialmagnification','fit');
       title('Sujeto1Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
    elseif DminE==DyEuclidian
       imshow(Y01,'Initialmagnification','fit'); 
       title('Sujeto2Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
    else
       imshow(S01,'Initialmagnification','fit'); 
       title('Sujeto3Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
    end


%% Mahalanobis

% %Concatenar imagenes NxNxM(Cubo)
% X1Barra(:,1)=double(X01(:));X1Barra(:,2)=double(X02(:));X1Barra(:,3)=double(X03(:));
% Y1Barra(:,1)=double(Y01(:));Y1Barra(:,2)=double(Y02(:));Y1Barra(:,3)=double(Y03(:));  
% S1Barra(:,1)=double(S01(:));S1Barra(:,2)=double(S02(:));S1Barra(:,3)=double(S03(:));  
% 
% %%
% 
%     DxMahal=mahal(X1Barra.',double(ZBarra.'));
%     DyMahal=mahal(Y1Barra.',double(ZBarra.'));
%     DsMahal=mahal(S1Barra.',double(ZBarra.'));
% 
% %%
% DminM=min([DxMahal,DyMahal,DsMahal]);  %3 minimos por DMahal
% figure('Position',[ancho 10 ancho alto])
% set(gcf,'Name','Clasificador Mahalanobis');
% if DminM(1:3)==min(DxMahal)
%     imshow(X01,'Initialmagnification','fit');
%     title('Sujeto1Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% elseif DminM(4:6)==min(DyMahal)
%     imshow(Y01,'Initialmagnification','fit'); 
%     title('Sujeto2Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% else
%     imshow(S01,'Initialmagnification','fit'); 
%     title('Sujeto3Normal','Fontsize',12,'FontName','Helvetica','FontWeight','demi');
% end
% 






    
    
