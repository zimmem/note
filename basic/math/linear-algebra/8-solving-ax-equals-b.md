# 求解 Ax=b, 可解性和解的结构

!!! TIP ""
    $Ax=0$ 国内往往称为“齐次方程组”， 称为 $Ax=b$ 的“导出组”

对于方程：
$$
\begin{aligned}
x_1+2x_2+2x_3+2x_4&=b_1 \\
2x_1+4x_2+6x_3+8x_4&=b_2\\
3x_1+6x_2+8x_3+10x_4&=b_3    
\end{aligned}
$$

观察以上方程组， 等号左侧行3等于行1+行2， 所以满足 $b_3=b_1+b_2$ ， 该方程组才有解。  
用矩阵表示
$$
\left[ \begin{array}{cccc|c}
1 &2 &2 &2 &b_1 \\ 2 &4 &6 &8 &b_2 \\ 3 &6 &8 &10 &b_3 \\ 
\end{array} \right]
\stackrel{消元}{\rightarrow}
\left[ \begin{array}{cccc|c}
1 &2 &2 &2 &b_1 \\ 0 &0 &2 &4 &b_2-2b_1 \\ 0 &0 &0 &0 &b_3-b_2-b_1 \\ 
\end{array} \right]
$$ 
所以 $b_3-b_2-b_1=0$, 当取 $b=\begin{bmatrix}1\\5\\6\end{bmatrix}$ 时， 消元矩阵为$\left[ \begin{array}{cccc|c}
1 &2 &2 &2 &1 \\ 0 &0 &2 &4 &3 \\ 0 &0 &0 &0 &0 \\ 
\end{array} \right]$

所以对于上述方程组 $Ax=b$ 有解， 当且仅当 $b$ 在矩阵 $A$ 构成的子空间 $C(A)$ 中。  
如果 $A$ 各行的纯属组合得到零行， $b$ 端分量的同样组合必然也是零。

## 求  Ax=b 的所有解

1. 求一个特解$x_{particular}$ , 如上述方程组对于$b=\begin{bmatrix}1\\5\\6\end{bmatrix}$， 先把所有自由变量取 0， 再求 $Ax=b$ 的主变量， 则方程组变为 
   $$
   x_1+2x_3=1 \\
   2x_3=3
   $$
   可解出 $x_1=-2, x_3=3/2$, 则特解为$x_{particular}=\begin{bmatrix}-2\\0\\3/2\\0\end{bmatrix}$ 。
2. 求 $x_{nullspace}$,上述方程的零空间为$x_{nullspace}=c_1\begin{bmatrix}-2\\1\\0\\0\end{bmatrix}+c_2\begin{bmatrix}2\\0\\-2\\1\end{bmatrix}$.
3. 方程的所有解为$x = x_p + x_n$
   $$
   x_{complete}=\begin{bmatrix}-2\\0\\3/2\\0\end{bmatrix} + c_1\begin{bmatrix}-2\\1\\0\\0\end{bmatrix}+c_2\begin{bmatrix}2\\0\\-2\\1\end{bmatrix}
   $$

证明$x = x_p + x_n$：
$$
Ax_p=b \\
Ax_n=0 \\
A(x_p+x_n)=b
$$

## Ax=b 的可解性

对于秩为 r  的 $m \times n$ 矩阵

### 列满秩 
r=n (没有自由变量)， $N(A)=\begin{bmatrix} 0 \\ \vdots \\ 0\end{bmatrix}$. 
$Ax=b$ 如果有解， 只有唯一解。 $x=x_p$.  如：
$$
A=\begin{bmatrix}1& 3 \\2& 1 \\6& 1 \\5& 1 \end{bmatrix}
\Rightarrow
R=\begin{bmatrix}1& 0 \\0& 1 \\0& 0 \\0& 0 \end{bmatrix}
$$

### 行满秩
$r=m$, 对任意 $b$ , $Ax=b$ 都有解, 自由变量个数为 $n-r$
$$
A=\begin{bmatrix}1& 2 &6& 5 \\3& 1 &1& 1 \end{bmatrix}
\Rightarrow
R=\begin{bmatrix}1& 0 &F &F \\0& 1 & F & F \end{bmatrix}
$$
$F$ 构成零空间特解。

### 满秩
$r=m=n$, $A$ 为可逆矩阵， 如
$$
A=\begin{bmatrix}1& 2 \\3& 1\end{bmatrix}
\Rightarrow
R=\begin{bmatrix}1& 0 \\0& 1 \end{bmatrix}
$$
满秩情况下， 对于任意b都有解， 且是唯一解。

### 总结 
1. $r=m=n$ ， $R = I$ , 有解且是唯一解
2. $r=n<m$,  $R=\begin{bmatrix}I\\0\end{bmatrix}$, 没有解或唯一解
3. $r=m<n$, $R=\begin{bmatrix}I&0\end{bmatrix}$, 无数解
4. $r<m, r<n$, $R=\begin{bmatrix}I&F\\0&0\end{bmatrix}$, 没有解或无数解