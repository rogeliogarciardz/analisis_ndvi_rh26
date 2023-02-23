function  m_dibujarOtrasAreas(dir_data,titulo)
    e = ["09" "11" "13" "15" "16" "19" "21" "22" "24" "28" "29" "30"];
    hold on;
    
    % dibujar diversas áreas
    %for i=1:length(e)
    %    [bndry_lon,bndry_lat,~] = read_kml(dir_data+"KML\estados\"+  e(i) +".kml");
    %    m_line(bndry_lon,bndry_lat,'linewi',1,'color','k');     % Area outline ...ZC
    %    % %    m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','b'); % ...with hatching added.
    %end

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26.kml');
    m_line(bndry_lon,bndry_lat,'linewi',2,'color','k');     % Area outline ...ZC
    %m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','g'); % ...with hatching added.

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26A.kml');
    m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26B.kml');
    m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26C.kml');
    m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');
    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\RH26D.kml');
    m_line(bndry_lon,bndry_lat,'linewi',1,'color','r');

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\Tantoyuca.kml');
    m_line(bndry_lon,bndry_lat,'linewi',2,'color','k');     % Area outline ...ZC
    %m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','k'); % ...with hatching added.
    
    hold off;

    f = gcf;
    exportgraphics(f,'D:\SOURCE\IMG\'+titulo+'.png','Resolution',300);
end