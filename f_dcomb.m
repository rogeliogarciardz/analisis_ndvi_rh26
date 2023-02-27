function d = f_dcomb(x,f)
    m = length(x);
    d = zeros(1,m);
    for i=1:m
        %x(i+1)-x(i-1);
        if(i==1)
            d(i) = (f(i+1)-f(i)) ./ (x(i+1)-x(i));
        elseif(i==m)
            d(i) = (f(i)-f(i-1)) ./ (x(i)-x(i-1));
        else
            d(i) = (f(i+1)-f(i-1)) ./ (x(i+1)-x(i-1));
        end
    end
end

%%calcular con ecuaciones de 2do orden
%%integración numerica

