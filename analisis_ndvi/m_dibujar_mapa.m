function m_dibujar_mapa(lon_mapa,lat_mapa,lon,lat,datos,titulo,pclim,ppcolor,plabel)
    %% dibujar mapa ndvi proyeccion mercator 
    m_proj('mercator','lon',lon_mapa,'lat',lat_mapa);

    %% dibujar linea de costa con 'intermediate' resolution 
    %m_gshhs_i('patch',[0.7 0.7 0.7]);
    
    %%dibujar el mapa
    m_pcolor(lon,lat,datos); shading interp ;

    colormap(ppcolor);

    if plabel ~= ""    
        colorbar('eastoutside');
        c = colorbar;
        c.Label.String = plabel;
    end

    if length (pclim) == 2
        clim(pclim);

%         if( pclim(2) <=10)
%             colorbar('eastoutside');
%             c = colorbar;
%             c.Label.String = "Grupos";
%             c.Ticks = 1:pclim(2);
%             c.TickLabels = 1:pclim(2);
%             c.TickDirection = "out";
%         end

    end 
    

    %dibuja el recuadro del mapa
    %m_grid('box','fancy','grid','none','fontsize',10);
    m_grid('linestyle','none','box','fancy','tickdir','out');
    %m_grid('linewi',2,'tickdir','out');

    % Regla de escala
    m_ruler([.05 .36],.1,3,'fontsize',7)
    
    %m_northarrow(-101,23.5,.4,'type',2);
    % Estrella del norte 
    m_northarrow(-97.9,23.5,.4,'type',2);

    if(~isempty (titulo))
        title(titulo);
    end
end