function m_dibujar_kml(dir_data,kml,plinewi,pcolor,varargin)

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\'+kml+'.kml');
    m_line(bndry_lon,bndry_lat,'linewi',plinewi,'color',pcolor); 
   %m_hatch(bndry_lon,bndry_lat,'speckle',7,1,'color','g'); % ...with hatching added.

    nVarargs = length(varargin);
    
    %fprintf('Inputs in varargin(%d):\n',nVarargs);

    if nVarargs==1

        m_text( mean(bndry_lon,'all'), mean(bndry_lat,'all'),sprintf('%s',varargin{1}));
        %disp(varargin(1))
    end
%     for k = 1:nVarargs 
%         fprintf(' %d\n', varargin{k})
%     end


end