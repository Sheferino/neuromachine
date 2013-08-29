function [obj, pole] = place_obj(obj, pole)
% DESCRIPTION
% Razmewaet obj na igrovom pole.

[height width]=size(pole);
obj.xy=[randi(height);randi(width)];%sluchainaya tochka
while (pole(obj.xy(1),obj.xy(2))~=0)
    obj.xy=[randi(height);randi(width)];
end;
pole(obj.xy(1),obj.xy(2))=obj.num;


end

