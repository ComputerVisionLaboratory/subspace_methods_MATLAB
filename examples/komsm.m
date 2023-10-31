load("data/CVLABFace2.mat")
training_data = cvlNormalize(X1);
testing_data = cvlNormalize(X2);

[~, num_samples, ~] = size(training_data);
[num_dim, num_samples_per_set, num_sets, num_classes] = size(testing_data);

num_dim_reference_subspaces = 20;
num_dim_input_subspaces = 5;
sigma = 1;

kernelMatrix = cvlKOMSM(training_data, num_dim_reference_subspaces, sigma);
reference_subspaces = kernelMatrix.TransformS(training_data, num_dim_reference_subspaces);
input_subspaces = kernelMatrix.TransformS(testing_data, num_dim_input_subspaces);
similarities = computeSubspacesSimilarities(reference_subspaces, input_subspaces);
model_evaluation = ModelEvaluation(similarities(:, :, end, end), generateLabels(size(testing_data, 3), num_classes));

displayModelResults('Kernel Ortohonal Mutual Subspace Methods', model_evaluation);