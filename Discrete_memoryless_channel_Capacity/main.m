%//// final results are : "opt_input" (optimum input probability weights)
% and "capacity" : capacity of the channel

clear

clc

% the transition matrix could be inserted in the format below as tr_mat =...
% look at the examples

%tr_mat = rand(100,100); % initialize a random transition matrix 

tr_mat = [0.9,0.1,0;0,0.1,0.9]; % erasure channel
%tr_mat = [0.3,0.2,0.5;0.5,0.3,0.2;0.2,0.5,0.3]; % symmetric channel
%tr_mat = [1/3,1/6,1/2;1/3,1/2,1/6]; % weak symmetric channel

tr_size = size(tr_mat);

learning_rate = 0.1; % the learning rate could be changed


%///////// if the input matrix is random, this loop force sum of each row's
%elements to be 1

for i=1:tr_size(1)
   v = sum(tr_mat(i,:));
   tr_mat(i,:) = tr_mat(i,:)/v;
end

%///////// 




%///////// create random input (a better way is to initialize with center)
rand_in = rand(1,tr_size(1));
rand_in = rand_in/sum(rand_in);
%//////////



cur_point = rand_in;
cap = [];

boundary_reg = ones(1,tr_size(1));

tic
while true % iterations are done in this loop
%for i=1:100


while true 
%////////// this loop checks whether the iteration violates feasible region 
%(preventing negative probabilites) and modify the allowed directions by boundary_reg
reg_temp = boundary_reg;
 jacobian = my_derivative(tr_mat,cur_point,boundary_reg); 
boundary_reg = my_boundary(cur_point,jacobian,boundary_reg,learning_rate);
  if reg_temp == boundary_reg
      break;
  end
end
%////////////

  cur_point  = cur_point + learning_rate*jacobian;
  cap = [cap , my_mutual(tr_mat,cur_point)];

  if length(cap)>2 && cap(end)-cap(end-1)<0.0000001 % desired convergence could be changed (change 0.000001)
      break
  end
  
end
toc

opt_input = cur_point;
capacity = cap(end);

fig1 = figure;
plot(cap);
title('capacity convergence');
xlabel('iteration number');
ylabel('capacity');

fig2 = figure;
plot(1:length(opt_input),opt_input);
title('optimum input diagram');
xlabel('index of weight');
ylabel('weight');






