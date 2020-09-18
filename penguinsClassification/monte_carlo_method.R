# library(patchwork)
# library(tidyverse)

set.seed(2222)
n=10000
point <- tibble("x"=runif(n), "y"=runif(n)) # 生成服从均匀分布的10000个点
a <- point %>% ggplot(aes(x=x, y=y))+
  geom_point(aes(color=x**2 + y**2 < 1)) +
  labs(title="点分布图")+
  guides(color = guide_legend(title = "点处于圆内"))

data <- point %>%  # 计算估计数据
  mutate("inside" =(if_else(x**2 + y**2 < 1, 1, 0))) %>% 
  rowid_to_column("N") %>% 
  mutate("estimate"=4*cumsum(inside)/N) 
b <- data %>% ggplot(aes(x=N, y=estimate))+
  geom_line(color="red", size=1.1)+
  geom_hline(yintercept = pi)+
  labs(title="估计值")

a + b +
  plot_annotation(
    tag_levels = "A",
    title = "蒙特卡罗模拟估计圆周率",
    subtitle = "以10000点为例",
    caption = "Powered by ggplot2"
  )
ggsave(filename = "ggplot.png", dpi = 300)
tail(data, 5)
