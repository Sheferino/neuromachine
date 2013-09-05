%% Chtenie logov
% Vizualizaciya raunda i formirovanie video.

%% Otkrytie logov i chtenie slujebnoi informacii
fid=fopen('log/10_genlog.bn','r');
pole_size=fread(fid,[1 2],'uint16');
kol_obj_1=fread(fid,1,'uint16');
height=pole_size(1);
width=pole_size(2);

%% Podgotovka classa video
vidObj = VideoWriter('neuromachine.avi','Uncompressed AVI');
open(vidObj);

%% Podgotovka grafiki
figure('MenuBar','none','Resize','off','Position',[50 50 width height]);
axes('ActivePositionProperty','position','Units','pixels','Position',[0 0 width height]);
clmap=[0  0 0; 1 1 1; 1 0 0];
colormap(clmap);

%% Formirovanie izobrajeniya
k=1;
while ~feof(fid)
    pl=sparse(fread(fid,[height width],'uint8'));
    h=imagesc(pl,[0.5 (kol_obj_1+0.5)]);
    F(k) = getframe; %zahvat kadra
    writeVideo(vidObj,F(k));
    title(num2str(k));
    k=k+1;
end;

%% Zakrytie logov, zapis' video
fclose(fid);
close(vidObj); %sohranenie video
movie(gcf,F,10); %proigryvanie zahvachennyh kadrov