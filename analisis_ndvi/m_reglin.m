function [a0,a1,yajuste] = m_reglin(x,y)
%fitlm
    if(length(x)==length(y))
        n = length(x);

        a1 = ( (n * sum(x.*y,"omitnan")) - (sum(x,"omitnan")*sum(y,"omitnan") ))/ ( n * sum(x.^2,"omitnan") - sum(x,"omitnan")^2);
        a0 = mean(y,'omitnan') - a1 * mean(x,'omitnan');
        yajuste = a0+a1*x;

    else
        error("Arreglos de diferente tamaño") 
    end
    

end