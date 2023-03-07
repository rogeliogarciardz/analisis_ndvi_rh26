%% Declaración de variables globales al proyecto 

disp(">>> Declarando variables...ok")

global calidad_total;
%directorio de datos
dir_data = "D:\DATA\";

%Rango de datos region a analizar de todo el municipio de tantoyuca
lon_proyeccion = [-101.35 -97.70];
lat_proyeccion = [ 19.05  23.96];

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