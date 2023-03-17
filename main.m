%% Código principal
import matlab.io.hdfeos.*
clearvars -except area_estudio;
close all;

declaraciones

% obtener la info del área de estudio
[lat,lon,ndvi] = m_leer_dir_hdfs(dir_data,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam);
info_hdf = m_infohdfs2table(dir_data);

ndvi(ndvi<=0)=nan;

m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,ndvi,"NDVI",[],ndvi_colormap,"NDVI");
m_dibujar_kml(dir_data,"RH26",1,'b',"RH26");