%% Codigo pendiente:: convertir el área de estudio en una matriz cuadrada
% %Dejando fuera la zona NaN.

%%Convertir ndvi zona estudio en arreglo lineal
% 
% ndvi_prom = m_mean_3dpp(arr_ndvi);
% 
% vector_datos = 1:calidad_total;
% k=1;
% for i=1:ndvi_tam(1)
%     for j=1:ndvi_tam(2)
%         if(area_estudio(i,j)==true)
%             vector_datos(k) = ndvi_prom(i,j);
%             k=k+1;
%         end
%     end
% end

%% todas las imagenes

%convertir a gris 0-255
arr_ndvi_g =  arr_ndvi .* 255.0;

figure;
m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,arr_ndvi_g(:,:,35),"NDVI (0-255). Día 30/09/2001 ",3) 
m_dibujar_otras_areas(dir_data);
%pcolor(arr_ndvi_g(:,:,35)); shading interp;

%obtener el umbral
[tg,em] = graythresh(arr_ndvi_g);
disp("umbral: "+tg);

% % %binarizar de acuerdo al umbral
arr_ndvi_bw = imbinarize(arr_ndvi_g, tg*255);

%convertir a doble para aplicar mascara de area de estudio
arr_ndvi_bw = double(arr_ndvi_bw);
for i=1:filas
    tmp = arr_ndvi_bw(:,:,i);
    tmp(area_estudio==false)=nan;
    arr_ndvi_bw(:,:,i) = tmp ;
end

figure;
m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,arr_ndvi_bw(:,:,35),"NDVI Binarizado con umbral "+tg+" y efectividad: "+em+" (graythresh). Día 30/09/2001",3) 
m_dibujar_otras_areas(dir_data);


%% promedio del periodo 
arr_ndvi_promedio = m_mean_3dpp(arr_ndvi);
% Convertir a escala de grises
arr_ndvi_promedio_g =  arr_ndvi_promedio .* 255.0;

figure;
m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,arr_ndvi_promedio_g,"Promedio NDVI (0-255) ."+35,3) 
m_dibujar_otras_areas(dir_data);

% obtener el umbral
[tg,em] = graythresh(arr_ndvi_promedio_g);
disp("umbral: "+tg);

%binarizar
% % %binarizar de acuerdo al umbral
arr_ndvi_promedio_bw = imbinarize(arr_ndvi_promedio_g, tg*255);
arr_ndvi_promedio_bw = double(arr_ndvi_promedio_bw);
arr_ndvi_promedio_bw(area_estudio==false)=nan;

figure;
m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,arr_ndvi_promedio_bw,"Promedio NDVI Binarizado con umbral "+tg+" y efectividad: "+em+" (graythresh).",3) 
m_dibujar_otras_areas(dir_data);

figure;
m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,arr_ndvi_promedio_bw,"Titulo",[0 1],m_colmap('jet',256),"Label11"); 
m_dibujar_otras_areas(dir_data);



