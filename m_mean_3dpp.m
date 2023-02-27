%Calcula el promedio por pixel de una matriz en 3 dimensiones 

function [m2d,stdm2d] = m_mean_3dpp(m3d)
    s = size(m3d);

    m2da = permute(m3d,[1 3 2]);
    m2d = mean(m2da,2,'omitnan');
    %stdm2d = std(m2da,'omitnan');
    m2d = reshape(m2d,[s(1),s(2)]);
    %stdm2d = reshape(stdm2d,[s(1),s(2)]);
       
end