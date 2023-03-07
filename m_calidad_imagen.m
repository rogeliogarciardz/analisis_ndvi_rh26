function [calidad] = m_calidad_imagen (disponibilidad,calidad_total)
    % calcular la calidad de la imagen
    calidad = numel( find(disponibilidad==0)) + numel(find(disponibilidad==1));
    calidad = round(calidad * 100 / calidad_total,0);
end