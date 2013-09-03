function [ objects ] = procreation(objects,parents )
%  DESCRIPTION
% Vozvrawaet rezul'tat skrewivaniya i mutacii.
%  SYNTAX
% [ children ] = procreation( parents,kol_children )
%  INPUT
% 
%  OUTPUT
% 

kol_parents=length(parents);
kol_children=length(find([objects.type]==parents(1).type));
l_brn=length(parents(1).brn);
ind_type=find([objects.type]==parents(1).type,1,'first')-1;%indeks pervogo ob'ekta s tem je tipom

k_v=2*kol_children/kol_parents; % koefficient vosproizvedeniya potomstva
if mod(k_v,1)
    %neceloe, choto nado delat'
else
    k_v=floor(k_v);
    %celoe chislo potomkov
    
end;




for k=1:2:kol_parents
    for m=1:k_v
        vct_rand=randi([0 1],1,l_brn);
        %skrewivanie
        objects((k-1)*k_v/2+m+ind_type).brn=parents(k).brn.*(vct_rand==1)+parents(k+1).brn.*(vct_rand==0);
        %mutaciya
        objects((k-1)*k_v/2+m+ind_type).brn=objects((k-1)*k_v/2+m+ind_type).brn+0.001*randi([-50 50],1,l_brn);
    end
end;
end

