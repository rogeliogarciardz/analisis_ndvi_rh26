function  m_dibujar_otras_areas(dir_data)
    no_estados = ["09" "11" "13" "15" "16" "19" "21" "22" "24" "28" "29" "30"];
    nombre_estados = ["CDMX" "Guanajuato" "Hidalgo" "Edo de México" "Michoacan" "Nuevo León" "Puebla" "Queretaro" "SLP" "Tamaulipas" "Tlaxcala" "Veracruz"];

    hold on;
    
    % dibujar diversas áreas
    % dibuja los estados
    for i=1:length(no_estados)
        %m_dibujar_kml(dir_data,'estados\'+no_estados(i),1,'k',nombre_estados(i));
        m_dibujar_kml(dir_data,'estados\'+no_estados(i),1,'k');

        %[bndry_lon,bndry_lat,~] = read_kml(dir_data+"KML\estados\"+  no_estados(i) +".kml");
        %m_line(bndry_lon,bndry_lat,'linewi',1,'color','k');     % Area outline ...ZC
        % %    m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','b'); % ...with hatching added.
    end
    
    % dibuja la región 26
    %m_dibujar_kml(dir_data,'RH26',2,'k');

    %dibuja las subregiones
    %m_dibujar_kml(dir_data,'RH26A',2,'r');
    %m_dibujar_kml(dir_data,'RH26B',2,'r');
    %m_dibujar_kml(dir_data,'RH26C',2,'r');
    %m_dibujar_kml(dir_data,'RH26D',2,'r');

    %dibuja el municipio 
    %m_dibujar_kml(dir_data,'Tantoyuca',2,'r','Tantoyuca');

    hold off;

end