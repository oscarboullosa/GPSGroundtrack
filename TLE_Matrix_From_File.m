function [TLE_Matrix] = TLE_Matrix_From_File(filename)
    %Opening file
    fid = fopen(filename);
    tline = fgetl(fid);
    %Getting the second line and stripping it from ' 
    tline = fgetl(fid);
    T_1 = strsplit(tline);
    T_1 = strrep(T_1,"'","");
    %Getting the third line and stripping it from ' 
    tline = fgetl(fid);
    T_2 = strsplit(tline);
    T_2 = strrep(T_2,"'","");
    T_2 = [T_2 0];
    %Final matrix
    TLE_Matrix = [T_1 ; T_2];
end