% Delimita la zona de estudio a la Región Hidrológica No 26 Pánuco
import matlab.io.hdfeos.*

clearvars -except area_estudio;
close all;

disp("...::: Iniciando programa Zona de estudio: Región Hidrológica 26 :::...");
debug_pausa = 2; %tiempo de pausa de imagenes
debug_dibujar_mapa_ndvi = false;  %dibujar los mapas con el ndvi

%%Declarar las variables del proyecto
declaraciones


%calidad_total = coord_1k_v6_tam(1) * (coord_1k_v6_tam(2)+coord_1k_v7_tam(2));
%% obtener la info del área de estudio
[lat,lon,ndvi] = m_leer_dir_hdfs(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
img_fechas = m_infohdfs2table(dir_data);

%matriz que delimita el area de estudio
ae = exist("area_estudio","var");
if ae == 0
    ae = exist("area_estudio.mat","file");
    if ae == 2
        disp(">>> Cargando área de estudio");
        load area_estudio;
    else
        area_estudio = m_crear_area_estudio(dir_data+'KML\RH26.kml',lat,lon);
    end
else
    if( numel(area_estudio) <= 1)
        disp("La variable area_estudio sera sustituida");
        area_estudio = m_crear_area_estudio(dir_data+'KML\RH26.kml',lat,lon);
    end
end

ndvi(area_estudio==false)=NaN;
calidad_total = sum(area_estudio,"all");

% dibujatr mapa de prueba
% m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi);
% dibujar otras areas en el mapa
% m_dibujarOtrasAreas(dir_data);

disp("Analisis de las imagenes");

tmp =  find(  img_fechas.anio >= 2000 & img_fechas.anio <= 2022 );
img_fechas_consulta = img_fechas(tmp,:);

[filas,~] = size(img_fechas_consulta);
disp("No de archivos: "+filas);

%arreglo de promedios de las imagenes
arr_promedio_dia = zeros(1,filas);
arr_calidad_dia = zeros(1,filas);

arr_promedio_completez = zeros(1,filas);
arr_promedio_completez_premium = zeros(1,filas);
arr_promedio_nubes_nieve = zeros(1,filas);

arr_ndvi = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
arr_disponibilidad = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
arr_completez = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
arr_completez_premium = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
arr_nubes_nieve =  zeros( ndvi_tam(1),ndvi_tam(2) ,filas);

for i=1:filas
    disp("Analizando "+i+" de "+filas);
    [ndvi,~,~,disponibilidad] = m_obtener_ndvi(dir_data,img_fechas_consulta(i,:),coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);

    %img_fechas_consulta
    % recortar el area de estudio
    ndvi(area_estudio==false)=NaN;
    disponibilidad(area_estudio==false)=NaN;

    %obtener la calidad
    img_fechas_consulta.Calidad(i) = m_calidad_imagen(disponibilidad,calidad_total);

    %disp("> Calidad: "+img_fechas_consulta.Calidad(i));
    %quitar las nubes y nieve y demas pixeles anomalos
    ndvi (disponibilidad>1 & disponibilidad < 0)=NaN;

    %quitar los valores faltantes como nueva clase 5
    disponibilidad(disponibilidad<0)=5;

    completez = disponibilidad;
    completez_premium = disponibilidad;
    nubes_nieve = disponibilidad;

    completez(disponibilidad >=0 & disponibilidad<=1) = 1;
    completez(disponibilidad>1) = 0;

    completez_premium(disponibilidad == 0 ) = 1;
    completez_premium(disponibilidad > 0) = 0;

    nubes_nieve(disponibilidad == 2 | disponibilidad == 3) = 1;
    nubes_nieve(disponibilidad < 2 | disponibilidad > 3) = 0;

    %guardar en arreglo de ndvi y disponibilidad
    arr_ndvi(:,:,i) = ndvi;
    arr_disponibilidad(:,:,i) = disponibilidad;
    arr_completez(:,:,i) = completez;
    arr_completez_premium(:,:,i) = completez_premium;
    arr_nubes_nieve(:,:,i) = nubes_nieve;

    % calcular la calidad de la imagen
    arr_calidad_dia(i) =  img_fechas_consulta.Calidad(i);

    % promedio ndvi 
    promedio_ndvi = mean(ndvi,'all','omitnan');
    arr_promedio_dia(i) = promedio_ndvi;
    arr_promedio_completez(i) = sum(completez,"all","omitnan") / calidad_total *100 ;
    arr_promedio_completez_premium(i) = sum(completez_premium,"all","omitnan")  / calidad_total *100;
    arr_promedio_nubes_nieve(i) = sum(nubes_nieve,"all","omitnan")  / calidad_total *100;

    if debug_dibujar_mapa_ndvi == true 
        % dibujar el mapa
        m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi,"RH 26 ("+img_fechas_consulta.dia(i)+"/"+img_fechas_consulta.mes(i)+"/"+img_fechas_consulta.anio(i)+") C: "+calidad);
        m_dibujar_otras_areas(dir_data);
        pause (debug_pausa);
    end
    
end

elid="ban_cpp";