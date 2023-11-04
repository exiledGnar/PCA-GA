%% 数据导入
% 假设数据矩阵X包含N个样本，每个样本有5个特征
% X 是一个 Nx5 的矩阵
% 假设标签向量y包含N个样本的类别标签
% y 是一个大小为Nx1的向量，取值为1或2，表示两个类别

%导入数据
% 设置文件路径和文件名
file_path = 'E:\模式识别\';
file_name = '2023年模式识别与机器学习数据集汇总.xls';

% 构建完整的文件路径
full_path = fullfile(file_path, file_name);

% 导入Excel数据
X=xlsread(full_path,1);
%裁剪数据
Y = X(:, 2:8);
X = X(:, 2:7);
% 从矩阵X中分离标签和特征
labels = X(:, 1);
data = Y(:, 2:end);
seed = 123;  % 设置随机种子
rng(seed);  % 设置随机数生成器的种子

% 在这之后的随机数生成操作都会使用相同的种子，以确保结果可以重复
%% 假设你的列向量名字为vector，大小为n
% 假设你的矩阵名字为data
[m, n] = size(data);  % 获取矩阵的行数和列数

output = zeros(m, n-1);   % 创建一个与矩阵相同大小的全零矩阵

for col = 1:n-1
    column_vector = data(:, col);  % 获取矩阵的第col列向量
    
    [~, ranks] = sort(column_vector);  % 对列向量中的元素进行排序，得到排名
    
    output(ranks(1:532), col) = 1;  % 将排名前532的元素置为1
end
% 假设矩阵Y和output的大小分别为 m1 x n1 和 m2 x n2
Y_last_column = Y(:, end);  % 获取矩阵Y的最后一列

output = horzcat(output, Y_last_column);  % 将Y的最后一列添加到output的最后
data = output;
%% 定义适应度函数
fitnessFunc = @(features) evaluateFeatures(data, labels);

% 初始化参数
populationSize = 200;
numFeatures = size(data, 2);
maxIterations = 2000;
mutationRate = 0.01;

% 初始化种群
population = randi([0, 1], populationSize, numFeatures);

% 遗传算法主循环
for iteration = 1:maxIterations
    % 计算适应度值
    fitnessValues = fitnessFunc(population);
    
    % 选择操作
    selectedIdx = selection(fitnessValues);
    selectedPopulation = population(selectedIdx, :);
    
    % 交叉操作
    offspringPopulation = crossover(selectedPopulation);
    
    % 变异操作
    mutatedPopulation = mutation(offspringPopulation, mutationRate);
    
    % 更新种群
    population = [selectedPopulation; mutatedPopulation];
    
    % 重复步骤3至6，直到达到停止条件
    
end

% 计算最终适应度值
fitnessValues = fitnessFunc(population);

% 选择最优特征子集
bestFeatures = population(find(fitnessValues == max(fitnessValues), 1), :);
indices = find(bestFeatures);
% 假设您已经得到了最佳特征子集，存储在indices变量中

% 提取最佳特征子集对应的数据
% 假设 bestFeatures 是一个包含最佳特征索引的向量
selectedData = data(:,indices);

% 划分训练集和测试集（以示例为准，您可以根据实际数据进行调整）
trainRatio = 0.8; % 训练集比例
cvRatio = 0.1; % 交叉验证集比例
testRatio = 0.1; % 测试集比例

cvp = cvpartition(labels, 'HoldOut', testRatio); % 创建划分对象
trainIdx = training(cvp); % 获取训练集索引
testIdx = test(cvp); % 获取测试集索引

% 训练决策树分类器
tree = fitctree(selectedData(trainIdx, :), labels(trainIdx));

% 在测试集上进行预测
labelsPredicted = predict(tree, selectedData(testIdx, :));

% 计算性能指标
confusionMatrix = confusionmat(labels(testIdx), labelsPredicted);
TP = confusionMatrix(2, 2); % True Positive
TN = confusionMatrix(1, 1); % True Negative
FP = confusionMatrix(1, 2); % False Positive
FN = confusionMatrix(2, 1); % False Negative

SE = TP / (TP + FN); % 敏感度（Sensitivity）
disp('SE=')
disp(SE);
SP = TN / (TN + FP); % 特异度（Specificity）
disp('SP=')
disp(SP);
Acc = (TP + TN) / (TP + TN + FP + FN); % 准确率（Accuracy）
disp('Acc=')
disp(Acc);

% 可视化决策树
view(tree, 'Mode', 'graph');