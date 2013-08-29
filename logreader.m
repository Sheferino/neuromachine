%% Chtenie logov
% Vizualizaciya i formirovanie video

%podgotovka classa video
vidObj = VideoWriter('neuromachine.avi');
open(vidObj);

%otkrytie logov i chtenie slujebnoi informacii
fid=fopen('log/10_genlog.bn','r');
pole_size=fread(fid,[1 2]);
height=pole_size(1);
width=pole_size(2);

%podgotovka grafiki
figure('MenuBar','none','Resize','off','Position',[50 50 width height]);
axes('NextPlot','replaceChildren','ActivePositionProperty','position','Units','pixels','Position',[0 0 width height]);
%imagesc(rand(1000,1000));
clmap=[0  0 0; 1 1 1; 1 0 0];
colormap(clmap);
%axis tight;


k=1;
while ~feof(fid)
    pl=sparse(fread(fid,[height width]));
    h=imagesc(pl,[0.5 1.5]); 
    %inspect(h);
    F(k) = getframe;
    writeVideo(vidObj,F(k));
    title(num2str(k));
    k=k+1;
end;
fclose(fid);
close(vidObj);
%movie(gcf,F,10)

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