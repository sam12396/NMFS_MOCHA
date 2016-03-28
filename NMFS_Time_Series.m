%Time series w/ mean,min, max by year


% CURRENT SUMMER


readnmfsdata;
N_lat=lat;
N_lon=lon;
%Limit by Area
ind=find(N_lat>=37&N_lat<=40.4);
N_lat=N_lat(ind,1);
N_lon=N_lon(ind,1);
V=V(ind,:);
timeGMT=timeGMT(ind);
surftemp=surftemp(ind);
bottemp=bottemp(ind);

%LIMIT BY SEASON
month=(V(:,2));
IND=find(V(:,2)>=6 & V(:,2)<=8);
V=V(IND,:);
timeGMT=timeGMT(IND);
surftemp=surftemp(IND);
bottemp=bottemp(IND);
month=month(IND);

%Get stats for each year
stat_s=nan(41,3);
stat_b=nan(41,3);
for i=1973:2014
    ind=find(V(:,1)==i);
    i_s=surftemp(ind);
    i_b=bottemp(ind);
    if length(ind)==0
        i_s=0;
        i_b=0;
    end
    j=i-1972;
    stat_s(j,1)=max(i_s,[],'omitnan');
    stat_s(j,2)=min(i_s,[],'omitnan');
    stat_s(j,3)=mean(i_s,'omitnan');
    stat_b(j,1)=max(i_b,[],'omitnan');
    stat_b(j,2)=min(i_b,[],'omitnan');
    stat_b(j,3)=mean(i_b,'omitnan');
    
    
end  

figure
    plot(stat_s(:,1),'-o','LineWidth',1,'color','r','markeredgecolor','r'...
        ,'markerfacecolor','r');
    hold on
    plot(stat_s(:,2),'-o','linewidth',1,'color','g','markeredgecolor','g'...
        ,'markerfacecolor','g');
    plot(stat_s(:,3),'-o','linewidth',1,'color','b','markeredgecolor','b'...
        ,'markerfacecolor','b');
figure
plot(stat_b(:,1),'-o','LineWidth',1,'color','r','markeredgecolor','r'...
        ,'markerfacecolor','r');
    hold on
    plot(stat_b(:,2),'-o','linewidth',1,'color','g','markeredgecolor','g'...
        ,'markerfacecolor','g');
    plot(stat_b(:,3),'-o','linewidth',1,'color','b','markeredgecolor','b'...
        ,'markerfacecolor','b');