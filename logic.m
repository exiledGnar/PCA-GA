% 假设你已经有一个包含特征数据的矩阵X，以及对应的类别标签向量Y
x1=X(658:757, 2:6)* selectedComponents;
y1=X(658:757, 1);
% 假设你已经有一个包含训练集特征数据的矩阵projectedFeatures，以及对应的类别标签向量y
% 假设你已经有一个包含测试集特征数据的矩阵x1，以及对应的类别标签向量y1

% 创建逻辑分类模型
logregModel = fitcecoc(projectedFeatures, y);

% 预测类别
y_pred = predict(logregModel, x1);

% 将预测结果转换为数值类型
y_pred = double(y_pred);

% 计算混淆矩阵
cm = confusionmat(y1, y_pred);

% 计算敏感度（Sensitivity）和特异度（Specificity）
se = cm(2, 2) / sum(cm(2, :));
sp = cm(1, 1) / sum(cm(1, :));

% 计算准确率（Accuracy）
acc = sum(diag(cm)) / sum(cm(:));

% 计算AUC
[~, ~, ~, auc] = perfcurve(y1, y_pred, 1);

% 输出结果
fprintf("Sensitivity (SE): %.4f\n", se);
fprintf("Specificity (SP): %.4f\n", sp);
fprintf("Accuracy (ACC): %.4f\n", acc);
fprintf("AUC: %.4f\n", auc);