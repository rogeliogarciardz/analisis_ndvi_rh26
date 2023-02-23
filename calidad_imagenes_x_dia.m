% Delimita la zona de estudio a la Región Hidrológica No 26 Pánuco
import matlab.io.hdfeos.*

clearvars -except area_estudio;
close all;

disp("...::: Iniciando programa Zona de estudio: Región Hidrológica 26 :::...");
debug_pausa = 1; %tiempo de pausa de imagenes
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

%matriz que delimita el area de estudio
%area_estudio = NaN;
load area_estudio;

%valor nulo
fuera= 0;

calidad_total_old = coord_1k_v6_tam(1) * (coord_1k_v6_tam(2)+coord_1k_v7_tam(2));
%% obtener la info del área de estudio
[lat,lon,ndvi] = m_zona_estudio(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
img_fechas = m_imagenes_fechas(dir_data);

%% obtener matriz 0,1 que delimitan el área de estudio
if( numel(area_estudio) <= 1)
    area_estudio = m_crear_area_estudio(dir_data+'KML\RH26.kml',lat,lon);
end
ndvi(area_estudio==0)=NaN;

calidad_total=sum(area_estudio,"all"); 

% dibujatr mapa de prueba
% m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi);
% dibujar otras areas en el mapa
% m_dibujarOtrasAreas(dir_data);

disp("Analisis de las imagenes");

[filas,~] = size(img_fechas);
disp("No de archivos: "+filas);

%arreglo de promedios de las imagenes
arr_promedio_dia_todo = zeros(1,filas);
arr_promedio_dia = zeros(1,filas);
arr_promedio_dia_md = zeros(1,filas);
arr_promedio_dia_lineal = zeros(1,filas);

arr_calidad_dia = zeros(1,filas);
%arr_fecha = zeros(1,filas);
fehca = "";

for i=1:filas
    disp("Analizando "+i+" de "+filas);
    [ndvi,~,~,disponibilidad] = m_obtener_ndvi(dir_data,img_fechas(i,:),coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
        
    % recortar el area de estudio
    ndvi(area_estudio==0)=NaN;
    disponibilidad(area_estudio==false)=NaN;

    % promedio ndvi con  nubes o nieve
    promedio_ndvi = mean(ndvi,'all','omitnan');
    arr_promedio_dia_todo(i) = promedio_ndvi;

    %omitir las zonas con nubes o nieve
    ndvi (disponibilidad>1)=NaN;

    % calcular la calidad de la imagen
    %calidad_total = numel( find(disponibilidad>=0));
    calidad = numel( find(disponibilidad==0)) + numel(find(disponibilidad==1));
    calidad = round(calidad* 100 / calidad_total,0);
    arr_calidad_dia(i) = calidad; 

    % promedio ndvi sin nubes o nieve
    promedio_ndvi = mean(ndvi,'all','omitnan');
    arr_promedio_dia(i) = promedio_ndvi;

%%% con 80% de calidad pasa el 99.0% (5) de las imágenes 
%%% con 85% de calidad pasa el 98.1% (10) de las imágenes 
%%% con 90% de calidad pasa el 93.4%  (34) de las imágenes
%%% con 95% de calidad pasa el 85.8%  (73) de las imágenes
%%% con 97% de calidad pasa el 78.8% (109) de las imágenes
%%% com 99% de calidad pasa el 63.2% (189) de las imágenes
%%% com 100% de calidad pasa el 40.6% (305) de las imágenes

     if calidad >= 95
        arr_promedio_dia_md(i) = promedio_ndvi;
     else
         arr_promedio_dia_md(i) = nan;
         fuera=fuera+1;
     end
    fecha = img_fechas{i,"dia"}+ "/"+img_fechas{i,"mes"}+"/"+img_fechas{i,"anio"};
    arr_fecha(i) = datetime( fecha,'InputFormat','dd/MM/yyyy');
    if debug_dibujar_mapa_ndvi == true 
        % dibujar el mapa
        m_dibujar_mapa_ndvi(lon_proyeccion,lat_proyeccion,lon,lat,ndvi,"RH 26 ("+img_fechas.dia(i)+"/"+img_fechas.mes(i)+"/"+img_fechas.anio(i)+") C: "+calidad);
        m_dibujarOtrasAreas(dir_data);
        pause (debug_pausa);
    end
end


disp("Fuera: "+fuera + " ("+ fuera*100/513+"%)");

 r_rmse = f_rmse(arr_promedio_dia_todo,arr_promedio_dia);
 r_mae = f_mae(arr_promedio_dia_todo,arr_promedio_dia);
disp("RMSE: "+r_rmse+ " MAE: "+r_mae);

limite = [1 513]; 

% % yyaxis left;
arr_promedio_dia_fill = fillmissing(arr_promedio_dia_md,'linear');
plot(arr_fecha(1,limite(1):limite(2)),arr_promedio_dia_fill(1,limite(1):limite(2)));

title('NDVI promedio x día del 2000 al 2022');
xlabel('Día');
ylabel('Promedio NDVI');
%xlim(limite);
ylim([0.3500 0.7300]);

hold on
plot(arr_fecha(1,limite(1):limite(2)),arr_promedio_dia_md(1,limite(1):limite(2)),'k',"LineWidth",2);
plot(arr_fecha(1,limite(1):limite(2)),arr_promedio_dia(1,limite(1):limite(2)),'r');
plot(arr_fecha(1,limite(1):limite(2)),arr_promedio_dia_todo(1,limite(1):limite(2)),'g--');

limite = [1 128]; % feb 2000 - dic 2004
[~,~,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
plot(arr_fecha(1,limite(1):limite(2)),yaj);

limite = [1 381]; % ene 2005 - dic 2016
[~,~,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
plot(arr_fecha(1,limite(1):limite(2)),yaj);

limite = [382 513]; % ene 2017 - sep 2022
[~,~,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
plot(arr_fecha(1,limite(1):limite(2)),yaj);

legend('NDVI interpolación lineal', 'NDVI sin días baja calidad (95%)', 'NDVI  sin nubes/nieve','NDVI real','Reg lin 2000-2005','Reg lin 2000-2016','Reg lin 2017-2022','Location','northwest','NumColumns',2);

hold off

% hold on
% limite = [1 105]; % feb 2000 - dic 2004
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% 
% limite = [105 220]; % ene 2005 - dic 2015
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% 
% limite = [220 335]; % ene 2016 - sep 2022
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% 
% limite = [335 450]; % ene 2016 - sep 2022
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% 
% limite = [450 513]; % ene 2005 - dic 2015
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% 
% limite = [1 513]; % ene 2016 - sep 2022
% [a0,a1,yaj] = m_reglin(limite(1):limite(2),arr_promedio_dia(1,limite(1):limite(2)));
% plot(arr_fecha(1,limite(1):limite(2)),yaj);
% hold off

sequia_mexico = readtable(dir_data+"CONAGUA\sequiaMexico.csv");

% yyaxis right
% 
% sm = sequia_mexico.Suma';
% [a0,a1,y] = m_reglin(1:319,sm);
% 
% plot(sequia_mexico.Fecha,sequia_mexico.Suma,sequia_mexico.Fecha,y');
% 
% ylabel("Sequía");
% 
% limite = [1 513]; 
% 
% yyaxis right
% plot(arr_fecha(1,limite(1):limite(2)),arr_calidad_dia(1,limite(1):limite(2)));
% ylabel("Calidad de imagen");
% %xlim(limite);
% ylim([70 100]);




