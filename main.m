%% Código principal

disp("Saludos");

figure;

% dibujar el mapa del promedio de todos los años
m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1,"NDVI promedio del 2000 al 2020",0);
m_dibujar_otras_areas(dir_data);