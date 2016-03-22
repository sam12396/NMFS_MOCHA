close all
%MAKE SURE YOU LIMIT IT TO THE RIGHT SEASON
NMFS_MOCHA_Distance
clear allvars ans b_s b_t botsal bottemp close_bs close_bt close_ss ...
    close_st d d_range i ind IND indd j M_bots M_bott M_lat M_lon M_surfs ...
    M_surft maxdepth n nmfs_ind surfsal surftemp t_sal t_temp
load('bathymetry_USeastcoast.mat');
%%    CURRENTLY RUNNING SUMMER 

%Notes
%scatter by nmfs lat lon 

%Limits      SUMMER
low_ss=-4;
hi_ss=4;
low_bs=-3;
hi_bs=3;
low_bt=-15;
hi_bt=15;
low_st=-20;
hi_st=20;

%%
%Plotting
tic
for y=1973:2014
    ind=find(timeGMT>=datenum(y,1,1)&timeGMT<=datenum(y+1,1,1));
    
    %Surf Temp
    subplot(2,2,1)
    indd=find(~isnan(st_dif));
    IND=intersect(ind,indd);
    scatter(N_lon(IND),N_lat(IND),25,st_dif(IND),'filled','markeredgecolor','k');
    colormap(darkb2r(low_st,hi_st));
    %                   SEASONAL
    title(['Surface Temp Summer ' int2str(y)]);
    hold on
    colorbar();
    contour(loni,lati,depthi,[0 0],'k');
    contour(loni,lati,depthi,[-20 -50 -100],'g','LineWidth',0.5);
    xlim([-78 -65]);
    ylim([35 42]);
    
    %Surf Sal
    subplot(2,2,2)
    indd=find(~isnan(ss_dif));
    IND=intersect(ind,indd);
    scatter(N_lon(IND),N_lat(IND),25,ss_dif(IND),'filled','markeredgecolor','k');
    colormap(darkb2r(low_ss,hi_ss));   
    %                   SEASONAL
    title(['Surface Salinity Summer ' int2str(y)])
    hold on
    colorbar();
    contour(loni,lati,depthi,[0 0],'k');
    contour(loni,lati,depthi,[-20 -50 -100],'g','LineWidth',0.5);
    xlim([-78 -65]);
    ylim([35 42]);
    
    %Bot Temp
    subplot(2,2,3)
    indd=find(~isnan(bt_dif));
    IND=intersect(ind,indd);
    scatter(N_lon(IND),N_lat(IND),25,bt_dif(IND),'filled','markeredgecolor','k');
    colormap(darkb2r(low_bt,hi_bt)); 
    %                   SEASONAL
    title(['Bottom Temp Summer ' int2str(y)]);
    hold on
    colorbar();
    contour(loni,lati,depthi,[0 0],'k');
    contour(loni,lati,depthi,[-20 -50 -100],'g','LineWidth',0.5);
    xlim([-78 -65]);
    ylim([35 42]);
    
    %Bot Sal
    subplot(2,2,4)
    indd=find(~isnan(bs_dif));
    IND=intersect(ind,indd);
    scatter(N_lon(IND),N_lat(IND),25,bs_dif(IND),'filled','markeredgecolor','k');
    colormap(darkb2r(low_bs,hi_bs)); 
    %                   SEASONAL
    title(['Bottom Salinity Summer ' int2str(y)]);
    hold on
    colorbar();
    contour(loni,lati,depthi,[0 0],'k');
    contour(loni,lati,depthi,[-20 -50 -100],'g','LineWidth',0.5);
    xlim([-78 -65]);
    ylim([35 42]);
    
    %Printing
    %                                                                   SEASONAL
    print('-dpng','-r150',['/Users/samcoa/Documents/MATLAB/NMFS_MOCHA_PLOTS/SUMMER/n-m_'...
        int2str(y)]);
    close all
end
toc




