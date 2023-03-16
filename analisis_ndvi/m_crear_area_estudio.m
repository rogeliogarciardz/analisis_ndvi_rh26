function area_estudio = m_crear_area_estudio(archivo_kml,lat,lon)
    %% crear matriz solo de puntos dentro del area de estudio
    disp("Creando área de estudio!!!");
    %[~,R] = readgeoraster('boston.tif');
    [~,R] = readgeoraster('LC09_L2SP_026045_20230116_20230119_02_T1_SR_B7.TIF');
    proj = R.ProjectedCRS;
    proj.GeographicCRS.Name;

    [bndry_lon,bndry_lat,~] = read_kml(archivo_kml);
    [x,y] = projfwd(proj,bndry_lat,bndry_lon);

    [xlat,ylon] = projfwd(proj,lat,lon);
    area_estudio = inpolygon(xlat,ylon,x,y);

    %area_estudio = double(p);
end

    