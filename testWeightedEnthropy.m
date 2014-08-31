%% test smoothing

%data1 = readAccomulatedFeatures('/home/kuznetso/tmp/GroupTestD10wi7full/Train/06_18_27_41/accomulatedFeatures');
%data2 = readAccomulatedFeatures('/home/kuznetso/tmp/GroupTestD10wi7full/Train/06_18_55_40/accomulatedFeatures');
%data3 = readAccomulatedFeatures('/home/kuznetso/tmp/GroupTestD10wi7full/Train/07_11_38_47/accomulatedFeatures');
%data4 = readAccomulatedFeatures('/home/kuznetso/tmp/GroupTestD10wi7full/Train/07_12_18_09/accomulatedFeatures');

ind=10;
data = [data1(ind).features data2(ind).features data3(ind).features data4(ind).features data5(ind).features data6(ind).features];
bestf = data1(ind).features(end);

for i=2:6
    fdist = cellfun(@(x) fdistance(x.F,bestf{end}.F),data(:,i));
    oldIGs = -cellfun(@(x) x.gain,data(:,i));
    newIG = (1-4*fdist).*oldIGs;
    [~,imax]=max(newIG);
    bestf = [bestf; data(imax,i)];
end