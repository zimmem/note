# 矩阵乘法与逆

## 矩阵乘法

$A_{m \times n}B_{n \times p}=C_{m \times p}$ 。

1. 常规解法

    $$
    c_{34} = a_{31}b_{14}+a_{32}b_{24}+\dotsb+a_{3n}b_{n4} = \sum_{k=1}^n a_{3k}b_{k4}
    $$
2. 矩阵乘以列  
    $$
    C_{col_k}=A \times B_{col_k}
    $$

3. 行乘以矩阵
   $$
   C_{row_k} = A_{row_k} \times B
   $$
4. 列乘以行
   $$
   AB = SUM( column of A \times row of B_)
   $$
   例：
   $$
   \begin{bmatrix}2& 7 \\ 3& 8 \\ 4& 9 \\\end{bmatrix}
   \begin{bmatrix}1& 6 \\ 1& 1 \end{bmatrix}
   =
   \begin{bmatrix}2 \\ 3\\ 4\end{bmatrix}
   \begin{bmatrix}1& 6 \end{bmatrix}
   +
   \begin{bmatrix}7 \\ 8\\ 9\end{bmatrix}
   \begin{bmatrix}1& 1 \end{bmatrix}
   $$
   !!! TIP 行列空间
       $$
        \begin{bmatrix}2 \\ 3\\ 4\end{bmatrix}
        \begin{bmatrix}1& 6 \end{bmatrix}
        =\begin{bmatrix}2& 12 \\ 3 & 18 \\ 4 &24\end{bmatrix}
       $$
       列乘以行到的是一个特殊矩阵， 每一行向量的方向相同， 每一列向量的方向也相同。向量 $[2, 3, 4]^{-1}$ 所在直线是该矩阵的列空间， 向量 $[1,6]$ 所在直线是矩阵的行空间
5. 块
   $$
   \underset{A}{\left [\begin{array} {c|c}A_1&A_2 \\ \hline A_3 & A_4 \\\end{array}\right ] }
   \underset{B}{\left [\begin{array} {c|c}B_1&B_2 \\ \hline B_3 & B_4 \\\end{array}\right ]}
    =
    \underset{C}{\left [\begin{array} {c|c}C_1&C_2 \\ \hline C_3 & C_4 \end{array}\right ]}
   $$
   有
   $$
   C_1 = A_1B_1 + A_2B_3
   $$


## 矩阵的逆

如果存在矩阵 $A^{-1}$ 使得 $A^{-1} A=I$, 则称 $A^{-1}$为矩阵A的逆， 且满足 
$$
A^{-1} A=I = A  A^{-1}
$$

!!! INFO 不可逆矩阵/奇异矩阵
    什么样的矩阵不可逆？
    $$
    \begin{bmatrix}    1& 3 \\2& 6 \\\end{bmatrix}
    $$
    就是一个不可逆矩阵， 观察该矩阵， 可以发现每一列与每二列在同一个列空间， 而该矩阵乘以任何一个矩阵得到的结果矩阵都该矩阵各列的线性组合， 不可以出现$I$. 所以该矩阵不可逆。  
    或者归纳为： **如果存在非0矩阵$X$ 使得$AX=0$， 则 $A$ 不可逆**  
    证明：如果存在逆矩阵 $A^{-1}$， 则 $A^{-1}AX=IX=0$, 这与 $X$ 为非0矩阵矛盾。

### 求逆矩阵

$$
\begin{bmatrix}1& 3 \\ 2 &7\end{bmatrix}
\begin{bmatrix}a& c \\ b &d\end{bmatrix}
=
\begin{bmatrix}1& 0 \\ 0 &1\end{bmatrix}
$$

#### 解法一：
上式分解为
$$
\begin{bmatrix}1& 3 \\ 2 &7\end{bmatrix}
\begin{bmatrix}a \\ b\end{bmatrix}
=
\begin{bmatrix}1 \\ 0 \end{bmatrix} \\
与 \\
\begin{bmatrix}1& 3 \\ 2 &7\end{bmatrix}
\begin{bmatrix}c \\ d\end{bmatrix}
=
\begin{bmatrix}0 \\ 1 \end{bmatrix} \\
$$
接下来分别求解方程组就OK了， 上面分解可归纳为： 矩阵 $A$ 乘以 逆矩阵 $A^{-1}$ 的第 j 列 得到单位矩阵 $I$ 的第 j 列

#### 解法二：

把矩阵A与单位矩阵 I 拼在一起变成增广矩阵, 并对增广矩阵中的A进行消元直到变成单位矩阵， 则最终增广矩阵右侧矩阵为逆矩阵。
$$
\left[\begin{array} {cc|cc}1&3&1&0 \\ 2&7&0&1 \end{array}\right]
\rightarrow
\left[\begin{array} {cc|cc}1&3&1&0 \\ 0&1&-2&1 \end{array}\right]
\rightarrow
\left[\begin{array} {cc|cc}1&0&7&-3 \\ 0&1&-2&1 \end{array}\right]
$$

如上， 最终矩阵$\begin{bmatrix}7 & -3 \\ -2 & 1\end{bmatrix}$ 就是A的逆 。

证明：
消元过程其实是乘上一个消元矩阵$E$， 所以有
$$
E[A|I] = [EA|EI] = [I|E]
$$
因为$EA=I$, 所以E是A的逆