function m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,ndvi,titulo,tipo)

    % NDVI colormap - 256 colors - values 0 to 1 like NASA
    ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
    ndvi_map_g = flipud( ndvi_map_r );                                     % green
    ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue
    ndvi_colormap = [ ndvi_map_r  ndvi_map_g  ndvi_map_b ];
  
    % TIPO == 0 : NDVI normal con clim 0-1
    % TIPO == 1 : NDVI promedio con clim 0-1 
    % TIPO == 2 : NDVI promedio sin clim 

    switch  tipo
        case  0
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,ndvi,titulo,[0 1],ndvi_colormap,"NDVI");

        case 1
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,ndvi,titulo,[0 1],m_colmap('mBOD',256),"NDVI");

        case 2
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,ndvi,titulo,[],m_colmap('jet',256),"NDVI");

        case 3
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,ndvi,titulo,[],ndvi_colormap,"NDVI");

    end
      
end