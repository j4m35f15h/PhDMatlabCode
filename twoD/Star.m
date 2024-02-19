function [ Out ] = Star( In , v , f )
    %Finds surrounding vertices
        %Feed the function an index for vertex list v. The function will 
        %then look in v to find all vertices
        %connected to In. Program then returns an array carrying those
        %index values, in the order they are found in (effectively random)

        %find the index, find the value, search for same value find index values of other points.
        j = 0;
        for i = 1:size(v,1)
            if v(In,1) == v(i,1) && v(In,2) == v(i,2) && v(In,3) == v(i,3)
                j = j + 1;
                temp(j,1) = i;
            end
        end
        %temp now contains the index values of all duplicate vertices. N.B.
        %the number of values returned here represents the number of faces
        %connected to the given vertex. 
        
        %Program now needs to look inside f to find the vertices connected
        %to those in out. row values will be equal to index/3 rounded up.
        %
        % Out = zeros(size(temp,2),2);
        for i = 1:size(temp,1)
            if temp(i) > size(f,1)*3
                continue
            end
            %needs to have a more flexible way of finding the row number
            for j = 1:size(f,1)
                if f(j) + 2 < temp(i)
                    continue
                end
                if f(j) + 2 >= temp(i)
                    row = j;
                    break
                end
            end
            if f(row,1) == temp(i,1)
                temp(1,2*i-1) = f(row,2);
                temp(1,2*i) = f(row,3);
            end 
            if f(row,2) == temp(i,1)
                temp(1,2*i-1) = f(row,1);
                temp(1,2*i) = f(row,3);
            end
            if f(row,3) == temp(i,1)
                temp(1,2*i-1) = f(row,1);
                temp(1,2*i) = f(row,2);
            end
        end
        temp(2:(size(temp,1)),:) = [];
        temp = temp(find(temp));
%Now that we've obtained the index values of the relevant Vertices, we need
%to compare them to the actual values inside v and remove any repeated
%positions.
change = 0;
while change == 1
    change = 0;
    for i = 1:size(temp,2)
        for j = 1:size(temp,2)
            if i == j
                continue
            end
            if i > size(temp,2) || j > size(temp,2)
                break
            end
            if v(temp(1,i),1) == v(temp(1,j),1) && v(temp(1,i),2) == v(temp(1,j),2) && v(temp(1,i),3) == v(temp(1,j),3)
                temp(:,j) = [];
                change = 1;
                break
            end
        end
    end
end
Out = temp;
end