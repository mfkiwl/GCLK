function [corSit,corCoord]=readCorCoord(fname)

corSit=[];
corCoord=[];
fid=fopen(fname,'r');
while ~feof(fid)
    line=fgetl(fid);
    if(line(1)~=' ')
        continue;
    end
    C = strsplit(line);
    corSit=[corSit;C(2)];
    xyz=zeros(1,3);
    xyz(1)=str2double(char(C(7)));
    xyz(2)=str2double(char(C(8)));
    xyz(3)=str2double(char(C(9)));
    corCoord=[corCoord;xyz];
end

fclose(fid);