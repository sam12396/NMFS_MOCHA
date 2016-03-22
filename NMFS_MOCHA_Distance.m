clear all


fname    ='http://tds.marine.rutgers.edu/thredds/dodsC/other/climatology/mocha/MOCHA_v2.nc';

M_lat=ncread(fname,'latitude');
M_lon=ncread(fname,'longitude');

readnmfsdata;
clear catchsex cruise6 crunum data endlat endlon expcatchwt expcatnum numvars purposecode ...
    season spp_name station statuscode stratum svspp svvessel tow v nmfsfile
N_lat=lat(:);
N_lon=lon(:);
clear lat lon
%Limit NMFS to              SUMMER
month=(V(:,2));
IND=find(V(:,2)>=6 & V(:,2)<=8);
V=V(IND);
timeGMT=timeGMT(IND);
N_lon=N_lon(IND);
N_lat=N_lat(IND);
surftemp=surftemp(IND);
bottemp=bottemp(IND);
surfsal=surfsal(IND);
botsal=botsal(IND);
month=month(IND);

%Array to fill with indices for MOCHA
nmfs_ind=nan(size(N_lon));

%Find closest MOCHA point to NMFS points
for i=1:length(N_lat);
   d=dist_ref(N_lon(i),N_lat(i),M_lon,M_lat); 
   ind=find(d==min(d(:)));
   nmfs_ind(i)=ind;
end


%make loop to go through by month 
%to get temp dif do NMFS-MOCHA
%Surface
close_st=nan(size(N_lon));
close_ss=nan(size(N_lon));

%LIMIT BY SEASON
for i=6:8
    ind=find(month==i);
    M_surft=ncread(fname,'temperature',[1 1 1 i],[150 381 1 1]);
    M_surft(M_surft>100)=nan;
    M_surfs=ncread(fname,'salinity',[1 1 1 i],[150 381 1 1]);
    M_surfs(M_surfs>45)=nan;
    close_st(ind)=M_surft(nmfs_ind(ind));
    close_ss(ind)=M_surfs(nmfs_ind(ind));
end
disp('Surface Done')
st_dif=surftemp-close_st;
ss_dif=surfsal-close_ss;


close_bt=nan(size(N_lon));
close_bs=nan(size(N_lon));
%LIMIT BY SEASON
for i=6:8
    ind=find(month==i);
    d_range  =57;
    M_bott=ncread(fname,'temperature',[1 1 1 i],[150 381 d_range 1]);
    M_bott(M_bott>100)=nan;
    b_t= M_bott(:,:,57);
    M_bots=ncread(fname,'salinity',[1 1 1 i],[150 381 d_range 1]);
    M_bots(M_bots>45)=nan;
    b_s= M_bots(:,:,57);
    
    for j=56:-1:1
        t_temp=M_bott(:,:,j);
        indd=find(isnan(b_t));
        b_t(indd)=t_temp(indd);
    end
 
    
    for j=56:-1:1
        t_sal=M_bots(:,:,j);
        indd=find(isnan(b_s));
        b_s(indd)=t_sal(indd);
    end
    close_bt(ind)=b_t(nmfs_ind(ind));
    close_bs(ind)=b_s(nmfs_ind(ind));
    
    disp(['Bottom_' int2str(i)])
end
bt_dif=bottemp-close_bt;
bs_dif=botsal-close_bs;
