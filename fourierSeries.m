function [a0, an, bn, fs] = fourierSeries(f,flim,N)

%Here, I made t a symbolic variable
syms t

%Below, I calculated the total time period of the multi-legged function. I
%did flim(end)-flim(1) because in this flim(1) extracts the first value
%from the flim array and flim(end) extracts the last element from the flim
%aray. flim(end)-flim(1) calculates the period for the whole multi-legged
%function from the f array. Hence giving us the time period T. 
T = (flim(end) - flim(1));

%I just initialised fs and a0 to 0. These values will be updated as the
%calculations are done.
fs = 0;
a0 = 0;
%The for loop below runs from g = 1 until the length of the array f. If the
%array f contains 2 elements, the loop runs twice, for g = 1 and g = 2.
%Consider the formula for calculating the constant a0 in the Fourier Series
%equation. The formula is: a0 = 2/T * integral(f(t), [0, T]).
%a0_1 calulates the 'a0' part in the formula,
%The line after that adds a0_1/2 to a0 which is initially 0. this calulates
%the 'a0/2' part of the fourier series formula.
%This calculated each loop and added to the previous result for each
%expression in the f array. And once the loop ends, we will have the final
%value for a0/2 which is the offset of the Fourier Series.
for g=1:length(f)
    a0_1 = (2/T) * int(f(g), [flim(g), flim(g+1)]);
    a0 = eval(a0 + (a0_1/2));
end

%The calculated offset is added to the fs which was initially 0. So that
%the Fourier Series calculated in the next loop will have this offset. 
%The Fourier Series is stored in the variable fs.
fs = fs + a0; 

%The outer loop runs from n = 1 all the way till N. Where N specifies order of
%the Fourier series to be calculated. If N was 5, it will run 5 times and
%calucate the Fourier series till the 5th order. 

%%%%%%%% In the inner loop: %%%%%%%%
%an_n and b_n stores calculated values of the cosine and sine coefficients respectivley  
%in each iteration of the loop.
%an and bn are initially initialised to 0, each iteration of the loop, an_n
%and bn_n are added on to an and bn array to store the sine and cosine coeffiecients.
%The inner loop runs from k=1 to the length of the f array. And it
%calculates the sine and cosine coefficient for each function in the array
%And gets the resultant.
%Then it calculates the sine and cosine coeffieint for the order N, which
%is controlled by the outer loop

%%%%%%%% In the Outer loop: %%%%%%%%
%Once an and bn is calulated in the inner loop, the loop is exited and the
%It is used to calculate the Fourer Series. After this is calculated, n is
%incremented, and it reruns the whole process to calculate the coefficients
%of the next order for example, when n = 1, 2 etc, and does this until the
%Nth order of the Fourier Series is calculated.

%%%%%%%% Explanation of the Mathematics: %%%%%%%%
%The formula for calculating the cosine coefficient is:
%an = (2/T) * integral(f(t) * cos((2*pi*n*t)/(T)),[0 T])
%And the for sine it is:
%bn = (2/T) * integral(f(t) * sin((2*pi*n*t)/(T)),[0 T])

%In our context, we calculated the T at the beginning. Since we have a
%multi-legged function, we calculated the sine and cosine coefficients for
%each function by doing f(k) and taking the limits of integration for each
%function from the flim array. if f = [t+pi, pi-t] and
%flim=[-pi, 0, +pi], the limits for t+pi is -pi and 0. Hence we did flim(k)
%as the lower limit and flim(k+1) as the upper limit.
%After each calculation of the an_n and bn_n value, it is added together
%and put in the an and bn array.

%The formula for the Fourier Series is:
%fs = a0/2 +  an*cos((2*pi*n*t)/(T)) + bn*sin((2*pi*n*t)/(T))  
%a0/2 is already calculated and added on to fs in line 35 of the code hence
%the offset from the formula has already been applied. 
%an and bn for each order is calculated in the inner for loop. And using
%an and bn, the Fourier Series is calculated in each iteration of the outer
%for loop by adding each loop and is calculated until N. Hence finding the
%Nth order Fourier Series.
for n=1:N
    an(n) = 0;
    bn(n) = 0;
    for k=1:length(f)
        an_n(k) = (2/T) * int(f(k) * cos((2*pi*n*t)/(T)),[flim(k) , flim(k+1)]);
        bn_n(k) = (2/T) * int(f(k) * sin((2*pi*n*t)/(T)),[flim(k) , flim(k+1)]);
        an(n) = an(n) + an_n(k);
        bn(n) = bn(n) + bn_n(k); 
    end
    fs = fs +  an(n)*cos((2*pi*n*t)/(T)) + bn(n)*sin((2*pi*n*t)/(T));    
end

figure();
%Below, I plotted the final Fourier Series between flim(1) and flim(end)
%which is the time period of the Fourier Series. This plot will be blue in
%colour.
fplot(fs, [flim(1) flim(end)], 'b');
hold on;
grid on;
%The loop below runs from j = 1 till the length of the f array and plots
%each leg in the array. And each leg will be coloured red for consistency.

%f(j) extracts each function and the it is plotted betweem flim(j) and
%flim(j+1). For example, if f = [t+pi, pi-t] and  flim=[-pi, 0, +pi], t+pi
%is plotted between -pi and 0. And pi-t is plotted between 0 and +pi. So
%each function is plotted with its appropriate limits.
for j=1:length(f)
    fplot(f(j), [flim(j), flim(j + 1)], 'r');
end

