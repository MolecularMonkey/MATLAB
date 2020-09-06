function RamanPlotting3(DataSetNo,RawData,BaseLineCorrected,AverageData,XD,XG,...
    Row2Choose1,Row2Choose2,Row2Choose3,Row2Choose4,...
    Row2Choose1D,Row2Choose2D,Row2Choose1G,Row2Choose2G,MatlabDataFileHistory)
Xaverage=RawData([Row2Choose1:Row2Choose2,Row2Choose3:Row2Choose4],1);

for ii=1:DataSetNo
    Yaverage=AverageData(ii+1).*ones(size(Xaverage));
    YD=BaseLineCorrected(Row2Choose1D:Row2Choose2D,ii+1);
    YG=BaseLineCorrected(Row2Choose1G:Row2Choose2G,ii+1);
    sss=MatlabDataFileHistory{5,ii+2};
    strtt=['Data Set # ',num2str(ii)];
    figure(1000+ii);
    clf(1000+ii,'reset')
    subplot(3,1,1);
    plot(RawData(:,1),RawData(:,ii+1));
    xlim([200,2700]);
    title({strtt;sss})
    subplot(3,1,2);
    ppp=plot(Xaverage,Yaverage,'o');
    ppp.Color=[0.9290 0.6940 0.1250];
    hold on
    p2=plot(RawData(:,1),RawData(:,ii+1),'k');
    p2.LineWidth=1.75;
    p2_1=plot(Xaverage,Yaverage,'r');
    p2_1.LineWidth=0.75;    
    hold off
    xlim([1100,1800]);
    ylabel('Count/sec')
    subplot(3,1,3);
    plot(BaseLineCorrected(:,1),BaseLineCorrected(:,ii+1));
    hold on
    area(XD,YD);
    area(XG,YG);
    hold off
    xlim([1100,1800]);
    xlabel('Optical Frequency 1/cm')
end
end