%% Chtenie logov
% Vizualizaciya i formirovanie video

%podgotovka classa video
vidObj = VideoWriter('neuromachine.avi','Uncompressed AVI');
open(vidObj);

%otkrytie logov i chtenie slujebnoi informacii
fid=fopen('log/10_genlog.bn','r');
pole_size=fread(fid,[1 2],'uint16');
height=pole_size(1);
width=pole_size(2);

%podgotovka grafiki
figure('MenuBar','none','Resize','off','Position',[50 50 width height]);
axes('ActivePositionProperty','position','Units','pixels','Position',[0 0 width height]);
clmap=[0  0 0; 1 1 1; 1 0 0];
colormap(clmap);

k=1;
while ~feof(fid)
    pl=sparse(fread(fid,[height width],'uint8'));
    h=imagesc(pl,[0.5 1.5]);
    F(k) = getframe; %zahvat kadra
    writeVideo(vidObj,F(k));
    title(num2str(k));
    k=k+1;
end;
fclose(fid);
close(vidObj); %sohranenie video
movie(gcf,F,10); %proigryvanie zahvachennyh kadrov