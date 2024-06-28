function mjd=modified_julday(iday,imonth,iyear)

if(imonth<=2)
    y=iyear-1;
    m=imonth+12;
else
    y=iyear;
    m=imonth;
end
mjd=floor(365.25*y)+floor(30.6001*(m+1))+iday-679019;