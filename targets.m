function [mtr_targets] = targets(targets_ind, targets_xy, obj_xy,kol_targets )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
targets_kol=size(targets_xy,2);
mtr_targets=zeros(targets_kol,3);
for k=1:targets_kol
vctr_target=targets_xy(:,k)-obj_xy;
mtr_targets(k,:)=[targets_ind(k) norm(vctr_target) atan2(vctr_target(1),vctr_target(2))];
end



