library(tidyverse)
library(tidymodels)

# 数据清洗
penguins <- read_csv("./penguins.csv")
penguins %>% summarise(across(everything(),~sum(is.na(.)))) # 统计缺失值
# penguins %>% map_df(~mean(is.na(.)))
penguins <- penguins %>% janitor::clean_names() %>% drop_na() # 统一列名

penguins %>% ggplot(mapping=aes(x=bill_length_mm, y=bill_depth_mm, color=species))+
  geom_point() +
  labs(title="三种企鹅吻长度和深度的分布",
  x="Length",
  y="Depth")

split <- penguins %>%
  mutate(species=as_factor(species)) %>%
  # mutate(species=fct_lump(species,1)) %>% 
  initial_split() # 切分数据集，按3：1比例

trainData=training(split)
testData=testing(split)

# 逻辑回归模型
model_logistic <- parsnip::logistic_reg() %>% # 建立模型并按训练集进行拟合
  set_engine("glm") %>% 
  set_mode("classification") %>% 
  fit(species~bill_length_mm+bill_depth_mm, data=trainData)

result_log <- bind_cols( # 使用模型对测试集预测
# predict(model_logistic, new_data = testData, type = "class"),
predict(model_logistic, new_data = testData, type = "prob"),
testData) %>% 
  count(.pred_class, species) %>%
  rename(预测值=.pred_class, 真实值=species)

# 最近邻模型
model_neighbor <- parsnip::nearest_neighbor(neighbors = 10) %>%
  set_engine("kknn") %>% 
  set_mode("classification") %>% 
  fit(species ~ bill_length_mm+bill_depth_mm, data = trainData)

result_neighbor <- predict(model_neighbor, new_data=testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species) %>%
  rename(预测值=.pred_class, 真实值=species)

# 多项式回归模型
model_multinom_reg <- parsnip::multinom_reg() %>% 
  set_engine("nnet") %>% 
  set_mode("classification") %>% 
  fit(species~bill_length_mm + bill_depth_mm, data = trainData)

result_multinom <- predict(model_multinom_reg, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species) %>%
  rename(预测值=.pred_class, 真实值=species)

# 决策树模型
model_decision <- parsnip::decision_tree() %>% 
  set_engine("rpart") %>% 
  set_mode("classification") %>% 
  fit(species ~bill_length_mm + bill_depth_mm, data=trainData)

result_decision <- predict(model_decision, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species) %>%
  rename(预测值=.pred_class, 真实值=species)

# 随机森林模型
model_randomForest <- parsnip::rand_forest() %>% 
  set_engine("randomForest") %>% 
  set_mode("classification") %>% 
  fit(species ~bill_length_mm + bill_depth_mm, data=trainData)

result_randomForest <- predict(model_randomForest, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species) %>%
  rename(预测值=.pred_class, 真实值=species)

result <- list("result_log"=result_log, "result_neighbor"=result_neighbor, 
              "result_multinom"=result_multinom, "result_decision"=result_decision, 
              "result_randomForest"=result_randomForest)
result