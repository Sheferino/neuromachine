function vyh_vect=fc_nn(nn_struct,nn_vect,vh_vect)
%  SYNTAX
% vyh_vect=fc_nn(nn_struct,nn_vect,vh_vect)
%  INPUT
% nn_struct - vektor so strukturoi neiroseti (kolichestvo neironov v kajdom sloe);
% nn_vect - vector s vesami neiroseti;
% vh_vect - vektor vhodnyh velichin
%  OUTPUT
% vyh_vect - vektor vyhodnyh velichin

% chtenie vektora neiroseti v sootvetstvii so strukturoi
% W -matrica vesov svyazei neiroseti
% a11 - ves ot 1 neirona 1 sloya k 1 neironu vtorogo sloya,
% a12 - ves ot 2 neirona 1 sloya k 1 neironu vtorogo sloya.
% bias - vektor smewenii v neironah
for i=1:(length(nn_struct)-1)
    sloi(i)=struct('W',zeros(nn_struct(i:i+1)),'bias',zeros(1,nn_struct(i+1)));
    sloi(i).W(1:end)=nn_vect(1:(nn_struct(i)*nn_struct(i+1)));
    nn_vect(1:(nn_struct(i)*nn_struct(i+1)))=[];
    sloi(i).bias(1:end)=nn_vect(1:nn_struct(i+1));
    nn_vect(1:nn_struct(i+1))=[];
end;

% raschet vyhodnogo vektora
vect{1}=vh_vect;
for i=1:(length(nn_struct)-1)
    vect{i+1}=tanh(vect{i}*sloi(i).W+sloi(i).bias);
end;
vyh_vect=vect{end};
end

