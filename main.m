%% Nachalo. 
% Opisanie programmy
% opisanie peremennyh

%% Sozdanie ob'ekt "obj" so strukturoi obj_struct
% "obj" - eto vse ob'ekty turnirnogo polya

% sozdanie i opisanie structury "obj"
obj_struct=struct('type',0,'XY',[0 0],'K',0,'vel',0, 'U',0,'brn',randn(5,2));
% type --- tip     
% XY --- koordinaty, pix
% K --- azimuth, rad
% vel --- lineinaya skorost', pix/fr
% U --- uglovaya skorost', rad/fr
% brn --- mozg. Trebuet dorabotki<---------------

%sozdanie massiva ob'ektov
obj(1:10,1)=deal(obj_struct);

%% Pervicnaya populyaciya

for gen=1:100
    %% Turnir
    %% Pervichnoe formirovanie sceny
    for frm=1:100
        %% Opredelenie parametrov sredy
        
        %% Myshlenie agentov, opredelenie upravlyauwih vozdeistvii
        
        %% Dvijenie agentov
    end;
    
    
    %% Formirovanie turnirnoi tablicy
    
    %% Skrewivanie
    
    %% Mutacia
end;
