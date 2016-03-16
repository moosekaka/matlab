%%CREATE A MATRIX OF THE RADIAL GRADIENTS AT EVERY CENTER FOUND

%intialize variables
clear f1 f3_1 rs thetas;
polx=0;
poly=0;

%size of image
imgsz=size(inputimage);

%N is the number of points along each ray drawn
%M is the number of rays drawn (equally spaced)
N=70;
M=32;

%rs is the array of radii of the equally spaced points on the rays
%thetas is the array of the equally spaced angles to each ray
rs=linspace(1,N+2,N+2);
thetas=linspace(0,2*pi,M+1);


%for each radial point on a ray
for i=1:N+2
    
    %for each ray
    for j=1:M
        
        %calculate the rounded x-coordinate 'polx(i,j)' and y-coord 
        %'poly(i,j)' as well as the non-rounded coordinates 'polxfull' and 'polyfull' 
        polx(i,j)=int8(rs(i)*cos(thetas(j)));
        poly(i,j)=int8(rs(i)*sin(thetas(j)));
        polxfull(i,j)=rs(i)*cos(thetas(j));
        polyfull(i,j)=rs(i)*sin(thetas(j));
    end
end

%for each region indexed by 'n'
for m=1:n;
    
    %set 'outline' to the image reference frame outline indexed in out{m}
    clear outline;
    outline=out{m};
    
   
    %if the number of centers in region m is greater than zero
    if number(m)>0
        
        %for each center
        for num=1:number(m);
            clear f1;
            
            %for each radial point index 2 and greater
            for i=2:N
                
                
                %for each ray
                for j=1:M
                    
                    %if the point with that radius and angle from the
                    %center point (x(m,num), y(m,num)) is off the original
                    %image, set the value to a low negative number
                    if polx(i+2,j)+x(m,num)>imgsz(1) || poly(i+2,j)+y(m,num)>imgsz(2)
                        f1(i,j)=-5000;
                    elseif polx(i+2,j)+x(m,num)<1 || poly(i+2,j)+y(m,num)<1
                        f1(i,j)=-5000;
                        
                    %if the point is in the image, calculate the radial
                    %graident at that point in the direction of the ray
                    else
                        fcos=((Ix(polx(i+2,j)+x(m,num),poly(i+2,j)+y(m,num))- ...
                            Ix(polx(i+1,j)+x(m,num),poly(i+1,j)+y(m,num)))*cos(thetas(j)));
                        fsin=((Iy(polx(i+2,j)+x(m,num),poly(i+2,j)+y(m,num))- ...
                            Iy(polx(i+1,j)+x(m,num),poly(i+1,j)+y(m,num)))*sin(thetas(j)));
                        f1(i,j)=fcos+fsin;
                    end
                end
            end
            
            %set all values for the first radial point to the average of
            %all the radial gradient values calculated at the second radial
            %points.
            f1(1,:)=mean(f1(2,:));
            
            %create an array with radial gradients calculated repeated 
            %three times by the angular index (as if rotating around the circle multiple times) 
            f3_1{m,num}=[f1,f1,f1];
        end
    end
end


%for j=1:M
%    f(1,j)=mean(f(2,:));
%end

