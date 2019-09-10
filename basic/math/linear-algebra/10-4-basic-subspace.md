# 四个基本子空间

对于 $m \times n$ 矩阵$A$, 存在四个基本子空间

1. 列空间 $C(A)$
2. 零空间 $N(A)$
3. 行空间 $C(A^T)$  
   $A$ 的行的所有组合
4. 左零空间  $N(A^T)$

* $C(A)$ 构成 $R^m$ 的一个子空间
* $N(A)$ 构成 $R^n$ 的一个子空间
* $C(A^T)$ 构成 $R^n$ 的一个子空间
* $N(A^T)$ 构成 $R^m$ 的一个子空间

## 子空间的基、维

1. 列空间 $C(A)$  
   基： 主列  
   维： 矩阵 $A$ 的秩$r$
2. 零空间 $N(A)$  
   基： 特解  
   维： $n-r$
3. 行空间 $C(A^T)$  
   基： $[I,F]$  
   维： 矩阵 $A$ 的秩$r$
4. 左零空间 $N(A^T)$  
   基：  
   维：$m-r$

求解 $A$ 的行空间， 可以使用转置用消元
$$
A=\begin{bmatrix}1 &2 &3&1 \\ 1 &1 &2&1 \\ 1 &2 &3&1\end{bmatrix}
\rightarrow
\begin{bmatrix}1 &0 &1&1 \\ 0&1&1&0 \\ 0&0  &0&0\end{bmatrix}=R
$$
$R$与$A$ 有不同的列空间， 但有相同的行空间。 $A$ 的行空间是 $R$ 的前 $r$ 行 $[I, F]$,  通过 $I,F$ 反向消元可得 $A$ ， $[I,F]$ 是行空间的最简形式

求解 $A$ 的左零空间
$$
A^Ty=0 \rightarrow y^TA=0^T
$$

高斯-亚当消元法：
$$
E\cdot[A_{m\times n} | I_{m\times n}] = [R_{m\times n} | E_{m\times n}]
$$
如
$$
\begin{bmatrix}-1 &2 &0 \\ 1 &-1 &0 \\ -1 &0 &1\end{bmatrix}
\left[\begin{array}{cccc|ccc}
    1&2&3&1&1&0&0 \\ 1&1&2&1&0&1&0 \\ 1&2&3&1&0&0&1
\end{array}\right]
=
\left[\begin{array}{cccc|ccc}
    1&0&1&1&-1&2&0 \\ 0&1&1&0&1&-1&0 \\ 0&0&0&0&-1&0&1
\end{array}\right]
$$
由上例可得 $E$ 的最后 $m-r$ 行剩以 $A$ 得到 $R$ 的零行， 所以这一部分是 $A$ 的左零空间。