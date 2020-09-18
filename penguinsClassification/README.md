# 数据
数据操作基于tidyverse  
模型构建基于tidymodels

数据来源如下, 也可直接使用同目录下的数据文件

```{r}
install.packages("palmerpenguins")
data(package = 'palmerpenguins')
```

# 字段含义

|variable          |class   |description
|:---:             |:---:   |:--:
|species           |integer |企鹅种类(Adelie, Gentoo, Chinstrap)
|island            |integer |所在岛屿(Biscoe, Dream, Torgersen)
|bill_length_mm    |double  |嘴峰长度(单位毫米)
|bill_depth_mm     |double  |嘴峰深度(单位毫米)
|flipper_length_mm |integer |鰭肢长度(单位毫米)
|body_mass_g       |integer |体重 (单位克)
|sex               |integer |性别
|year              |integer |记录年份

# 预测结果

```{r}
r$> result
$result_log
# A tibble: 4 x 3
  预测值 真实值        n
  <fct>  <fct>     <int>
1 Adelie Adelie       39
2 Adelie Chinstrap     4
3 Gentoo Gentoo       21
4 Gentoo Chinstrap    19

$result_neighbor
# A tibble: 4 x 3
  预测值    真实值        n
  <fct>     <fct>     <int>
1 Adelie    Adelie       39
2 Adelie    Chinstrap     4
3 Gentoo    Gentoo       21
4 Chinstrap Chinstrap    19

$result_multinom
# A tibble: 5 x 3
  预测值    真实值        n
  <fct>     <fct>     <int>
1 Adelie    Adelie       39
2 Adelie    Chinstrap     4
3 Gentoo    Gentoo       21
4 Gentoo    Chinstrap     1
5 Chinstrap Chinstrap    18

$result_decision
# A tibble: 8 x 3
  预测值    真实值        n
  <fct>     <fct>     <int>
1 Adelie    Adelie       38
2 Adelie    Gentoo        5
3 Adelie    Chinstrap     7
4 Gentoo    Gentoo       15
5 Gentoo    Chinstrap     1
6 Chinstrap Adelie        1
7 Chinstrap Gentoo        1
8 Chinstrap Chinstrap    15

$result_randomForest
# A tibble: 5 x 3
  预测值    真实值        n
  <fct>     <fct>     <int>
1 Adelie    Adelie       38
2 Adelie    Chinstrap     4
3 Gentoo    Gentoo       21
4 Chinstrap Adelie        1
5 Chinstrap Chinstrap    19
```
