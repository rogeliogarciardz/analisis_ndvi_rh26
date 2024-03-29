%% Declaración de variables globales al proyecto 

disp(">>> Declarando variables...ok")

%directorio de datos
dir_data = "D:\DATA\";

%Rango de datos region a analizar de todo el municipio de tantoyuca
%lon_proyeccion = [-101.35 -97.70];
%lat_proyeccion = [ 19.05  23.96];

%Ventana para el mapa region hidrografica rio panuco
lon_mapa = [-101.6 -97.40];
lat_mapa = [ 18.7  24.3];

%cuadrante de inicio y tamaño del area de estudio
coord_1k_v6_inicio = [684 724];
coord_1k_v6_tam = [473 476];

%h08v06
coord_1k_v7_inicio = [684 0];
coord_1k_v7_tam = [473 115];

ndvi_tam = [473 591];

calidad_total=0;
elid="";

% % NDVI colormap - 256 colors - values 0 to 1 like NASA
ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
ndvi_map_g = flipud( ndvi_map_r );                                     % green
ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue
ndvi_colormap = [ ndvi_map_r  ndvi_map_g  ndvi_map_b ];

% % colormap de elevacion 
elevation_colormap = [
    0.40 0.16 0.00
    0.51 0.35 0.08
    0.63 0.57 0.20
    0.73 0.75 0.36
    0.78 0.87 0.56
    0.89 1.00 0.80
    0.69 0.89 0.60
    0.48 0.80 0.42
    0.27 0.69 0.27
    0.15 0.60 0.23
    0.06 0.49 0.20
    0.00 0.40 0.20];

elevation_colormap = flipud(elevation_colormap);