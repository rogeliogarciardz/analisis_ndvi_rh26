function img_fechas = m_imagenes_fechas(dir_data)
disp(">>>>> Obteniendo información de archivos sobre fechas ... ");
%Lista de archivos HDF del completas para analizar la información 
lista_archivos = dir(dir_data+'MOD13A2\061\MOD13A2.A*.hdf');
num_archivos = length(lista_archivos);
disp(">>>>> Analizando "+num_archivos+" archivos");
i=1;

%declaracion de variables
idx =zeros(1,num_archivos/2) ;
anio =zeros(1,num_archivos/2) ;
diaj = zeros(1,num_archivos/2) ;
dia = zeros(1,num_archivos/2) ;
mes = zeros(1,num_archivos/2) ;
estacion = zeros(1,num_archivos/2) ;
v6 = zeros(1,num_archivos/2) ;
v7 = zeros(1,num_archivos/2) ;
v6 = string(v6);
v7 = string(v7);

if(num_archivos > 0)
    for k = 1:2:num_archivos
        idx(i) = i;
        diaj(i) = str2double( extractBetween(lista_archivos(k).name,14,16));
        anio(i) = str2double(extractBetween(lista_archivos(k).name,10,13));
        [dia(i),mes(i),estacion(i)] = m_mes_diaj(diaj(i),anio(i),dir_data);
        v6(i) = lista_archivos(k).name; 
        v7(i) = lista_archivos(k+1).name; 
        i=i+1;

    end

    img_fechas = table(idx',diaj',dia',mes',estacion',anio',v6',v7','VariableNames',["idx","diaj","dia","mes","estacion","anio","v6","v7"]);
else
    warnig(">>>>> No hay imagenes disponibles");
end