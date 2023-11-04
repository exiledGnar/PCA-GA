%准备测试集
x1=X(658:757, 2:6);
y1=X(658:757, 1);
% LDA降维
ldaModel = fitcdiscr(features, y);
%预测
predictions = predict(ldaModel, x1);

% 计算评估指标
confusionMat = confusionmat(y1, predictions);  % 计算混淆矩阵
truePositives = confusionMat(2, 2);  % 真正例数目
falsePositives = confusionMat(1, 2);  % 假正例数目
trueNegatives = confusionMat(1, 1);  % 真反例数目
falseNegatives = confusionMat(2, 1);  % 假反例数目

sensitivity = truePositives / (truePositives + falseNegatives);  % 计算敏感度 (SE)
specificity = trueNegatives / (trueNegatives + falsePositives);  % 计算特异度 (SP)
accuracy = (truePositives + trueNegatives) / sum(sum(confusionMat));  % 计算准确率 (ACC)

[~, ~, ~, auc] = perfcurve(y1, predictions, 1);  % 计算曲线下面积 (AUC)

% 显示结果
disp('Confusion Matrix:');
disp(confusionMat);
disp('Sensitivity (SE):');
disp(sensitivity);
disp('Specificity (SP):');
disp(specificity);
disp('Accuracy (ACC):');
disp(accuracy);
disp('Area Under the Curve (AUC):');
disp(auc);
