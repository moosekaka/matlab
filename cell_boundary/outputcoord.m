% A=contourxy2B(:,:,2);
% A=contourxy2A{1};
% sz=size(Iper);
% s = [sz(1),sz(2)];
% B=find(A);
% [I,J] = ind2sub(s,B);
% coor=[J,I];.

% for i=1:length(coor);
% fprintf(fid,'%u %u \n',coor(i,:));
% end
% fclose(fid)

for i=1:celltracker
outputfile=fullfile(pwd,['Cell_',num2str(i),'.txt']);
fid=fopen(outputfile,'w+');
fprintf(fid,'%d %d\n',XXYY{i}');
fclose(fid);
end


