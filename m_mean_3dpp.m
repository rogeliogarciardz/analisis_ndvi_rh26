%Calcula el promedio por pixel de una matriz en 3 dimensiones 

function m2d = m_mean_3dpp(m3d)
    s = size(m3d);

    m2d = permute(m3d,[1 3 2]);
    m2d = mean(m2d,2,'omitnan');
    m2d = reshape(m2d,[s(1),s(2)]);
       
end