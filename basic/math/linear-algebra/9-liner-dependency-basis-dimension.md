# 线性相关性， 基和维数

对于 $m \times n$ 矩阵 $A(m<n)$, 存在$Ax=0$的非零解， 未知数的个数 大于方程的个数。解存在的原因： 一定存在某些自由变量（至少一个）

## 向量无关性(Independency)

什么条件下， 向量 $x_1, x_2,\dotsc, x_3$ 是无关的？  
如果不存在结果为零向量的组合， 向量组 线性无关（排除0组合）
$$
c_1 x_1 + c_2 x_2 + \dotsb + c_3 x_3 \neq 0
$$

!!! TIP
    * 向量组中包含零向量， 则必然相关
    * 如果向量 $v_1, v_2, \dotsb, v_n$ 是$A$ 的列， 如果它们是无关的， 那么矩阵 $A$ 的零空间只有零向量。（秩 r =n, 没有自由变量）
    * 如果向量组相关， 则表示零空间中存在其它一些向量使$Ac=0$（c 为非零向量， 秩 rank < n , 有自由变量）

## 基 basis

向量空间的一组**基**是指： 一系列具有两个特性的向量 $v_1, v_2, \dotsb, v_n$ ：
1. 它们是线性无关的
2. 它们生成子空间（向量组的个数刚好）

示例：
$R^3$ 空间的一个基是$\begin{bmatrix}1\\0\\0\end{bmatrix}\begin{bmatrix}0\\1\\0\end{bmatrix}\begin{bmatrix}0\\0\\1\end{bmatrix}$ ， 另一个基：$\begin{bmatrix}1\\1\\2\end{bmatrix}\begin{bmatrix}2\\2\\5\end{bmatrix}\begin{bmatrix}3\\3\\8\end{bmatrix}$  。

!!! ERROR "" 
    这个矩阵有误， 不可逆， 行相关

如何检验？
可以把它们当作矩阵的列向量， 通过消元和变换， 看是否有自由变量， 所有列都是主列。

$R^n$ 中 n 个向量构成基， 当包含这些向量的 $m\times n$ 矩阵是可逆的。

!!! 
    如果只是$\begin{bmatrix}1\\1\\2\end{bmatrix}\begin{bmatrix}2\\2\\5\end{bmatrix}$, 那么它们是它们构成的列空间的基

## 维 dimesion

给出一个子空间， 基向量的个数称为这个空间的维。

对于 $C(A)$ 空间， 能生成子空间吗？
$$
\begin{bmatrix}
1& 2 & 3 & 1 \\1& 1 & 2 & 1 \\1& 2 & 3 & 1 \\
\end{bmatrix}
$$


$$
N(A) = \begin{bmatrix}-1 \\ -1 \\ 0\end{bmatrix}
$$

所以 $col_1$与 $col_2$ 是 $C(A)$ 的基

$2= rank(A) = 主列数量 = C(A) 的维$  
零空间的维数是自由的个数$=n-r$