function  m_dibujarOtrasAreas(dir_data)
    no_estados = ["09" "11" "13" "15" "16" "19" "21" "22" "24" "28" "29" "30"];
    hold on;
    
    % dibujar diversas áreas
    % dibuja los estados
    for i=1:length(no_estados)
        [bndry_lon,bndry_lat,~] = read_kml(dir_data+"KML\estados\"+  no_estados(i) +".kml");
        m_line(bndry_lon,bndry_lat,'linewi',1,'color','k');     % Area outline ...ZC
        % %    m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','b'); % ...with hatching added.
    end
    
    % dibuja la región 26
    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26.kml');
    m_line(bndry_lon,bndry_lat,'linewi',2,'color','k');     % Area outline ...ZC
    %m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','g'); % ...with hatching added.

    %dibuja las subregiones
%     [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26A.kml');
%     m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
%     [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26B.kml');
%     m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
%     [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26C.kml');
%     m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
%     [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26D.kml');
%     m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');

    %dibuja el municipio 
    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\Tantoyuca.kml');
    m_line(bndry_lon,bndry_lat,'linewi',2,'color','k');     % Area outline ...ZC
    %m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','k'); % ...with hatching added.
    
    hold off;

end