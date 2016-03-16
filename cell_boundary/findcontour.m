Q=0;
Q1=0;
Q1(N,M)=0;
Q(N,M)=0;
P=0;
P(N,M)=0;
theta0=3.142/8;
weight=750;
clear contourxy2 contourxy2A;
clear points P PA cost;
%initialization
%Q is the cost matrix for moving from point to point in the gradient plot f
%(from polarplot subroutine)
%The first column is taken directly from f
celltracker=0;
for m=1:n;
    if number(m)>0
    for num=1:number(m);
        celltracker=celltracker+1;
        clear Q f outline;
        f=f3_1{m,num};
        outline=out{m};
        if size(f,1)>0
            for count1=1:N
                Q(count1,1)=f(count1,1)*(-1);
            end
%The second column of Q is the value from the second column of f added to
%the minimum of the first column of f.
            count2=2;
            for count0=1:N
                cost(count0)=Q(count0,count2-1);
            end
%For each value in column 2, the index number of the previous column used
%to give the minimum sum is recorded in the second column of P. Q1 is a
%throwaway needed to get the MATLAB function to work.
            for count1=1:N
                Q(count1,count2)=min(cost)-f(count1,count2);
                [Q1(count1,count2),P(count1,count2)]=min(cost);
            end
%recursion
            for count2=3:3*M %%loops the ray index
                for count1=1:N %%loops through the radial positions on the current ray
                    for k=1:N %%loops through the radial positions on the previous ray

                %%calculting the vector from the radial position
                %%on the previous ray to the position on the current ray

                %deltaxalpha=polxfull(count1,count2)-polxfull(k,count2-1);
                %deltayalpha=polyfull(count1,count2)-polyfull(k,count2-1);


                        deltaxalpha=polxfull(count1,3)-polxfull(k,2);
                        deltayalpha=polyfull(count1,3)-polyfull(k,2);

                %%same thing for the 2nd previous ray to the previous ray, with
                %%the point on the previous ray held constant. The point on the
                %%2nd previous ray is chosen based on the index of the minimum
                %%sum leading to this point.

                %deltaxbeta=polxfull(k,count2-1)-polxfull(P(k,count2-1),count2-2);
                %deltaybeta=polyfull(k,count2-1)-polyfull(P(k,count2-1),count2-2);


                        deltaxbeta=polxfull(k,2)-polxfull(P(k,count2-1),1);
                        deltaybeta=polyfull(k,2)-polyfull(P(k,count2-1),1);

                %calculating angles alpha and beta with specifications for
                %cases that give duplicate arctan values.
                        if deltaxalpha==0
                            if deltayalpha>0
                                alpha=1.571;
                            elseif deltayalpha<0
                                alpha=4.712;
                            else
                                alpha=0;
                            end
                        elseif deltayalpha==0
                            if deltaxalpha>0
                                alpha=0;
                            elseif deltaxalpha<0
                                alpha=3.142;
                            else
                                alpha=0;
                            end
                        elseif deltaxalpha>0 && deltayalpha>0
                            alpha=atan(deltayalpha/deltaxalpha);
                        elseif deltaxalpha>0 && deltayalpha<0
                            alpha=atan(deltayalpha/deltaxalpha)+6.2832;
                        else
                            alpha=atan(deltayalpha/deltaxalpha)+3.14159;
                        end
                        if deltaxbeta==0
                            if deltaybeta>0
                                beta=1.571;
                            elseif deltaybeta<0
                                beta=4.712;
                            else
                                beta=0;
                            end
                        elseif deltaybeta==0
                            if deltaxbeta>0
                                beta=0;
                            elseif deltaxbeta<0
                                beta=3.142;
                            else
                                beta=0;
                            end
                        elseif deltaxbeta>0 && deltaybeta>0
                            beta=atan(deltaybeta/deltaxbeta);
                        elseif deltaxbeta>0 && deltaybeta<0
                            beta=atan(deltaybeta/deltaxbeta)+6.2832;
                        else
                            beta=atan(deltaybeta/deltaxbeta)+3.14159;
                        end  
    %for emphsis on left-turn, use alpha-beta. right turn: beta-alpha
    %T records the penalty for moving from point count1 on the current ray to
    %point k on previous ray to the point on the 2nd previous ray that
    %minimizes the cost on point k of the previous ray
                        theta=(alpha-beta);%*360/(2*3.14159);
                        if theta<0
                            T(count1,k,count2)=weight*(theta)^4; %weight, theta0 are variable, can adjust as needed
                        elseif theta>=0 && theta<theta0  
                            T(count1,k,count2)=0;
                        else
                            T(count1,k,count2)=weight*(theta-theta0)^2;
                        end
                    end
    %cost summarizes the total cost of moving to point count1 on current ray
    %from any point on the previous ray, including the turning penalty as well as
    %the cost total for the point on the previous ray.
                    for count0=1:N
                        cost(count0)=Q(count0,count2-1)+T(count1,count0,count2);
                    end
    %Q is updated with the minimum overall cost for each point on current ray, 
    %The index of the point on the previous ray from where this minimum cost
    %was achieved is recorded in P
                    Q(count1,count2)=min(cost)-f(count1,count2);
                    [Q1(count1,count2),P(count1,count2)]=min(cost);
                end
            end
    %Total minimum after all rays are traversed
            QA={Q};
            
            PA(m,num)={P};
            [mincost,Pmincost]=min(Q(:,3*M));

            points=0;
            points(3*M)=Pmincost;
    %outputs list of x,y coordinates of points selected for contour
    %Traceback the full optimal path
            for index=3*M-1:-1:1
                points(index)=P(points(index+1),index+1);
            end
            points1(m,num)={points};
         
            sizepoints=size(points);
            %pick only the middle copy of the optimal path
            for index=M+1:2*M%1:sizepoints(2)
                if 1<=(polx(points(index),index-M*(fix((index-1)/M)))+x(m,num)) && ...
                        1<=poly(points(index),index-M*(fix((index-1)/M)))+y(m,num)
                    contourxy2(polx(points(index),index-M*(fix((index-1)/M))) +x(m,num)...
                        ,poly(points(index),index-M*(fix((index-1)/M)))+y(m,num))=1;
                end
                 %store coordinates for present cell with center at
                 %x(m,num),y(m,num)
                XY(index,1)=(poly(points(index),index-M*(fix((index-1)/M)))+y(m,num));
                XY(index,2)=(polx(points(index),index-M*(fix((index-1)/M)))+x(m,num));

            end
            contourxy2A(m,num)={contourxy2};
        end
        %array of coordinates for cell(num)
        XXYY(celltracker)={XY(M+1:2*M,:)};
    end
    end
end

clear contourxy2B;
contourxy2B(:,:,2)=contourxy2;
contourxy2B(imgsz(1),imgsz(2),3)=0;figure;
imshow(contourxy2B); %displays as RGB??
hold on;
h=imshow(inputimage,[]);
set(h,'AlphaData',0.4)
