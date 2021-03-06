% RANSAC Main
clear all
close all
clc

dMax = 50; %distance threshold
t = 2; %subset size (Minimum number of pts required for line)
raw = load('data_file4.csv'); %data file
hasDups = xy_convert(raw);
A = unique(hasDups(:,1:2),'rows','stable');
size(A)
goodPts = []; %empty array for good line vertices
solutions = []; %All solutions
p = .99;
w = .50;
k = log(1-p)/(log(1-w^2))*2;

%Iterate until A is pretty much empty. What's left should be outliers/noise
while size(A,1) > t
    %Perform random sample consensus
    set = [];
    setMax = [];
    for i=1:k
        %Randomly select 2 different numbers between 1 and A.size
        SampleIndex = randperm(size(A,1),2);
        
        %Use SampleIndex results to read two points into memory
        x = [A(SampleIndex(1),1), A(SampleIndex(2),1)];
        y = [A(SampleIndex(1),2), A(SampleIndex(2),2)];
        
        %Exclude data for range = 0
        if (x(1)==0 && y(1)==0) || (x(2)==0 && y(2)==0)
            continue
        end
        
        %Get all points that are less than dMax from line & their index
        [set, setI] = getSetFromPoints(A,x,y,dMax);
        
        %Add set to list if set size is big enough & set size is > setMax
        if size(set,1) >= t & size(set,1) > size(setMax,1);
            setMax = set;
            index = setI;
        end
    end
    
    %Add largest set to solutions
    if size(setMax,1) >= t
        solutions = vertcat(solutions,getGoodPts(setMax));
        
        %Delete points that are in this solution from the main set
        for i = 0:(size(setMax,1)-1)
            A(index(size(setMax,1)-i),:)=[];
        end
        %plot results
        hold on
         for i=1:size(solutions,1)
             plot(solutions(i,:));
         end
        size(A,1);
    end
end
        


%plot original points
A = xy_convert(raw);
figure;scatter(A(:,1),A(:,2))
%figure;plot(A(:,1),A(:,2),'*-r')
