%mostrar graficas y mapas
disp("Promedio por año. Promedio, desv estamdar e indice de variación completo");

if elid == "ban_pxa"
    m1 = m_mean_3dpp(arr_ndvi);
    m1std = m_std_3dpp(arr_ndvi);
    m1cv = m1std./m1;

    figure;

    % dibujar el mapa del promedio de todos los años
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1,"NDVI promedio del 2000 al 2020",0);
    m_dibujar_otras_areas(dir_data);
    %pause (debug_pausa);

    figure;

    % dibujar el mapa del promedio de todos los años
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1std,"Desviación estandar de NDVI del 2000 al 2020",2);
    m_dibujar_otras_areas(dir_data);
    %pause (debug_pausa);

    figure;

    % dibujar el mapa de la desviación estandar
    m_dibujar_mapa_ndvi(lon_mapa,lat_mapa,lon,lat,m1cv,"Coeficiente de variacion de NDVI del 2000 al 2020",2);
    m_dibujar_otras_areas(dir_data);
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
