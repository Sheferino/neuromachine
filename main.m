%% Nachalo. 
% Opisanie programmy
% opisanie peremennyh
% Bazovye peremennye:
kol_obj=1; % kolichestvo ob'ektov
nn_struct=[2 800 800 1]; %struktura nn. Kolichestvo neironov v kajdom sloe.
kol_gen=1; %kolichestvo pokolenii
kol_frm=1; %kolichestvo kadrov rascheta (freimov) v kajdom turnire

% Bazovye raschetnye peremennye:
nn_length=sum(nn_struct(2:end))+nn_struct(1:(end-1))*nn_struct(2:end)'; % dlina vektora s koefficientami nn.

%% Sozdanie ob'ekt "obj" so strukturoi obj_struct
% "obj" - eto vse ob'ekty turnirnogo polya

% sozdanie i opisanie structury "obj"
obj_struct=struct('type',0,'XY',[0 0],'K',0,'vel',0, 'U',0,'brn_struct',nn_struct,'brn',rand(1,nn_length));
% type --- tip     
% XY --- koordinaty, pix
% K --- azimuth, rad
% vel --- lineinaya skorost', pix/fr
% U --- uglovaya skorost', rad/fr
% brn_struct - struktura neiroseti. Kolichestvo neironov v kajdom sloe.
% brn --- mozg.

%sozdanie massiva ob'ektov
obj(1:kol_obj)=deal(obj_struct);

%% Pervicnaya populyaciya

for num_gen=1:kol_gen
    %% Turnir
    %% Pervichnoe formirovanie sceny
    for num_frm=1:kol_frm
        %% Opredelenie parametrov sredy
        
        %% Myshlenie agentov, opredelenie upravlyauwih vozdeistvii
        for num_obj=1:kol_obj
            vh_vect=[az_target obj(num_obj).K ];
            vyh_vect=fc_nn(obj(num_obj).brn_struct,obj(num_obj).brn,vh_vect);
        end;
       
        
        %% Dvijenie agentov
    end;
    
    
    %% Formirovanie turnirnoi tablicy
    
    %% Skrewivanie
    
    %% Mutacia
end;
