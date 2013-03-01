function [ vct_out ] = crossing( vct_in_1,vct_in_2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


vct_out=zeros(1,length(vct_in_1));
%Skrewivanie
for k=1:length(vct_in_1)
    if rand()>0.5
        vct_out(k)=vct_in_1(k);
    else
        vct_out(k)=vct_in_2(k);
    end;
    %mutaciya
    vct_out(k)=vct_out(k)+0.001*(rand()-0.5);
end;

end

