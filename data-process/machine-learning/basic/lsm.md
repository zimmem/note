# 最小二乘法

> 使用二次函数拟合一组数据点的结果
最小二乘法（英语：least squares method，又称最小平方法）是一种数学优化技术。它通过最小化误差的平方和寻找数据的最佳函数匹配。[https://zh.wikipedia.org/wiki/%E6%9C%80%E5%B0%8F%E4%BA%8C%E4%B9%98%E6%B3%95]

## 示例

```plot
set width 250
set height 250
set point A 1,6
set point B 2,5
set point C 3,7
set point D 4,10
plot [0:5][4:10] 3.5+1.4*x
```


某次实验得到了四个数据点 $(x,y)$： $A(1,6)$、 $B(2,5)$、 $C(3,7)$ 、 $D(4,10)$我们希望找出一条和这四个点最匹配的直线 $y=\beta_{1}+\beta_{2} x$，即找出在某种「最佳情况」下能够大致符合如下超定线性方程组的 $\beta _{1}$ 和 $\beta _{2}$:
$$
\begin{array}{l}
{\beta_{1}+1 \beta_{2}=6} \\ 
{\beta_{1}+2 \beta_{2}=5} \\ 
{\beta_{1}+3 \beta_{2}=7} \\ 
{\beta_{1}+4 \beta_{2}=10}
\end{array}
$$
最小二乘法采用的手段是尽量使得等号两边的方差最小，也就是找出这个函数的最小值：
$$
\begin{aligned} 
S(\beta_{1}, \beta_{2})=&[6-(\beta_{1}+1 \beta_{2})]^{2} \\ 
                        &+[5-(\beta_{1}+2 \beta_{2})]^{2} \\ 
                        &+[7-(\beta_{1}+3 \beta_{2})]^{2} \\
                        &+[10-(\beta_{1}+4 \beta_{2})]^{2} 
\end{aligned}
$$
最小值可以通过对 $S(\beta _{1},\beta _{2})$ 分别求 $\beta_{1}$ 和 $\beta_{2}$ 的偏导数，然后使它们等于零得到。
$$
{\frac{\partial S}{\partial \beta_{1}} =0 =8 \beta_{1}+20 \beta_{2}-56} \\ 
\\ 
{\frac{\partial S}{\partial \beta_{2}} =0 =20 \beta_{1}+60 \beta_{2}-154}
$$
如此就得到了一个只有两个未知数的方程组，很容易就可以解出：
$$
\beta _{1}=3.5 \\ 
 \beta _{2}=1.4
$$
也就是说直线 $y=3.5+1.4x$ 是最佳的。
