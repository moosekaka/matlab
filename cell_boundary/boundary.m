clear out outline outline0 mtangent;
Iper1=Iper;
n=0;

% n is the number of cell boundaries ID'd in the tracing

%%FIND AND OUTLINE REGIONS

% This section finds each cell (or mulit-cell) outline and puts the outline coordinates as
% a cell array 'out(n)' where the index 'n' is the number of the outline
% drawn.

s=size(Idilate);
for row =1:s(1)
   for col=1:s(2)
      if Iper1(row,col),
         n=n+1;
         clear outline outline0;
         outline = bwtraceboundary(Idilate, [row, col], 'W', 8, 2000, 'counterclockwise');
         out(n)={outline};
         Iper1(outline(:,1),outline(:,2))=0;
         
         outline0(:,1)=outline(:,1)-min(outline(:,1));
         outline0(:,2)=outline(:,2)-min(outline(:,2));
         out0(n)={outline0};
         
         sizeoutline0(n)=size(outline0,1);

         
         %%NORMALS CALCULATED BY INDIVIDUAL INTERVALS
         
         %This sections calculates individual normal line slopes. For every
         %point on outline stored in cell array out0(n), the slope between
         %the points at intervals +/-1 to +/-maximum is converted to the
         %correspoinding angle on the unit circle. A weighted average of
         %of the angles is taken, and then this average is converted back 
         %to the approximate slope of the normal line. 
         
         %Normal line slopes are stored in arrays
         %indexed by the index number of the point in the outline. The
         %arrays are themselves stored in cell array mtan(n) where n
         %indexes the outline number.
         
         %adjustable variables:
         % maximum-largest interval over which tangent and normals are
         % calculated
         
         %{
         for i=1:5;
             clear mtangent;
             for count = 1:sizeoutline0(n)
                 if count<i+1
                     mtangent(count)= (outline(sizeoutline0(n)-i+count,2)-outline(count+i,2))/(outline(count+i,1)-outline(sizeoutline0(n)+count-i,1));
                 elseif count>sizeoutline0(n)-i
                     mtangent(count)=(outline(count-i,2)-outline(count+i-sizeoutline0(n),2))/(outline(count+i-sizeoutline0(n),1)-outline(count-i,1));
                 else
                     mtangent(count)=(outline(count-i,2)-outline(count+i,2))/(outline(count+i,1)-outline(count-i,1));
                 end
                 
                 mtan(n,i)={mtangent};     
             end
         end
         %}
         
         %%Normals calculated by weighted average
         
         %This section calculates a weighted average of the normal line
         %slopes ('mtanave') calculated at +/-1 to +/-maximum intervals favoring 
         %the smaller intervals. The normals are stored in cell array
         %'mtan(n)' indexed by the number of the region outlines found in the 
         %previous section. (Don't use both this and lines 48-63.
         
         clear mtangent mtanave mtansum mnormal mnormsum;
         maximum=5;
         
         for count=1:sizeoutline0(n)
             flag(count)=false;
             %mnormsum(count)=0;
             mtansum(count)=0;
             for i=1:maximum
                 if count<i+1
                     dx=outline(count+i,1)-outline(sizeoutline0(n)+count-i,1);
                     dy=outline(count+i,2)-outline(sizeoutline0(n)-i+count,2);
                     %mtangent(i)= pi/2+atan((outline(count+i,2)-outline(sizeoutline0(n)-i+count,2))/(outline(count+i,1)-outline(sizeoutline0(n)+count-i,1)));
                     %if outline(count+i,1)-outline(sizeoutline0(n)-i+count,1)<0 && (outline(count+i,2)-outline(sizeoutline0(n)-i+count,2))>0
                     %    flag=true;
                     %end
                     %if outline(count+i,1)-outline(sizeoutline0(n)-i+count,1)>0
                     %    mtangent(i)=mtangent(i)+pi;
                     %elseif outline(count+i,1)-outline(sizeoutline0(n)-i+count,1)==0 && (outline(count+i,2)-outline(sizeoutline0(n)-i+count,2))<0
                     %    mtangent(i)=mtangent(i)+pi;
                     %end
                 elseif count>sizeoutline0(n)-i
                     dx=outline(count+i-sizeoutline0(n),1)-outline(count-i,1);
                     dy=outline(count+i-sizeoutline0(n),2)-outline(count-i,2);
                     %mtangent(i)= pi/2+atan((outline(count+i-sizeoutline0(n),2)-outline(count-i,2))/(outline(count+i-sizeoutline0(n),1)-outline(count-i,1)));
                     %if outline(count+i-sizeoutline0(n),1)-outline(count-i,1)<0 && (outline(count+i-sizeoutline0(n),2)-outline(count-i,2))>0
                     %    flag=true;
                     %end
                     %if outline(count+i-sizeoutline0(n),1)-outline(count-i,1)>0
                     %    mtangent(i)=mtangent(i)+pi;
                     %elseif outline(count+i-sizeoutline0(n),1)-outline(count-i,1)==0 && (outline(count+i-sizeoutline0(n),2)-outline(count-i,2))<0
                     %    mtangent(i)=mtangent(i)+pi;
                     %end
                 else
                     dx=outline(count+i,1)-outline(count-i,1);
                     dy=outline(count+i,2)-outline(count-i,2);
                     %mtangent(i)= pi/2+atan((outline(count+i,2)-outline(count-i,2))/(outline(count+i,1)-outline(count-i,1)));
                     %if (outline(count+i,1)-outline(count-i,1))<0 && (outline(count+i,2)-outline(count-i,2))>0
                     %    flag=true;
                     %end
                     %if (outline(count+i,1)-outline(count-i,1))>0
                     %    mtangent(i)=mtangent(i)+pi;
                     %elseif (outline(count+i,1)-outline(count-i,1))==0 && (outline(count+i,2)-outline(count-i,2))<0
                     %    mtangent(i)=mtangent(i)+pi;
                     %end
                 end
                 if dx<0
                     mtangent(i)=pi/2+atan(dy/dx);
                 elseif dx>0
                     mtangent(i)=pi+pi/2+atan(dy/dx);
                 elseif dy>0
                     mtangent(i)=0;
                 elseif dy<0
                     mtangent(i)=pi;
                 end
                 
                 if mtangent(i)<pi/2
                     flag(count)=true;
                 end
                         
                 
                 
                 
                 
                 %if mtangent(i)==Inf
                 %    mtangent(i)=250;
                 %elseif mtangent(i)==-Inf
                 %    mtangent(i)=250;
                 %end
                 
                 %{
                 mnormal(i)=mtangent(i)+pi/2;%(-1)/mtangent(i);
                 mtansum(count)=mtansum(count)+(maximum-i+1)*mtangent(i);
                 mnormsum(count)=mnormsum(count)+(maximum-i+1)*mnormal(i);
                 %}
             end
             
             if flag(count)==true
                 for ia=1:maximum
                     if mtangent(ia)>3.14159
                         flag1(count)=1;
                         mtangent(ia)=mtangent(ia)-2*pi;
                     end
                 end
             end
             
             for i=1:maximum
                 %mnormal(i)=mtangent(i)+pi/2;%(-1)/mtangent(i);
                 mtansum(count)=mtansum(count)+(maximum-i+1)*mtangent(i);
                 %mnormsum(count)=mnormsum(count)+(maximum-i+1)*mnormal(i);
             end
             
             
             %if mtansum(count)==Inf || mtansum(count)==-Inf
             %    mtanave(count)=tan((mnormsum(count))/(0.5*maximum^2+maximum));
             %else
                 mtanave(count)=tan(mtansum(count)/(0.5*(maximum^2+maximum)));%(-1)*(0.5*(maximum^2+maximum)/(mtansum(count)));
             %end
             
             %mtanave(count)=(5*mtangent(1)+4*mtangent(2)+3*mtangent(3)+2*mtangent(4)+1*mtangent(5))/15;
         end
         mtan(n)={mtanave};
      end
      %if n==2
      %    break;
      %end
   end
   %if Idilate(row,col),
   %   break;
   %end
end

%outline = bwtraceboundary(Idilate, [row, col], 'W', 8, 500, 'counterclockwise');


%outline0(:,2)=outline(:,1)-min(outline(:,1));
%outline0(:,1)=outline(:,2)-min(outline(:,2));

%sizeoutline0=size(outline0,1);

%for i=[1,2,5,10];
%    for count = i+1:(sizeoutline0-i)
%        mtangent(count,i)=(outline(count-i,2)-outline(count+i,2))/(outline(count+i,1)-outline(count-i,1));
%    end
%end

clear col count outline outline0 row s se; 