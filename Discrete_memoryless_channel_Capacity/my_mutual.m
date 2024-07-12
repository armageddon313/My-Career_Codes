% ///// this function calculates mutual information from the input probability vector
% weights 

function y=my_mutual(tr_mat,point)
tr_size = size(tr_mat);


    temp = 0;
for i = 1:tr_size(1)
    for j = 1:tr_size(2)
        nano = point(i)*tr_mat(i,j)*log2(tr_mat(i,j)/sum(point*tr_mat(:,j)));
        k = isnan(nano);
        nano(k)=0;
    temp = temp +nano;
    end
end
y = temp;

end