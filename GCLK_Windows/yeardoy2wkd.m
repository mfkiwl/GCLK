function [nweek,nday]=yeardoy2wkd(iyear,idoy)

mjd=yeardoy2mjd(iyear,idoy);
nweek=floor((mjd-44244)/7);
nday=mjd-44244-nweek*7;