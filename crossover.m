function offspringPopulation = crossover(parentPopulation)
    % 假设每个个体是一个二进制编码的染色体
    % 在这个例子中，采用单点交叉
    
    % 获取父代个体的数量和染色体长度
    [numParents, chromosomeLength] = size(parentPopulation);
    
    % 初始化后代个体矩阵
    offspringPopulation = zeros(size(parentPopulation));
    
    % 逐对进行交叉操作
    for i = 1:2:numParents-1
        parent1 = parentPopulation(i, :);
        parent2 = parentPopulation(i+1, :);
        
        % 随机选择交叉点
        crossoverPoint = randi(chromosomeLength);
        
        % 生成后代
        offspring1 = [parent1(1:crossoverPoint), parent2(crossoverPoint+1:end)];
        offspring2 = [parent2(1:crossoverPoint), parent1(crossoverPoint+1:end)];
        
        % 将后代添加到后代个体矩阵中
        offspringPopulation(i, :) = offspring1;
        offspringPopulation(i+1, :) = offspring2;
    end
    
    % 如果父代个体数量是奇数，将最后一个个体直接复制到后代个体矩阵中
    if mod(numParents, 2) == 1
        offspringPopulation(end, :) = parentPopulation(end, :);
    end
end