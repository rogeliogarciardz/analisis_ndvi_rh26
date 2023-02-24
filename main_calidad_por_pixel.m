% Delimita la zona de estudio a la Región Hidrológica No 26 Pánuco
import matlab.io.hdfeos.*

clearvars -except area_estudio;
close all;

disp("...::: Iniciando programa Zona de estudio: Región Hidrológica 26 :::...");
debug_pausa = 2; %tiempo de pausa de imagenes
debug_dibujar_mapa_ndvi = false;  %dibujar los mapas con el ndvi

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

ndvi_tam = [473 591];

%matriz que delimita el area de estudio
%area_estudio = NaN;
load area_estudio;


%calidad_total = coord_1k_v6_tam(1) * (coord_1k_v6_tam(2)+coord_1k_v7_tam(2));
%% obtener la info del área de estudio
[lat,lon,ndvi] = m_zona_estudio(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
img_fechas = m_imagenes_fechas(dir_data);

%% obtener matriz 0,1 que delimitan el área de estudio
if( numel(area_estudio) <= 1)
    area_estudio = m_crear_area_estudio(dir_data+'KML\CuencaPanucoGood.kml',lat,lon);
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

arr_ndvi = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);
arr_disponibilidad = zeros( ndvi_tam(1),ndvi_tam(2) ,filas);

for i=1:filas
    disp("Analizando "+i+" de "+filas);
    [ndvi,~,~,disponibilidad] = m_obtener_ndvi(dir_data,img_fechas_consulta(i,:),coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);

    % recortar el area de estudio
    ndvi(area_estudio==false)=NaN;
    disponibilidad(area_estudio==false)=NaN;

    %quitar las nubes y nieve y demas pixeles anomalos
    ndvi (disponibilidad>1 & disponibilidad < 0)=NaN;

    %quitar los valores faltantes 
    disponibilidad(disponibilidad<0)=nan;


    %guardar en arreglo de ndvi y disponibilidad
    arr_ndvi(:,:,i) = ndvi;
    arr_disponibilidad(:,:,i) = disponibilidad;

    % calcular la calidad de la imagen
    calidad = numel( find(disponibilidad==0)) + numel(find(disponibilidad==1));
    calidad = round(calidad* 100 / calidad_total,0);
    arr_calidad_dia(i) = calidad; 

    % promedio ndvi 
    promedio_ndvi = mean(ndvi,'all','omitnan');
    arr_promedio_dia(i) = promedio_ndvi;

    %
    
    if debug_dibujar_mapa_ndvi == true 
        % dibujar el mapa
        m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi,"RH 26 ("+img_fechas_consulta.dia(i)+"/"+img_fechas_consulta.mes(i)+"/"+img_fechas_consulta.anio(i)+") C: "+calidad);
        m_dibujarOtrasAreas(dir_data);
        pause (debug_pausa);
    end
    
end

map_disponibilidad = permute(arr_disponibilidad,[1 3 2]);
map_disponibilidad = mean(map_disponibilidad,2,'omitnan');
map_disponibilidad = reshape(map_disponibilidad,[ndvi_tam(1),ndvi_tam(2)]);

map_disponibilidad(map_disponibilidad>0.5)=nan;

m_proj('lambert','long',lon_mapa,'lat',lat_mapa,'rectbox','on');
m_gshhs_i('color','k');
colormap( m_colmap('jet',6) );
%colormap( flipud(m_colmap('mBOD',256)) );
m_pcolor(lon,lat,map_disponibilidad); %shading faceted ;
m_grid('linestyle','none','tickdir','out','linewidth',2);
%clim([-0.01 0.01]);

m_ruler([.05 .25],.1,4,'fontsize',7)

colorbar('eastoutside');
c = colorbar;
c.Label.String = "Disponibilidad";
m_dibujarOtrasAreas(dir_data,"Calidad x pixel");
m_northarrow(-101,23,.4,'type',2);
