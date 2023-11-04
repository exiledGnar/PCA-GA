function fitness = evaluateFeatures(data, labels)
    % 计算总体均值
    overallMean = mean(data);
    
    % 获取类别标签
    uniqueLabels = unique(labels);
    numClasses = numel(uniqueLabels);
    
    % 初始化类间散布矩阵和类内散布矩阵
    Sb = zeros(size(data, 2));
    Sw = zeros(size(data, 2));
    
    % 计算类间散布矩阵和类内散布矩阵
    for i = 1:numClasses
        % 获取当前类别的样本
        classData = data(labels == uniqueLabels(i), :);
        
        % 计算当前类别的样本均值
        classMean = mean(classData);
        
        % 计算类间散布矩阵的贡献
        Sb = Sb + numel(classData) * (classMean - overallMean)' * (classMean - overallMean);
        
        % 计算类内散布矩阵的贡献
        classSw = (classData - classMean)' * (classData - classMean);
        Sw = Sw + classSw;
    end
    
    % 计算适应度函数值
    fitness = trace(Sb) / trace(Sw);
end