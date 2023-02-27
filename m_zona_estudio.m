function [lat,lon,ndvi_test] = m_zona_estudio(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam)
import matlab.io.hdfeos.*
disp(">>>>> Obteniendo la zona de estudio");

%Lista de archivos HDF del 2022 para analizar la información y obtener las
%matrices de latitud y longitud del área a anlizar h08v06 y h08v07

lista_archivos = dir(dir_data+'MOD13A2\061\MOD13A2.A2022257.h08v*.hdf');
num_archivos = length(lista_archivos);

if(num_archivos > 0)
    %% Recuperar la información
    disp(">>>>> Analizando "+num_archivos+" archivos");
    
    % Abrir primer h08v06 archivo hdf para obtener las matrices de latitud y
    % longitud. Despues abrir el segundo archvio h08v07 y unir al primero
    % para tener la información completa

    gfid = gd.open( lista_archivos(1).folder + "\" +lista_archivos(1).name);
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,'MODIS_Grid_16DAY_1km_VI');
    %obtenemos el ndvi, latitud y longitud
    [ndvi1,lat1,lon1] = gd.readField(gridID,'1 km 16 days NDVI',coord_1k_v6_inicio,coord_1k_v6_tam); 
    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    gfid = gd.open( lista_archivos(2).folder + "\" +lista_archivos(2).name);
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,'MODIS_Grid_16DAY_1km_VI');
    %obtenemos el ndvi, latitud y longitud
    [ndvi2,lat2,lon2] = gd.readField(gridID,'1 km 16 days NDVI',coord_1k_v7_inicio,coord_1k_v7_tam);
    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    %mezclar matrices
    lat = [lat1 lat2];
    lon = [lon1 lon2];
    ndvi_test = [ndvi1 ndvi2];
end
end