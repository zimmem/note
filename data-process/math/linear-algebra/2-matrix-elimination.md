# 矩阵消元(Matrix Elimination)

求解下列方程组
$$
\begin{aligned}x+2y+z&=2 \\3x+8y+z&=12 \\4y+z&=2   \end{aligned}
$$

矩阵$A$ 如下：
$$
\begin{bmatrix}1& 2& 1 \\3& 8& 1\\0& 4& 1\end{bmatrix}
$$

## 消元法
!!! INFO
    * 所有计算机都用这种方法求解
    * 只是方程组的矩阵$A$是一个好矩阵，就能通地消元法求解方程组

1. 消元
   
    !!! NOTE ""
        这里用矩阵简写方程组

    $$
    \begin{bmatrix} \boxed{1}& 2& 1 \\ 3&8&1\\ 0& 4&1\\ \end{bmatrix} \stackrel{(2,1)}{\longrightarrow}
    \begin{bmatrix}\boxed{1}& 2& 1\\0& \boxed{2}& -2\\0& 4& 1\\\end{bmatrix}
    \stackrel{(3,2)}{\longrightarrow}
    \begin{bmatrix}\boxed{1}& 2& 1 \\0&\boxed{2}& -2\\0& 0& \boxed{5}\\\end{bmatrix}
    $$

    1. 先给矩阵左上解的 $1$标上方框， 把它称为主元一(1st pivot)，第一行保持不变， 现在用第二个方程减去第一个方程*3& 消去(2,1)， 得到一个新的矩阵
    2. 接下来要消去(3,1 )， 但这里已经是 0  了， 所以接下来直接消除 (3,2)位置
    3. 消元后的矩阵称为 $U$， 并得到三个主元（主元不能为0）

    !!! TIP 消元失败的情况
        * 如果(1,1)是 0 怎么办？ 先进行行与行之间交换就行。
        * 如果(2,2)变为6， 同样跟下面交换， 只要这行下同列有非0就行
        * 如果(3,3) 改为 -4， 则方程组无解， 没法继续进行行交换。
  
2. 回代 (back substitution)  
在矩阵中加入方程组右侧向量， 得到新的矩阵， 称为增广矩阵

$$
\left [ \begin{array}{ccc|c}\boxed{1}& 2& 1&2\\3&8&1& 12\\0& 4&1& 2\\\end{array} \right]  
\stackrel{(2,1)}{\longrightarrow}
\left [ \begin{array}{ccc|c}\boxed{1}& 2& 1 & 2\\0& \boxed{2}& -2& 6\\0& 4&1&2\\\end{array} \right]  
\stackrel{(3,2)}{\longrightarrow}
\left [ \begin{array}{ccc|c}\boxed{1}& 2& 1& 2 \\0&\boxed{2}& -2& 6\\0& 0& \boxed{5}& -10\end{array} \right]  
$$

把增广这一列的最终结果称为$c$， $c$ 是 $b$ 的最终结果 ， 就像 $U$ 对于 $A$ 一样

把矩阵转换回方程组：

$$
\begin{aligned}
x+2y+z=&2\\
2y-2z=&6 \\
5z=&-10
\end{aligned}

$$

很容易得出方程的解为 $x = 2, y=1, z=-2$

## 矩阵消元


!!! NOTE 回顾列图像（线性组合）

    $$
    \begin{bmatrix}-& -&- \\-& -&- \\-& -&-\end{bmatrix}
    \begin{bmatrix}3 \\4 \\5\end{bmatrix}
     =
    \begin{array}{c}{3 \times col_1} \\ {+} \\ {4 \times col_2} \\{+} \\ {5 \times col_3}\end{array}
    $$
    矩阵乘以向量理解为矩阵列的线性组合

!!! INFO 引入行转换
    $$
    \begin{bmatrix}1&2&7\end{bmatrix}
    \begin{bmatrix}-& -&- \\-& -&- \\-& -&- \end{bmatrix}
    =
    \begin{array}{c}{1 \times row_1} \\ {+} \\ {2 \times row_2} \\{+} \\ {7 \times row_3}\end{array}
    $$

!!! NOTE 单位矩阵$I$
    单位矩阵乘以任意矩阵都不改变该矩阵 $IA=A$
    $$
    \begin{bmatrix}1&0&0 \\0&1&0 \\0&0&1 \end{bmatrix}
    $$

1. 找出一个矩阵乘以$A$， 可以消去 $(2,1)$ 位置， 如下公式， 我们把这个矩阵称为初等矩阵（Elementary Matrix）, 记为 $E_{21}$  。 
    $$
    \underset{E_{21}}{\begin{bmatrix}1& 0& 0 \\-3&1&0\\0& 0&1\end{bmatrix}}
    \begin{bmatrix}1& 2& 1 \\3&8&1\\0& 4&1\end{bmatrix}
    =
    \begin{bmatrix}1& 2& 1\\0& 2& 2\\0& 4& 1\\\end{bmatrix}
    $$
2. 再找出一个矩阵乘以第1步的结果， 消去 $(3,2)$ , 如下公式， 我们把这个矩阵称为初等矩阵 $E_{32}$， 最终等到消元结果
    $$
    \underset{E_{(3,2)}}{\begin{bmatrix}1& 0& 0 \\0&1&0\\0& -2&1\end{bmatrix}}
    \begin{bmatrix}1& 2& 1\\0& 2& 2\\0& 4& 1\\\end{bmatrix}
    =
    \begin{bmatrix}1& 2& 1 \\0&2& -2\\0& 0& 5\\\end{bmatrix}
    $$

3. 那么有没有一个矩阵直接乘以$A$能得到$U$呢？看下面公式
   
   !!! NOTE ""
       矩阵乘法满足结合律， 在乘式中任意加括号
    $$
    E_{32}(E_{21}A)=U \\
    (E_{32}E_{21})A=U \\
    EA=U
    $$

## 矩阵的逆

$E^{-1}$ 称为矩阵$E$的逆

$$
E^{-1}E=I
$$

## 行列互换

使用置换矩阵(Permutation)实现行列转换

1. 行互换
    $$
    \begin{bmatrix}0 & 1 \\1 & 0 \end{bmatrix}
    \begin{bmatrix}a & b \\c & d \end{bmatrix}
    =
    \begin{bmatrix}c & d \\a & b \end{bmatrix}
    $$
2. 列互换
   $$
    \begin{bmatrix}a & b \\c & d \end{bmatrix}
    \begin{bmatrix}0 & 1 \\1 & 0 \end{bmatrix}
    =
    \begin{bmatrix}b & a \\d & c \end{bmatrix}
   $$

!!! TIP
    矩阵乘法满足结合律， 但不满足交换律

[^1]:http://open.163.com/movie/2010/11/P/P/M6V0BQC4M_M6V29EGPP.html
