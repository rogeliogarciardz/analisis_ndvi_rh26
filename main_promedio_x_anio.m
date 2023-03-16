% Delimita la zona de estudio a la Región Hidrológica No 26 Pánuco
import matlab.io.hdfeos.*

clearvars -except area_estudio;
close all;

disp("...::: Iniciando programa Zona de estudio: Región Hidrológica 26 :::...");
debug_pausa = 5; %tiempo de pausa de imagenes
debug_dibujar_mapa_ndvi = false;  %dibujar los mapas con el ndvi

%%Declarar las variables del proyecto
declaraciones

%% obtener la info del área de estudio
[lat,lon,ndvi] = m_leer_dir_hdfs(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
img_fechas = m_infohdfs2table(dir_data);
ndvi_tam = size(ndvi);

%% obtener matriz 0,1 que delimitan el área de estudio
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

%% Analisis de imagenes
disp("Analisis de las imagenes  por año");
% indicar los años a analizar
anios = 2000:2022;
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
        
            calidad = m_calidad_imagen(disponibilidad,calidad_total);
        
            % promedio ndvi si es de buena calidad, sino nan
            if calidad >=95
                promedio_ndvi = mean(ndvi,'all','omitnan');
                arr_promedio(i) = promedio_ndvi;
                arr_ndvi_anio(:,:,i) = ndvi;
            else
                arr_promedio(i) = nan;
                arr_ndvi_anio(:,:,i) = nan;
            end

            pcolor(arr_ndvi_anio(:,:,i)); shading interp;
      
        end

    prom_anio =  mean(arr_promedio,"all","omitnan");
    tabla_datos_anios(a) = prom_anio;
    %% TODO obtener promedio por el año
    
    ndvi_promedio_anio = m_mean_3dpp(arr_ndvi_anio);
    arr_ndvi(:,:,a) = ndvi_promedio_anio; %promedio año

    if debug_dibujar_mapa_ndvi == true 
        % dibujar el mapa
        m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi_promedio_anio,"RH 26 ("+img_fechas_consulta.anio(i)+")",1);
        m_dibujar_otras_areas(dir_data,"RH26_prom_anio_"+img_fechas_consulta.anio(i)+"-)");
        pause (debug_pausa);
        
    end
end

elid = "ban_pxa";