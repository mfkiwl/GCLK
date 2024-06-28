function [parSit,parCoord]=readParCoord(fname)

parSit=[];
parCoord=[];
fid=fopen(fname,'r');
while ~feof(fid)
    line=fgetl(fid);
    if(~strcmp(line(1:3),'POS'))
        continue;
    end
    xyz=zeros(1,3);
    C = strsplit(line);
    parSit=[parSit;C(2)];
    xyz(1)=str2double(char(C(3)));
    line=fgetl(fid);
    C = strsplit(line);
    xyz(2)=str2double(char(C(3)));
    line=fgetl(fid);
    C = strsplit(line);
    xyz(3)=str2double(char(C(3)));
    parCoord=[parCoord;xyz];
end

fclose(fid);