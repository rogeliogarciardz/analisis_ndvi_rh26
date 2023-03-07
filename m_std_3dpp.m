%Calcula el promedio por pixel de una matriz en 3 dimensiones 

function stdm2d = m_std_3dpp(m3d)
    s = size(m3d);

    stdm2d = permute(m3d,[3 2 1]);
    stdm2d = std(stdm2d,'omitnan');
    stdm2d = reshape(stdm2d,[s(2),s(1)])';
       
end