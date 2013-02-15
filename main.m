%% NEUROMACHINE 
% Opisanie programmy
% opisanie peremennyh
% Bazovye peremennye:
kol_obj_1=1; %kolichestvo ob'ektov 1 tipa
kol_obj_2=100; %kolichestvo ob'ektov vtorogo tipa
kol_obj=kol_obj_1+kol_obj_2; % obwee kolichestvo ob'ektov
nn_struct=[2 2 1]; %struktura nn. Kolichestvo neironov v kajdom sloe.
kol_gen=1; %kolichestvo pokolenii
kol_frm=100; %kolichestvo kadrov rascheta (freimov) v kajdom turnire

hght=200;% vysota igrivigi polya
wdth=400;% shirina igrovogo polya

% Bazovye raschetnye peremennye:
nn_length=sum(nn_struct(2:end))+nn_struct(1:(end-1))*nn_struct(2:end)'; % dlina vektora s koefficientami nn.

%% Sozdanie ob'ekt "obj" so strukturoi obj_struct
% "obj" - eto vse ob'ekty turnirnogo polya

% sozdanie i opisanie structury "obj"
obj_struct=struct('type',2,'subtype',1,'xy',[0;0],'K',0,'vel',0, 'U',0,'brn_struct',nn_struct,'brn',rand(1,nn_length));
% type --- tip   
%   1-mertvye, nepodvijnye
%   2-jivye, upravlyautsya neiroset'u
%
% subtype --- podtip, dlya raznyh raznovidnostei
% XY --- koordinaty, pix
% K --- azimuth, rad
% vel --- lineinaya skorost', pix/fr
% acc --- lineinoe uskorenie
% U --- uglovaya skorost', rad/fr
% E --- uglovoe uskorenie
% brn_struct - struktura neiroseti. Kolichestvo neironov v kajdom sloe
% brn --- mozg.

%sozdanie massiva ob'ektov
obj(1:kol_obj)=deal(obj_struct);

%% Pervicnaya populyaciya

for num_gen=1:kol_gen
    %% Turnir
    %% Pervichnoe formirovanie sceny
    pole=zeros(hght,wdth);
    for num_obj=1:kol_obj_1        
        obj(num_obj).type=1;     
        obj(num_obj).xy=round([hght/2;wdth/2]);
        pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=1;    
    end;
    for num_obj=1:kol_obj_2
        obj(num_obj).xy=round([1;1]+[hght-1;wdth-1].*rand(2,1));
        while (pole(obj(num_obj).xy(1),obj(num_obj).xy(2))==1)
            obj(num_obj).xy=round([1;1]+[hght-1;wdth-1].*rand(2,1));
        end;
        pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=1;
    end;
    
    %% Pokadrovyi progon    
    for num_frm=1:kol_frm
        %% Opredelenie parametrov sredy i reakciya na nih
        for num_obj=1:kol_obj
            switch obj(num_obj).type
                case 1 % nepodvijnye ob'ekty
                    disp('сообщение');
                    % passivnye, nikakih parametrov ne opredelyaetsya
                case 2  % agenty, upravlyaemye neirosetyami
                    % faza ocenki obstanovki
                    vct_targets=[obj([obj.type]==1).xy];
                    for k=1:size(vct_targets,2)
                        vct_targets(:,k)=vct_targets(:,k)-obj(num_obj).xy;
                    end;
                    az_target=atan2(vct_targets(1,:),vct_targets(2,:));% napravleniya na celi
                    
                    % faza upravleniya
                    vct_vh=[az_target obj(num_obj).K ];
                    vct_vyh=fc_nn(obj(num_obj).brn_struct,obj(num_obj).brn,vct_vh);
                    obj(num_obj).U=vct_vyh(1);
                    
                    % faza dvijeniya
                    %obj(num_obj).V=tanh(obj(num_obj).V+obj(num_obj).koef_usk*obj(num_obj).acc);
                    % VVESTI KOEFFICIENTY DEISTVIYA USKORENII I SKOROSTEI,
                    %POTENCIAL'NO VNESTI IH V GENETICHESKII OBMEN
                    %obj(num_obj).U=tanh(obj(num_obj).U+obj(num_obj).E);
                    obj(num_obj).K=obj(num_obj).K+obj(num_obj).U;
                    obj(num_obj).xy(1)=round(hght*tanh((obj(num_obj).xy(1)+obj(num_obj).vel*cos(obj(num_obj).K))/hght));
                    obj(num_obj).xy(2)=round(wdth*tanh((obj(num_obj).xy(2)+obj(num_obj).vel*sin(obj(num_obj).K))/wdth));
                    
                    %faza ocenivaniya rezultatov dvijeniya
                    
            end;            
        end;      
        %disp(obj(3).xy);
        
    end;    
    
    %% Formirovanie turnirnoi tablicy
    
    %% Skrewivanie
    
    %% Mutacia
end;
