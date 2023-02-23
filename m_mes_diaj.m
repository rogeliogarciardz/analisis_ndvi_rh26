function [dia,mes,estacion] = m_mes_diaj(diaj,year,dir_data)
    if (m_bis(year))
        diaanio = readmatrix(dir_data + 'diasaniobis.csv');
    else
        diaanio = readmatrix( dir_data + 'diaanio.csv');
    end

    idx = find(diaanio(:,1) == diaj);
    dia = diaanio(idx,2);
    mes = diaanio(idx,3);
    estacion = diaanio(idx,4);

end