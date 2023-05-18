%% Funcion para analizar la calidad de la serie de tiempo por pixel
% Analiza la serie de tiempo de un pixel
% 1.- Remueve los pixeles que no son buenos o no estan disponibles
% 2.- Cuenta el numero y tamaño de los huecos de la serie de tiempo
% 3.- Interpola linealmente los datos faltantes
% 4.- Analiza las 2 series para saber si son iguale o diferentes

function [num_huecos,pje_huecos] = m_analisis_huecos(data,qa)

        % eliminar datos de mala calidad
        data(qa ~= 0 & qa ~= 1)=nan;
        num_huecos = sum(isnan(data));
        pje_huecos = num_huecos/length(data);
    
        
end
