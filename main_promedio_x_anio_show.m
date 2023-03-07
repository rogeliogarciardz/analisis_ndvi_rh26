%mostrar graficas y mapas
disp("Promedio por año");

if elid == "ban_pxa"
    m1 = m_mean_3dpp(arr_ndvi);
    m1std = m_std_3dpp(arr_ndvi);

    figure;

    % dibujar el mapa del promedio de todos los años
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1,"RH 26",0);
    m_dibujarOtrasAreas(dir_data);
    %pause (debug_pausa);

    figure;

    % dibujar el mapa del promedio de todos los años
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1,"RH 26",1);
    m_dibujarOtrasAreas(dir_data);
    %pause (debug_pausa);

    figure;

    % dibujar el mapa de la desviación estandar
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1std,"RH 26",2);
    m_dibujarOtrasAreas(dir_data);
    %pause (debug_pausa);

    figure;

    title('NDVI promedio x año')
    xlabel('Año')
    ylabel('Promedio NDVI')
    xlim([2000 2021]);
    plot(anios,tabla_datos_anios);
    %ylim([1000 3500]);

    % hold on
    % [a0,a1,yaj] = m_reglin(2000:2015,tabla_datos_anios(1:16));
    % plot(2000:2015,yaj);
    %
    % [a0,a1,yaj] = m_reglin(2015:2022,tabla_datos_anios(16:23));
    % plot(2015:2022,yaj);
    % hold off
else
        disp("Ejecute el codigo que genera los datos");

end
