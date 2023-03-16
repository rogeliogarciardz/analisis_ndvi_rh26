function m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,datos,titulo,tipo)
    %% dibujar mapa  
   
    % dependiendo del tipo se cambiaran los limites o el colormap 
    % y otras caracteristicas del mapa

    % TIPO == 0 : Normal 
    % TIPO == 1 : 
    % TIPO == 2 : 
      
    switch  tipo
        case  0
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,[0 100],flipud(m_colmap('jet',20)),"Porcentaje (%)");

        case 1
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,[0 1],m_colmap('mBOD',256),"Porcentaje promedio (%)");

        case 2
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,[],m_colmap('jet',256),"Dev Est (%)");

        case 3
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,[],m_colmap('jet',2),"Binaria");

       case  4
            m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,[0 50],flipud(m_colmap('jet',10)),"Porcentaje(%)");

    end
    
end