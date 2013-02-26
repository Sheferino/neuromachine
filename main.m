clear all; home;
%% NEUROMACHINE 
% Opisanie programmy
% opisanie peremennyh
% Bazovye peremennye:
kol_obj_1=1; %kolichestvo ob'ektov 1 tipa
kol_obj_2=40; %kolichestvo ob'ektov vtorogo tipa

nn_struct=[2 2 1]; %struktura nn. Kolichestvo neironov v kajdom sloe.
kol_gen=10; %kolichestvo pokolenii
kol_survived_2=round(kol_obj_2*0.25);
kol_frm=100; %kolichestvo kadrov rascheta (freimov) v kajdom turnire

hght=200;% vysota igrivigi polya
wdth=400;% shirina igrovogo polya

% Bazovye raschetnye peremennye:
nn_length=sum(nn_struct(2:end))+nn_struct(1:(end-1))*nn_struct(2:end)'; % dlina vektora s koefficientami nn.
kol_obj=kol_obj_1+kol_obj_2; % obwee kolichestvo ob'ektov

%% Sozdanie ob'ekt "obj" so strukturoi obj_struct
% "obj" - eto vse ob'ekty turnirnogo polya

% sozdanie i opisanie structury "obj"
obj_struct=struct('type',1,'xy',[0;0],'K',0,'vel',1,'acc',0,'U',0,'E',0,'scr',0,'brn_struct',nn_struct,'brn',rand(1,nn_length));
% type --- tip   
%   1-celi
%   2-upravlyautsya neiroset'u agenty
%
% XY --- koordinaty, pix
% K --- azimuth, rad
% vel --- lineinaya skorost', pix/fr
% acc --- lineinoe uskorenie
% U --- uglovaya skorost', rad/fr
% E --- uglovoe uskorenie
%
% scr --- kolichestvo ochkov
%
% brn_struct - struktura neiroseti. Kolichestvo neironov v kajdom sloe
% brn --- mozg.

%sozdanie massiva ob'ektov
obj(1:kol_obj)=deal(obj_struct);

%% Pervicnaya populyaciya
tic;
for num_gen=1:kol_gen
    disp(['Поколение ' num2str(num_gen)]);
    %% Turnir
    %% Pervichnoe formirovanie sceny
    pole=zeros(hght,wdth);
    for num_obj=1:kol_obj_1
        obj(num_obj).type=1;
        obj(num_obj).scr=0;
        obj(num_obj).xy=round([hght/2;wdth/2]);% tochno po centru. Kostyl'
        while (pole(obj(num_obj).xy(1),obj(num_obj).xy(2))~=0)
            obj(num_obj).xy=round([1;1]+[hght-1;wdth-1].*rand(2,1));
        end;
        pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=num_obj;
    end;
    for num_obj=(num_obj+1):kol_obj
        obj(num_obj).type=2;
        obj(num_obj).scr=0;
        obj(num_obj).xy=round([1;1]+[hght-1;wdth-1].*rand(2,1));
        while (pole(obj(num_obj).xy(1),obj(num_obj).xy(2))~=0)
            obj(num_obj).xy=round([1;1]+[hght-1;wdth-1].*rand(2,1));
        end;
        pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=num_obj;
    end;
    
    %% Pokadrovyi progon
    for num_frm=1:kol_frm
        %% Opredelenie parametrov sredy i reakciya na nih
        for num_obj=1:kol_obj
            switch obj(num_obj).type
                case 1 % nepodvijnye ob'ekty
                    %disp('сообщение');
                    % passivnye, nikakih parametrov ne opredelyaetsya
                case 2  % agenty, upravlyaemye neirosetyami
                    % faza ocenki obstanovki
                    [~, targets_dist_pre, targets_azmt] = targets(find([obj.type]==1),[obj([obj.type]==1).xy], obj(num_obj).xy,1);
                    
                    % targets_azmt - napravleniya na celi
                    
                    % faza upravleniya
                    vct_vh=[targets_azmt obj(num_obj).K ];
                    vct_vyh=fc_nn(obj(num_obj).brn_struct,obj(num_obj).brn,vct_vh);
                    obj(num_obj).U=vct_vyh(1);
                    
                    % faza dvijeniya
                    %obj(num_obj).V=tanh(obj(num_obj).V+obj(num_obj).koef_usk*obj(num_obj).acc);
                    % VVESTI KOEFFICIENTY DEISTVIYA USKORENII I SKOROSTEI,
                    %POTENCIAL'NO VNESTI IH V GENETICHESKII OBMEN
                    %obj(num_obj).U=tanh(obj(num_obj).U+obj(num_obj).E);
                    obj(num_obj).K=obj(num_obj).K+obj(num_obj).U;
                    
                    %% Peremewenie s proverkoi na stolknoveniya
                    xy(1)=round(obj(num_obj).xy(1)+obj(num_obj).vel*cos(obj(num_obj).K));
                    xy(2)=round(obj(num_obj).xy(2)+obj(num_obj).vel*sin(obj(num_obj).K));
                    if norm(obj(num_obj).xy-xy')~=0 % proverka na nenulevoe peremewenie
                        
                        if (xy(1)<=0) %proverka na granicu territorii
                            xy(1)=1;
                        elseif (xy(1)>hght)
                            xy(1)=hght;
                        end;
                        if (xy(2)<=0) %proverka na granicu territorii
                            xy(2)=1;
                        elseif (xy(2)>wdth)
                            xy(2)=wdth;
                        end;
                        if pole(xy(1),xy(2))==0 %proverka na stolknovenie
                            pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=0;
                            obj(num_obj).xy=xy';
                            pole(obj(num_obj).xy(1),obj(num_obj).xy(2))=num_obj;
                        else
                            disp(['Столкновение ' num2str(num_obj) ' ' num2str(pole(xy(1),xy(2)))]);
                            % obj ne peremewaetsya
                        end;
                    end;
                    
                    %faza ocenivaniya rezultatov dvijeniya
                    [targets_ind, targets_dist_post,~] = targets(find([obj.type]==1), [obj([obj.type]==1).xy], obj(num_obj).xy,1);
                    vct_im_targets=targets_ind(targets_dist_post<5);
                    if isempty(vct_im_targets)
                    else
                        disp(['Попадание ' num2str(num_obj)]);
                        %obj(num_obj).scr=obj(num_obj).scr+100;
                    end;
                    if targets_dist_post(1)<targets_dist_pre(1)
                        obj(num_obj).scr=obj(num_obj).scr+1;
                    end;
                    
                    
            end;
        end;        
    end;
    toc;
    %% Formirovanie turnirnoi tablicy
    [~,ind_survived]=sort([obj.scr],'descend');
    ind_survived=ind_survived(1:kol_survived_2);
    obj_survived=obj(ind_survived);
    
    %% Skrewivanie
    for i=1:2:kol_survived_2
        for k=(round(kol_obj_2/kol_survived_2)*(i-1)+1):round(kol_obj_2/kol_survived_2)*(i)
            for m=1:length(obj(k).brn)
                obj(k).brn(m)=obj_survived(i+round(rand())).brn(m)+0.01*(rand()-0.5);
            end;
        end;
    end;
    
    
    %% Mutacia
end;
