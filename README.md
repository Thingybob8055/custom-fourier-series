# Custom Fourier Series Function

Although MATLAB as a built-in Fourier Series function, it has a few disadvantages such it only computes for a single legged function and only goes till the order of 8.

The custom function made here can go to any order n based on user input, and can plot both single and multi-legged function. There are one small consideration that, all function inputs must be given as an array input, both for single legged and multi-legged functions.

The code plots both the Fourier Series and the input function to a figure for comparison. Larger the Fourier Series order, the longer the computation.