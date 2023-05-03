%% Funcion para analizar la calidad de la serie de tiempo por pixel
% Analiza la serie de tiempo de un pixel
% 1.- Remueve los pixeles que no son buenos o no estan disponibles
% 2.- Cuenta el numero y tamaño de los huecos de la serie de tiempo
% 3.- Interpola linealmente los datos faltantes
% 4.- Analiza las 2 series para saber si son iguale o diferentes

function [val_rmse,val_mae,val_corr,num_huecos,pje_huecos,histo_huecos,data_n] = m_analisis_qa(data,qa)
    
    num_huecos = 0;

    tam = length(data);
    data2 = data;

    % eliminar datos de mala calidad
    data2(qa ~= 0 & qa ~= 1)=nan;
    
    % contar el numero de huecos
    num_nan = zeros(1,tam);
    cnan=0;
    for i=1:tam
        if(isnan(data2(i)))
           cnan=cnan+1; 
           num_huecos=num_huecos+1;
        elseif(cnan>0 && cnan<5)
            num_nan(cnan)=num_nan(cnan)+1;
            cnan=0;
        end
    end

    histo_huecos = num_nan(1)+num_nan(2)*100+num_nan(3)*10000+num_nan(4)*1000000;
    pje_huecos = num_huecos/tam;

    data_n = fillmissing(data2,'linear');    

    val_rmse = rmse(data,data_n);
    val_mae = mean(abs(data-data_n));
    val_corr = corrcoef(data,data_n);
    val_corr = val_corr(2,1);
end
