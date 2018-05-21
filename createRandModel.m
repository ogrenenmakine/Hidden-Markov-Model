function createRandModel(n, m)
    A = rand(n,n);
    B = rand(n,m);
    A = A./repmat(sum(A,1),n,1);
    B = B./repmat(sum(B,2),1,m);
    p = rand(n,1);
    p = p ./ sum(p);
    fileName = 'model.txt';
    delete model.txt
    file = fopen(fileName, 'w');
    fclose(file);
    file = fopen(fileName, 'a');
    fprintf(file, 'A\n');
    fclose(file);
    dlmwrite(fileName, A ,'-append', 'newline', 'pc');
    file = fopen(fileName, 'a');
    fprintf(file, 'B\n');
    fclose(file);
    dlmwrite(fileName, B ,'-append', 'newline', 'pc');
    file = fopen(fileName, 'a');
    fprintf(file, 'P\n');
    fclose(file);
    dlmwrite(fileName, p ,'-append', 'newline', 'pc');
end

