% ///// this function calculates gradient direction with respect to allowed
% directions not to violate feasible region 

function y = my_derivative(tr_mat,in_dist,reg)

L = length(in_dist);
der = zeros(1,L);

per_vec2 = zeros(1,L);
per_vec2(reg==1)=1;
per_vec2 = per_vec2/sqrt(sum(per_vec2.^2));


for i = 1:L
    temp = 0;
    for j = 1:length(tr_mat(1,:))
        nano = tr_mat(i,j)*log2(tr_mat(i,j)/sum(in_dist*tr_mat(:,j)));
        k = isnan(nano);
        nano(k)=0;
    temp = temp + nano;
    end
    der(i) = temp - log2(exp(1));
end

%///// projecting gradient on the feasible region

der = reg.*der;
der = der - (der*per_vec2')*per_vec2;



y = der;

end