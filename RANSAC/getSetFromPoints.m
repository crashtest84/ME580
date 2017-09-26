% This function will check the dMax distance of the points left in A to the 
% line defined by the points in x and y arguments. It will also check the 
% dMax distance between points to ensure no jumps

function [set, index] = getSetFromPoints(xy, x, y, dMax)
index = [];
set = [];
workingSet = [];
    A = (y(1)-y(2));
    B = (x(2)-x(1));
    C = (x(1)*y(2)-x(2)*y(1));
for i = 1:size(xy,1)
    d = abs(A*xy(i,1)+B*xy(i,2)+C);
    if d <= dMax && size(workingSet,1) < 1
       pt = [xy(i,1), xy(i,2),d];
       workingSet = vertcat(workingSet,pt);
       index = vertcat(index,i);
   elseif d <= dMax &&... %Check distances
           (abs(workingSet(size(workingSet,1),1) - xy(i,1)) < dMax) &&... 
           (abs(workingSet(size(workingSet,1),2) - xy(i,2)) < dMax)
       pt = [xy(i,1), xy(i,2), d];
       workingSet = vertcat(workingSet,pt);
       index = vertcat(index, i);
   end
   
%    if size(workingSet,1)>1
%        %sortrows(workingSet);
%        for i=1:(size(workingSet,1)-1)
%            if 
%                workingSet(i+1,:) = [];
%            end
%        end
%    end
end
set = workingSet;        
 
%The code below is only needed for R3 and isn't done. The function would
% need two more arguments xLim and yLim along with unidentified work
% v1 = [line(1)*xLim(1)+line(2) xLim(1)]
% v2 = [line(1)*xLim(2)+line(2) xLim(2)]
%     
% a = v1 - v2
% b = pt - v2
% d = norm(cross(a,b))/norm(a)