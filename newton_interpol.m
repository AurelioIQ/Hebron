format long
x =[430,463,494,500,530,550,600,650,700,750,];
y = [0.00000324,0.0000838,0.0012,0.00194,0.018,0.0696,1.38,17.4,153,1010];

    n=length(x);
    b=zeros(n);
    b(:,1)=y(:);
    %obtener la tabla de diferencias 
    for j=2:n
        for i=1:n-j+1
            b(i,j)=(b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
        end
    end
    %construir el polinomio
    p=num2str(b(1,1));
    xx=x.*-1;
    for j=2:n
        signo='';
        if b(1,j)>=0
            signo='+';
        end
        xt='';
        for i=1:j-1
            signo2='';
            if xx(i)>=0
                signo2='+';
            end
            xt=strcat(xt,'*(T',signo2,num2str(xx(i)),')');
        end
        p=strcat(p,signo,num2str(b(1,j)),xt);   
    end
    P=str2sym(p);
    syms T
    P=expand(P);
    newton_inpol=inline(P)
poli=sym2poly(P);
x1 = 400:50:800;
y1 = polyval(poli,x1);
figure
plot(x,y,'o')
hold on
plot(x1,y1,'b')
hold off