function m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,datos,titulo,tipo)

    % NDVI colormap - 256 colors - values 0 to 1 like NASA
    ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
    ndvi_map_g = flipud( ndvi_map_r );                                     % green
    ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue

    %% dibujar mapa ndvi 
    %m_proj('lambert','long',lon_mapa,'lat',lat_mapa,'rectbox','on');
 
    m_proj('mercator','long',lon_mapa,'lat',lat_mapa);
    m_gshhs_i('patch',[0.7 0.7 0.7]);
    
    % dependiendo del tipo se cambiaran los limites o el colormap 
    % y otras caracteristicas del mapa

    % TIPO == 0 : Normal 
    % TIPO == 1 : 
    % TIPO == 2 : 

    %colormap(flipud(m_colmap('green',256)));
    m_pcolor(lon,lat,datos); %shading interp ;
    colorbar('eastoutside');

    switch  tipo
        case  0
            colormap(flipud(m_colmap('jet',10)));
            clim([0 100]);
            c = colorbar;
            c.Label.String = "Porcentaje (%)";

        case 1
            colormap(m_colmap('mBOD',256));
            clim([0 1]);
            c = colorbar;
            c.Label.String = "Porcentaje promedio (%)";

        case 2
            colormap(m_colmap('jet',256));
            c = colorbar;
            c.Label.String = "Dev Est (%)";

        case 3
            colormap(m_colmap('jet',2));
            c = colorbar;
            c.Label.String = "Binaria";

    end

    %m_grid('box','fancy','grid','none','fontsize',10);
    m_grid('linewi',2,'tickdir','out');

    m_ruler([.05 .36],.1,3,'fontsize',7)
    %m_northarrow(-101,23.5,.4,'type',2);
    m_northarrow(-97.9,23.5,.4,'type',2);
   
    title(titulo);

    
end