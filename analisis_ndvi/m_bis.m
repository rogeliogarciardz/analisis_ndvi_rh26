function isbis = m_bis(year)
if (mod(year,4) == 0) && (mod(year,100) ~= 0) || (mod(year,400)==0)
    isbis =1;
else
    isbis=0;
end