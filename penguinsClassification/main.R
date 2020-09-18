penguins <- read_csv("./demo_data/penguins.csv")
penguins %>% summarise(across(everything(),~sum(is.na(.))))
penguins %>% map_df(~mean(is.na(.)))
penguins <- penguins %>% clean_names() %>% drop_na()

penguins %>% ggplot(mapping=aes(x=bill_length_mm, y=bill_depth_mm, color=species))+
  geom_point()

split <- penguins %>%
  mutate(species=as_factor(species)) %>%
  # mutate(species=fct_lump(species,1)) %>% 
  initial_split()

trainData=training(split)
testData=testing(split)

# 逻辑回归模型
model_logistic <- parsnip::logistic_reg() %>% set_engine("glm") %>% set_mode("classification") %>% 
fit(species~bill_length_mm+bill_depth_mm, data=trainData)

bind_cols(
predict(model_logistic, new_data = testData, type = "class"),
predict(model_logistic, new_data = testData, type = "prob"),
testData) %>% 
  count(.pred_class, species)

# 最近邻模型
model_neighbor <- parsnip::nearest_neighbor(neighbors = 10) %>%
  set_engine("kknn") %>% 
  set_mode("classification") %>% 
  fit(species ~ bill_length_mm+bill_depth_mm, data = trainData)

predict(model_neighbor, new_data=testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species)

# 多项式回归模型
model_multinom_reg <- parsnip::multinom_reg() %>% 
  set_engine("nnet") %>% 
  set_mode("classification") %>% 
  fit(species~bill_length_mm + bill_depth_mm, data = trainData)

predict(model_multinom_reg, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species)

# 决策树模型
model_decision <- parsnip::decision_tree() %>% 
  set_engine("rpart") %>% 
  set_mode("classification") %>% 
  fit(species ~bill_length_mm + bill_depth_mm, data=trainData)

predict(model_decision, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species)

# 随机森林模型
model_randomForest <- parsnip::rand_forest() %>% 
  set_engine("randomForest") %>% 
  set_mode("classification") %>% 
  fit(species ~bill_length_mm + bill_depth_mm, data=trainData)

predict(model_randomForest, new_data = testData) %>% 
  bind_cols(testData) %>% 
  count(.pred_class, species)