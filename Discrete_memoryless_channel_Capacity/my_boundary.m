% ///// this function checks if the feasible region is violated and modify
% boundary_reg

function new_reg = my_boundary(point,der,reg,l_rate)

temp = point + l_rate*der.*reg;
if sum(temp<=0)>0
    
    idx = find(temp<=0);
    
    reg(idx) = 0;
    
end

new_reg = reg;



end