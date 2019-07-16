# 方程组的几何表示 

## 方程组

n 个未知数， n个方程

$$
2x-y=0 \\
-x + 2y =3
$$

### row picture/ 行图像

上述两个方程的行图像如下：
$$
\begin{bmatrix}
2, -1 \\
-1, 2 \\
\end{bmatrix}
\begin{bmatrix}
x\\ y \\
\end{bmatrix}
=
\begin{bmatrix}
0\\ 3 \\
\end{bmatrix}
$$
可简写为：
$$
AX=b
$$

先在坐标上写出两个方程，
```plot
set width 250
set height 250
set point A 1,2
plot [0:3][0:3] 2*x, (3+x)/2
```
两个直线的交点$A(1,2)$就是方程组的解

### column picture / 列图像

上述方程的列图像
$$
x \begin{bmatrix}
2 \\ -1 \\
\end{bmatrix}
+
y \begin{bmatrix}
-1 \\ 2 \\
\end{bmatrix}
=
\begin{bmatrix}
0 \\ 3 \\
\end{bmatrix}
$$

各未知数剩上矩阵的各列， 列图像的目的是把矩阵每一列当成一个向量，找出合适的 $x,y$ 乘以对应向量， 得出列图像右侧的向量， 也称为线性组合（linear combination）（等式的左侧）


从行图像我们已知道方程组的解为$x=1, y=2$ 我们把解放到上面的组合来看一下
$$
1 \begin{bmatrix}
2 \\ -1 \\
\end{bmatrix}
+
2 \begin{bmatrix}
-1 \\ 2 \\
\end{bmatrix}
=
\begin{bmatrix}
0 \\ 3 \\
\end{bmatrix}
$$

```plot
set width 250
set height 250
set arrow from 0,0 to 2,-1
set arrow from 0,0 to -1,2
set arrow from 0,0 to 0,3
set arrow from 2,-1 to 1,1
set arrow from 1,1 to 0,3
set point O 0,0
set point A 2,-1
set point B -1,2
set point C 0,3
plot [-2:3.5][-2:3.5] 10
```
从上图可以看出，一个向量 $\overrightarrow{OA}{}$ 加上两个向量$\overrightarrow{OB}{}$ 刚好组合成向量 $\overrightarrow{OC}{}$

如果取所有可能的$x,y$， 组合的结果将铺满整个平面

以上是2x2 的情况， 我们看看$3*3$的情况， 方程组如下：
$$
2x-y=0\\
-x+2y-z=-1 \\
-3y+4z=4
$$

矩阵表示如下：
$$
A = \begin{bmatrix}
2, -1 , 0 \\
-1,2,-1 \\
-3,0,4
\end{bmatrix},
b=\begin{bmatrix}
0\\  -1 \\ 4
\end{bmatrix}
$$

!!! WARNING
    三维暂时画不了。。。
    这里可以对每个方程在三维坐标系中画一个平面， 三个不平行的平面必相交于一个点， 即方程组的解。

我们再看看方程组的列图像
$$
x \begin{bmatrix}
2 \\ -1 \\ 0
\end{bmatrix}
+ y \begin{bmatrix}
-1 \\ 2 \\ -3 
\end{bmatrix}
+ z \begin{bmatrix}
0 \\ -1 \\ 4
\end{bmatrix}
= \begin{bmatrix}
0 \\ -1 \\ 4
\end{bmatrix}
$$

!!! WARNING
    同样， 这里暂时画不出三维图， 可以在三维坐标系中作出三个向量

上述方程经过特性设计， 所以只需$x=0, y =0 , z=1$即得出方程的解
现在把右侧向量换一下， 变成 $[1,1,-3]^T$ , 对于新右侧向量，解是什么？

新的解为 $x=1, y =1, z=0$， 那么对于任意 b ， 是否都能求解 $Ax =b$?, 用线性组合语言描述这个问题： **各列的线性组合是否能覆盖整个三维空间？**

对于这个问题， 上述方程组的矩阵 $A$的答案是 YES， 该矩阵是一个好矩阵， 它是**非奇异矩阵（non-singular matrix）**， 它是**可逆矩阵（invertible matrix）**， 但另一些矩阵， 答案可能是NO , 比如三个列向量处于同个平面。 或者 第3列刚好等于第1列加上第2列等等， 这种情况称作奇异， 矩阵不可逆。

扩展到N维， 只有其中一维能由其它任意维组合（一个维在组合b时没有貢獻）， 那么这就是个奇异矩阵。

矩阵$Ax=b$ 
$$
\begin{bmatrix}
2, 5 \\
1,3
\end{bmatrix}
\begin{bmatrix}
1 \\ 2 
\end{bmatrix}
=
1 \begin{bmatrix}
2 \\1
\end{bmatrix}
+ 2 \begin{bmatrix}
5\\3 \\
\end{bmatrix}
=\begin{bmatrix}
12 \\ 7
\end{bmatrix}
$$

矩阵 $A$ 乘以向量 $\vec x$ 可以看作 A 各列的线性组合

!!! 
    下一讲解析消元法求解。