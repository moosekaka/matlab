%%MANUALLY PICK CENTERS
 

%For each of the 'n' regions found
clear out;clear outline;clear pointArray;clear x;clear j;
Iper1=Iper;
s=size(Idilate);
n=0;
 for row =1:s(1)
      for col=1:s(2)
          if Iper1(row,col),
             n=n+1;
             clear outline;
             outline = bwtraceboundary(Idilate, [row, col], 'W', 8, 2000, 'counterclockwise');
             out(n)={outline};
             %zero out the original perimeter image Iper1 so that you dont
             %loop over the the region more than once
             Iper1(outline(:,1),outline(:,2))=0;
          end
      end        
  end
 
%for each region 'j', plot the outline in sequence
celltrack=0;
for m=1:n
    number(m)=0;
        plot(out{m}(:,2),out{m}(:,1),'r','LineWidth',2);

check=true;
%pick a point and record the coords in x(region(j),(1st/2nd etc center)) and y(region(j),(1st/2nd etc center)) ,
%while checking first if the point is in outline 'j', if not proceed to the next outline region
        while check == true
            
            p = impoint(gca);
            temp=ceil(getPosition(p));
                if check==Idilate(temp(2),temp(1))
                    number(m)=number(m)+1;
                    celltrack=celltrack+1; %label for cell numbers
                    pointArray{m,number(m)}=temp;
                    %record the coords, note the x and y are reverse wrt to
                    %the image axes (ie x is column, y is row)
                     x(m,number(m))=pointArray{m,number(m)}(2);
                     y(m,number(m))=pointArray{m,number(m)}(1);
                     setString(p,celltrack);
                 else break
                end
        end              
end
   
                          
           
        
  