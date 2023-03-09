%% mapa completez premium

if elid=="ban_cpp"
    map_completez_premium = sum(arr_completez_premium,3,'omitnan') / filas * 100;
    map_completez_premium(area_estudio==false)=nan;

    figure;
    m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,map_completez_premium,"Completez premium",0);
    m_dibujarOtrasAreas(dir_data);

    %% mapa completez premium

    map_completez = sum(arr_completez,3,'omitnan') / filas * 100;
    map_completez(area_estudio==false)=nan;

    figure;
    m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,map_completez,"Completez",0);
    m_dibujarOtrasAreas(dir_data);

    %% mapa nubes y nieve

    map_nubes_nieve = sum(arr_nubes_nieve,3,'omitnan') / filas * 100;
    map_nubes_nieve(area_estudio==false)=nan;

    figure;
    m_dibujar_mapa_porcentaje(lon_mapa,lat_mapa,lon,lat,map_nubes_nieve,"Nubes y nieve",0);
    m_dibujarOtrasAreas(dir_data);

    % %%% Disponibilidad
    % map_disponibilidad=m_mean_3dpp(arr_disponibilidad);
    %
    % %map_disponibilidad = permute(arr_disponibilidad,[1 3 2]);
    % %map_disponibilidad = mean(map_disponibilidad,2,'omitnan');
    % %map_disponibilidad = reshape(map_disponibilidad,[ndvi_tam(1),ndvi_tam(2)]);
    %
    % map_disponibilidad(map_disponibilidad>0.5)=nan;
    %
    %
    %% histograma y 1a derivada

    figure;
    x=1:100;
    h1=histogram(arr_ndvi,100);
    y = h1.Values;

    dc = f_dcomb(x,y);

    plot(x,y,"b",x,dc,"k-");

    title('1da derivada histograma')
    xlabel('x')
    ylabel("f(x)");
    legend(["Histograma" "Derivada"],"Location","north");
else
    disp("Ejecute el codigo que genera los datos");
end