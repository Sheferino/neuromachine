function [ winners ] = TournamentTable( objects,kol_winners )
%% DESCRIPTION
% Vozvrawaet pobeditelei po kolichestvu ochkov (obj.scr)
%% SYNTAX
% [winners] = TournamentTable( objects,kol_winners )
%% INPUT
% objects-ob'ekty sorevnovanii. Massiv struktur tipa obj
% kol_winners - kolichestvo pobeditelei.
%% OUTPUT
% winners - pobediteli. Massiv struktur tipa obj.

%dobavit' proverki na korrektnost'
[~,ind_survived]=sort([objects.scr],'descend');
ind_survived=ind_survived(1:kol_winners);
winners=objects(ind_survived);
end

