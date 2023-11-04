function result = compareWithColumnMean(matrix)
    % 获取矩阵的列数
    numColumns = size(matrix, 2);
    
    % 计算每列的均值
    columnMeans = mean(matrix);
    
    % 初始化结果矩阵
    result = zeros(size(matrix));
    
    % 根据元素与列均值的比较，更新结果矩阵
    for col = 1:numColumns
        result(:, col) = matrix(:, col) > columnMeans(col);
    end
end