function [targets_index targets_dist targets_azmt] = targets(targets_ind, targets_xy, obj_xy,kol_targets )
% DESCRIPTION
% Vozvrawaet parametry celei
% SYNTAX
% [targets_index targets_dist targets_azmt] = targets(targets_ind, targets_xy, obj_xy,kol_targets )
% INPUT
% targets_ind - indeksy celei
% targets_xy - ih koordinaty
% obj_xy - koordinaty ob'ekta
% kol_targets - kolichestvo vidimyh celei (po udaleniu)
% OUTPUT
% targets_index - indeksy celei v poryadke udaleniya
% targets_dist - rasstoyaniya do nih
% targets_azmt - azimut na celi

targets_kol=size(targets_xy,2);
mtr_targets=zeros(targets_kol,3);
for k=1:targets_kol
    vctr_target=targets_xy(:,k)-obj_xy;
    mtr_targets(k,:)=[targets_ind(k) norm(vctr_target) -atan2(vctr_target(2),vctr_target(1))];
end

[~,ind]=sort(mtr_targets(:,2));
mtr_targets=mtr_targets(ind(1:kol_targets),:);
targets_index=mtr_targets(:,1);
targets_dist=mtr_targets(:,2);
targets_azmt=mtr_targets(:,3);

