function goodPts = getGoodPts(set)
y=polyfit(set(:,1),set(:,2),1);
[x1, pt1] = min(set(:,1));
[x2, pt2] = max(set(:,1));
y1 = polyval(y,x1);
y2 = polyval(y,x2);
goodPts = [x1 y1 x2 y2 ];