function [ndvi,evi,calidad,disponibilidad] = m_obtener_ndvi(dir_data,info,coord_1k_v6_inicio,coord_1k_v6_tam,coord_1k_v7_inicio,coord_1k_v7_tam)
import matlab.io.hdfeos.*

    gfid = gd.open( dir_data + "MOD13A2\061\" +info.v6);
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,'MODIS_Grid_16DAY_1km_VI');
    %obtenemos el ndvi, latitud y longitud
    [ndvi1,~,~] = gd.readField(gridID,'1 km 16 days NDVI',coord_1k_v6_inicio,coord_1k_v6_tam); 
    [evi1,~,~] = gd.readField(gridID,'1 km 16 days EVI',coord_1k_v6_inicio,coord_1k_v6_tam); 
    [calidad1,~,~] = gd.readField(gridID,'1 km 16 days VI Quality',coord_1k_v6_inicio,coord_1k_v6_tam); 
    [disponibilidad1,~,~] = gd.readField(gridID,'1 km 16 days pixel reliability',coord_1k_v6_inicio,coord_1k_v6_tam); 

    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    gfid = gd.open( dir_data + "MOD13A2\061\" +info.v7);
    % indicar que requerimos los datos de MODIS
    gridID = gd.attach(gfid,'MODIS_Grid_16DAY_1km_VI');
    %obtenemos el ndvi, latitud y longitud
    [ndvi2,~,~] = gd.readField(gridID,'1 km 16 days NDVI',coord_1k_v7_inicio,coord_1k_v7_tam);
    [evi2,~,~] = gd.readField(gridID,'1 km 16 days EVI',coord_1k_v7_inicio,coord_1k_v7_tam);
    [calidad2,~,~] = gd.readField(gridID,'1 km 16 days VI Quality',coord_1k_v7_inicio,coord_1k_v7_tam);
    [disponibilidad2,~,~] = gd.readField(gridID,'1 km 16 days pixel reliability',coord_1k_v7_inicio,coord_1k_v7_tam);

    % cerramos los punteros al archivo
    gd.detach(gridID);
    gd.close(gfid);

    ndvi1(ndvi1<0)=nan;
    evi1(evi1<0)=nan;

    ndvi2(ndvi2<0)=nan;
    evi2(evi2<0)=nan;

    ndvi = double([ndvi1 ndvi2]).*0.0001;
    evi = double([evi1 evi2]);

      
    calidad = double([calidad1 calidad2]);
    disponibilidad = double([disponibilidad1 disponibilidad2]);
end