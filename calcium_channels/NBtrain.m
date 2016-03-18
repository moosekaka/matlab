docs=50;
ini=10000;
tdoc=ini+docs;

predict=zeros(docs,361);
for i=1:361
train=DW(1:1000,1:10000);
class=DC(1:1000,i);
nb=NaiveBayes.fit(train,class,'Distribution','mn');
predict(:,i)=full(nb.predict(DW(ini+1:tdoc,1:10000)));
end

test=full(DC(ini+1:tdoc,1:361));
 cpr=zeros(2,2) ;
 precision=zeros(1,docs);
for i=1:361
temp=confusionmat(test(:,i),predict(:,i));

cpr=cpr+temp;

    precision(i)= temp(2,2)/(temp(2,1)+temp(2,2));
 

end

