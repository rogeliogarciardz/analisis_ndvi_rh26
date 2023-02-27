% Delimita la zona de estudio a la Región Hidrológica No 26 Pánuco
import matlab.io.hdfeos.*

clearvars -except area_estudio;
close all;

disp("...::: Iniciando programa Zona de estudio: Región Hidrológica 26 :::...");
debug_pausa = 5; %tiempo de pausa de imagenes
debug_dibujar_mapa_ndvi = true;  %dibujar los mapas con el ndvi

%directorio de datos
dir_data = "D:\DATA\";

%Rango de datos region a analizar de todo el municipio de tantoyuca
lon_proyeccion = [-101.35 -97.70];
lat_proyeccion = [ 19.05  23.96];

%Ventana para el mapa tantoyuca
lon_mapa = [-101.35 -97.70];
lat_mapa = [ 19.05  23.96];

%cuadrante de inicio y tamaño del area de estudio
coord_1k_v6_inicio = [684 724];
coord_1k_v6_tam = [473 476];
%h08v06
coord_1k_v7_inicio = [684 0];
coord_1k_v7_tam = [473 115];

%ndvi_tam = [473 591];

%matriz que delimita el area de estudio
%area_estudio = NaN;
load area_estudio;

calidad_total = coord_1k_v6_tam(1) * (coord_1k_v6_tam(2)+coord_1k_v7_tam(2));
%% obtener la info del área de estudio
[lat,lon,ndvi] = m_zona_estudio(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
img_fechas = m_imagenes_fechas(dir_data);
ndvi_tam = size(ndvi);
%% obtener matriz 0,1 que delimitan el área de estudio
if( numel(area_estudio) <= 1)
    area_estudio = m_crear_area_estudio(dir_data+'KML\CuencaPanucoGood.kml',lat,lon);
end
ndvi(area_estudio==false)=NaN;

%% Analisis de imagenes
disp("Analisis de las imagenes  por año");


% indicar los años a analizar
anios = 2020:2022;

tabla_datos_anios =zeros(1,length(anios));

arr_ndvi = zeros( ndvi_tam(1),ndvi_tam(2) ,length(anios));


for a = 1:length(anios)
        tmp =  find(  img_fechas.anio == anios(a)  );

        %tmp =  find(   img_fechas.mes==9);
        img_fechas_consulta = img_fechas(tmp,:);
        
        [filas,~] = size(img_fechas_consulta);
        disp("Año: "+anios(a) +". No de archivos: "+filas);
        
        %arreglo de promedios de las imagenes
        arr_promedio = zeros(1,filas);

        arr_ndvi_anio  = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
        
        for i=1:filas
            %disp("Analizando "+i+" de "+filas);
            [ndvi,~,~,disponibilidad] = m_obtener_ndvi(dir_data,img_fechas_consulta(i,:),coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
        
            % recortar el area de estudio
            ndvi(area_estudio==false)=NaN;
            disponibilidad(area_estudio==false)=NaN;

            %omitir las zonas con nubes o nieve
            ndvi (disponibilidad>1)=NaN;
            disponibilidad(disponibilidad>1)=NaN;
        
            % calcular la calidad de la imagen
            calidad = numel( find(disponibilidad==0)) + numel(find(disponibilidad==1));
            calidad = round(calidad* 100 / calidad_total,0);
        
            % promedio ndvi 
            promedio_ndvi = mean(ndvi,'all','omitnan');
            arr_promedio(i) = promedio_ndvi;
        
            arr_ndvi_anio(:,:,i) = ndvi;
            
       
        end
    prom_anio =  mean(arr_promedio,"all");
    tabla_datos_anios(a) = prom_anio;
    %% TODO obtener promedio por el año
    
    ndvi_promedio_anio = m_mean_3dpp(arr_ndvi_anio);
    arr_ndvi(:,:,a) = ndvi_promedio_anio; %promedio año


    if debug_dibujar_mapa_ndvi == true 
        % dibujar el mapa
        m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi_promedio_anio,"RH 26 ("+img_fechas_consulta.anio(i)+")");
        m_dibujarOtrasAreas(dir_data,"RH26_prom_anio_"+img_fechas_consulta.anio(i)+"-)");
        pause (debug_pausa);
        
    end


end

[m1,m1std] = m_mean_3dpp(arr_ndvi);

% dibujar el mapa del promedio de todos los años
m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,m1,"RH 26");
m_dibujarOtrasAreas(dir_data,"RH26_prom_anio_"+img_fechas_consulta.anio(i)+"-)");
pause (debug_pausa);

 % dibujar el mapa de la desviación estandar 
m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,m1std,"RH 26");
m_dibujarOtrasAreas(dir_data,"RH26_prom_anio_"+img_fechas_consulta.anio(i)+"-)");
pause (debug_pausa);



grid;
title('NDVI promedio x año')
xlabel('Año')
ylabel('Promedio NDVI')
xlim([2000 2021]);
plot(anios,tabla_datos_anios);
%ylim([1000 3500]);

% hold on
% [a0,a1,yaj] = m_reglin(2000:2015,tabla_datos_anios(1:16));
% plot(2000:2015,yaj);
% 
% [a0,a1,yaj] = m_reglin(2015:2022,tabla_datos_anios(16:23));
% plot(2015:2022,yaj);
% hold off
