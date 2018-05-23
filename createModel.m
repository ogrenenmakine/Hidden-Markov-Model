function createModel(n, m, ch)
    if ch
        A = [0.95, 0.9;0.05,0.1];
        B = [0.95, 0.05;0.2, 0.8];
        p = [0.95; 0.05];
    else
        A = rand(n,n);
        B = rand(n,m);
        A = A./repmat(sum(A,1),n,1);
        B = B./repmat(sum(B,2),1,m);
        p = rand(n,1);
        p = p ./ sum(p);
    end
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
