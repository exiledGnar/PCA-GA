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

% 数据归一化
% 获取矩阵 X 的列数
numCols = size(X, 2);
% 循环遍历每一列并进行归一化操作
normalizedX = zeros(size(X));  % 创建一个与 X 大小相同的零矩阵
for col = 1:numCols
    column = X(:, col);  % 获取当前列
    minVal = min(column);  % 当前列的最小值
    maxVal = max(column);  % 当前列的最大值
    normalizedColumn = (column - minVal) / (maxVal - minVal);  % 对当前列进行归一化
    normalizedX(:, col) = normalizedColumn;  % 将归一化后的列存储到结果矩阵中
end
X = normalizedX;
% 数据归一化
% 获取矩阵 Y 的列数
numCols = size(Y, 2);
% 循环遍历每一列并进行归一化操作
normalizedY = zeros(size(Y));  % 创建一个与 Y 大小相同的零矩阵
for col = 1:numCols
    column = Y(:, col);  % 获取当前列
    minVal = min(column);  % 当前列的最小值
    maxVal = max(column);  % 当前列的最大值
    normalizedColumn = (column - minVal) / (maxVal - minVal);  % 对当前列进行归一化
    normalizedY(:, col) = normalizedColumn;  % 将归一化后的列存储到结果矩阵中
end
Y = normalizedY;

% 提取标签向量和特征值矩阵
% 假设输入数据为矩阵 X，其中第一列为标签向量，后面的 5 列为特征值
y = X(1:657, 1);  % 标签向量，训练数据
features = X(1:657, 2:6);  % 特征值矩阵,训练

% 使用 PCA 进行降维
numComponents = 5;  % 设置主成分的维度数量
[coeff, score, ~, ~, explained] = pca(features);  % 使用 PCA 进行降维
selectedComponents = coeff(:, 1:numComponents);  % 选择前 numComponents 个主成分

% 将特征值矩阵投影到所选的主成分上
projectedFeatures = features * selectedComponents;

