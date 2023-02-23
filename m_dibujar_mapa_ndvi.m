function m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,ndvi,titulo)
    %% dibujar mapa ndvi primera imagen
    m_proj('lambert','long',lon_mapa,'lat',lat_mapa,'rectbox','on');
    m_gshhs_i('patch',[0.7 0.7 0.7]);
    
    %colormap(flipud(m_colmap('green',256)));

    % NDVI colormap - 256 colors - values 0 to 1 like NASA
    ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
    ndvi_map_g = flipud( ndvi_map_r );                                     % green
    ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue
    ndvi_colormap = [ ndvi_map_r  ndvi_map_g  ndvi_map_b ];
    colormap(ndvi_colormap);

    m_pcolor(lon,lat,ndvi); %shading interp ;
    colorbar('eastoutside');
    c = colorbar;
    c.Label.String = "NDVI";
    %clim([-3000 9000]);
    %dibuja el recuadro del mapa
    m_grid('linestyle','none','tickdir','out','linewidth',2);
    title(titulo);

    
end