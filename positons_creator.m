clc;clear;
a = -84; b = 79;
c = -87;d=80;
e=36;f=67;


i=1;j=1;k=1;
while true
    
    xrand(i) = a + (b-a)*rand(1);
    yrand(j) = c + (d-c)*rand(1);
    zrand(k) = e + (f-e)*rand(1);
% xrand = 50;
% yrand = 60;
    if (xrand(i)<-32 | xrand(i)>31) | (yrand(j)<-31 | yrand(j)>31)

       disp(yrand)
        
%     else
        if i > 1
            distx = abs(xrand(i)-xrand(1:i-1));
            if distx < 14
                i = i-1;
            else
                i = i + 1;
            end
        end
        
        
        
        
        if j > 1
            disty = abs(yrand(j)-yrand(1:j-1));
            if disty < 20
                j = j-1;
            else
                j = j + 1;
            end
        end
    
    
    
    %     if zrand<36 | zrand>67
    
    if k > 1
        distz = abs(zrand(k)-zrand(1:k-1));
        if distz < 12
            k = k-1;
        else
            k = k + 1;
        end
    end
    %     end
    
    
    if i == 1
        i = i +1;
    end
    
    if j == 1
        j = j + 1;
    end
    
    if k == 1
        k = k + 1;
    end
    end 

if i>100
    break
end


end
xlswrite('x.dat',xrand');xlswrite('y.dat',yrand')
xlswrite('z.dat',zrand');