%part3.3男生身高数据，最大似然估计法
estimatedParams1 = fitdist(data1, 'Normal');

% 提取估计的均值和标准差
mu1 = estimatedParams1.mu;
sigma1 = estimatedParams1.sigma;

% 显示估计的参数
disp(['男生估计的均值：', num2str(mu1)]);
disp(['男生估计的标准差：', num2str(sigma1)]);
disp(['男生估计的方差：',num2str(sigma1*sigma1)]);


%女生身高数据，最大似然估计法
estimatedParams2 = fitdist(data2, 'Normal');

% 提取估计的均值和标准差
mu2 = estimatedParams2.mu;
sigma2 = estimatedParams2.sigma;

% 显示估计的参数
disp(['女生估计的均值：', num2str(mu2)]);
disp(['女生估计的标准差：', num2str(sigma2)]);
disp(['女生估计的方差：',num2str(sigma2*sigma2)]);

%样本方差
Sam_v = var(data1);
disp(['男生样本方差=',num2str(Sam_v)]);
Sam_v = var(data2);
disp(['女生样本方差=',num2str(Sam_v)]);