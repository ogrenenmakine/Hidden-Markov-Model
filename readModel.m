function [A, B, p] = readModel( fileName, n, m )
    fid=fopen(fileName);
    tline = fgetl(fid);
    A = [];
    B = [];
    p = [];
    if tline == 'A'
        while tline ~= 'B'
            tline = fgetl(fid);
            if size(A) == 0
                A = str2num(tline);
            else
                A = cat(1,A,str2num(tline));
            end
        end
    end
    if tline == 'B'
        while tline ~= 'P'
            tline = fgetl(fid);
            if size(A) == 0
                B = str2num(tline);
            else
                B = cat(1,B,str2num(tline));
            end
        end
    end
    tline = fgetl(fid);
    while tline ~= -1
        if size(A) == 0
            p = str2num(tline);
        else
            p = cat(1,p,str2num(tline));
        end
        tline = fgetl(fid);
    end
    fclose(fid);
end

