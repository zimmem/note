# A 的 LU 分解
## 预备知识
1. **矩阵乘积的逆。**  
   对于矩阵$A,B$ 已知它们存在逆 $A^{-1}, B^{-1}$。那么有 $AB$ 对应的逆为 $B^{-1}A^{-1}$, 即：
    $$
    ABB^{-1}A^{-1}=I
    $$
2. **转置矩阵的逆**  
   对于矩阵$A$的转置矩阵 $A^T$, 有($A^{-1})^TA^T=I$, 即$A$的逆的转置就是$A$的转置的逆

## 2 阶矩阵 LU 分解
回顾矩阵消元如下
$$
\stackrel{E_{21}}{\begin{bmatrix}1& 0 \\ -4&1\end{bmatrix}}
\stackrel{A}{\begin{bmatrix}2& 1 \\ 8&7\end{bmatrix}}
=
\stackrel{U}{\begin{bmatrix}2& 1 \\ 0&3\end{bmatrix}}
$$
那么有：
$$
\stackrel{A}{\begin{bmatrix}2& 1 \\ 8&7\end{bmatrix}}
=
\stackrel{E_{21}^{-1}=L}{\begin{bmatrix}1&0\\-4&1\end{bmatrix}}
\stackrel{U}{\begin{bmatrix}2& 1 \\ 0&3\end{bmatrix}}
$$

消元矩阵$E$的逆$E^{-1}$就是$L$

!!! TIP ""
    $U$ 表示上三角， $L$ 表示下三角， $LU$ 分解即把$A$分解为一个上三角矩阵乘以下三解矩阵， $U$ 也是消元的结果。或者写成如下形式更明确。
    $$
    \stackrel{A}{\begin{bmatrix}2& 1 \\ 8&7\end{bmatrix}}
    =
    \stackrel{L}{\begin{bmatrix}1&0\\-4&1\end{bmatrix}}
    \stackrel{D}{\begin{bmatrix}2& 0 \\ 0&3\end{bmatrix}}
    \stackrel{U}{\begin{bmatrix}1& 0.5 \\ 0&1\end{bmatrix}}
    $$

## 3 阶矩阵消元

对于3阶矩阵， 有：
$$
E_{32}E_{31}E_{21}A=U \\
\begin{aligned}
A&= E^{-1}_{21}E^{-1}_{31}E^{-1}_{32}U \\
&=LU
\end{aligned}
$$

比如
$$
\stackrel{E_{32}}{\begin{bmatrix}1&0&0\\0&1&0\\0&-5&1\\\end{bmatrix}}
\stackrel{E_{21}}{\begin{bmatrix}1&0&0\\-2&1&0\\0&0&1\\\end{bmatrix}}
=
\stackrel{E_{21}}{\begin{bmatrix}1&0&0\\-2&1&0\\10&-5&1\\\end{bmatrix}}
$$
!!! TIP ""
    $E_{ij}$ 的右上角者是0, 对角都是1， 结果$E$类似

再看对应的$L$ 
$$
\stackrel{E_{21}^{-1}}{\begin{bmatrix}1&0&0\\2&1&0\\0&0&1\\\end{bmatrix}}
\stackrel{E_{32}}{\begin{bmatrix}1&0&0\\0&1&0\\0&5&1\\\end{bmatrix}}
=
\stackrel{L}{\begin{bmatrix}1&0&0\\2&1&0\\0&5&1\\\end{bmatrix}}
$$

### n 阶方阵消元的操作数

在没有行置换的情况下， 对于 $n\times n$ 需要多少操作来消元？
$$
n^2+(n-1)^2+(n-2)^2+\dotsb + 3^2+2^2+1^2=\frac{n^3}{3}
$$
!!! TIP ""
    以上等式推导需要用到微积分

消元 $AX=b$ 等式右边的 $b$ 操作数是 $n^2$

如果需要行置换(Permutation), 先把 $3\times 3 $矩阵的所有行置换矩阵列出来， 有
$$
\begin{bmatrix}1&0&0 \\0&1&0 \\0&0&1 \\\end{bmatrix} 
\begin{bmatrix}0&1&0 \\1&0&0 \\0&0&1 \\\end{bmatrix} 
\begin{bmatrix}0&0&1 \\0&1&0 \\1&0&0  \\\end{bmatrix} \\ \  \\
\begin{bmatrix}1&0&0 \\0&0&1 \\0&1&0 \\\end{bmatrix} 
\begin{bmatrix}0&1&0 \\0&0&1 \\1&0&0 \\\end{bmatrix} 
\begin{bmatrix}0&0&1 \\1&0&0 \\0&1&0 \\\end{bmatrix} 
$$

任务两个行转换矩阵相乘的结果仍在这六个矩阵中。