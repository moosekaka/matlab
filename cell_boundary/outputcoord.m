for i=1:celltracker
outputfile=fullfile(pwd,['Cell_',num2str(i),'.txt']);
fid=fopen(outputfile,'w+');
fprintf(fid,'%d %d\n',XXYY{i}');
fclose(fid);
end


