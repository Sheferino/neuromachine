fid=fopen('log/20_genlog.bn','r');
k=1;
figure('Renderer','zbuffer');
imagesc(rand(200,400));
clmap=[0  0 0; 1 1 1; 1 0 0];
colormap(clmap);
axis tight;
set(gca,'NextPlot','replaceChildren');
while ~feof(fid)
    pl=fread(fid,size(pole));
    imagesc(pl,[0.5 1.5]);    
    F(k) = getframe;
    title(num2str(k));
    k=k+1;
end;
fclose(fid);
movie(F,10)

% Z = peaks;
% figure('Renderer','zbuffer');
% surf(Z);
% axis tight;
% set(gca,'NextPlot','replaceChildren');
% for j = 1:20
%     surf(sin(2*pi*j/20)*Z,Z)
%     G(j) = getframe;
% end
% movie(G,1) % Play the movie twenty times