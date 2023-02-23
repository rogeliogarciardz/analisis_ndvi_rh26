function [max,min,prom,prec,hume] = m_infoClima(dir_data,anio,dia,rango,data)

    archivo = dir_data + anio +'_ClimaTanto.csv';
    if(exist(archivo,"file")==1)
        data = readmatrix(archivo );
        
        rango_inf = dia - rango;
        rango_sup = dia + rango;
    
        if(rango_inf <= 0)
            rango_inf = 1;
        end
    
        if(rango_sup >= 365)
            rango_sup = 365;
        end
    
        max = mean(data(rango_inf:rango_sup,2));
        min = mean(data(rango_inf:rango_sup,3));
        prom = mean(data(rango_inf:rango_sup,4));
        prec = sum(data(rango_inf:dia,5));
        hume = mean(data(rango_inf:rango_sup,6));
    else
       max = 0;
       min = 0;
       prom =0;
       prec = 0;
       hume = 0;
    end
end