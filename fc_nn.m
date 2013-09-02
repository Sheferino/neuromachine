function [nn_vect_out,varargout]=fc_nn(nn_struct,nn_vect,varargin)
%  DESCRIPTION
% Function vypolnyaet raschet upravlyauwego vozdeistviya neiroseti.
% Pri pervom zapuske generit koefficienty neiroseti
%  SYNTAX
% [nn_vect output_param]=fc_nn(nn_struct,nn_vect,input_param)
%  INPUT
% nn_struct - vektor so strukturoi neiroseti (kolichestvo neironov v kajdom sloe bez ucheta vhodnogo i vyhodnogo sloya);
% nn_vect - vector s vesami neiroseti. Esli pust - generitsya novyi.
% input_param - vhodnye velichiny, comma-separated
%  OUTPUT
% nn_vect_out - vektor s vesami neiroseti. Raven vhodnomu,esli tot
% nepustoi.
% output_param - vyhodnye velichiny, comma-separated

%% Generaciya novoi neiroseti
% Zapuskaetsya tolko esli vhodnaya neiroset' pusta
nn_struct_full=[(nargin-2) nn_struct (nargout-1)]; %polnaya struktura neiroseti s uchetom vhodnogo i vyhodnogo sloya
if isempty(nn_vect)
    nn_length=sum(nn_struct_full(2:end))+nn_struct_full(1:(end-1))*nn_struct_full(2:end)'; % dlina vektora s koefficientami nn.
    nn_vect=(randi(1000,[1,nn_length])-500)/1000; 
end
nn_vect_out=nn_vect;

%% Chtenie vektora neiroseti v sootvetstvii so strukturoi
% W -matrica vesov svyazei neiroseti
% a11 - ves ot 1 neirona 1 sloya k 1 neironu vtorogo sloya,
% a12 - ves ot 2 neirona 1 sloya k 1 neironu vtorogo sloya.
% bias - vektor smewenii v neironah
for i=1:(length(nn_struct_full)-1)
    sloi(i)=struct('W',zeros(nn_struct_full(i:i+1)),'bias',zeros(1,nn_struct_full(i+1)));
    sloi(i).W(1:end)=nn_vect(1:(nn_struct_full(i)*nn_struct_full(i+1)));
    nn_vect(1:(nn_struct_full(i)*nn_struct_full(i+1)))=[];
    sloi(i).bias(1:end)=nn_vect(1:nn_struct_full(i+1));
    nn_vect(1:nn_struct_full(i+1))=[];
end;

%% Raschet vyhodnogo vektora
vect{1}=cell2mat(varargin); %dlya uskoreniya mojno vect sdelat' nemassivom, ubrav {i}
for i=1:(length(nn_struct_full)-1)
    vect{i+1}=tanh(vect{i}*sloi(i).W+sloi(i).bias);
end;
for k=1:(nargout-1)
    varargout{k}=vect{end}(k);
end
end

