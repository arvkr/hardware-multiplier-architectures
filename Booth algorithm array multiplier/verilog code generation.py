#Generate main module text for 16-bit booth array multiplier
for m in range(15):
    i = m + 2
    j=16-i
    k= 15 + i
    l=i-1
    print("ctrl c" + str(i) + "(.md(mdr" +str(i)+"),.cin(cr" + str(i)+"),.a(a),.xi({b[" + str(j) + "],b[" + str(j-1) + "]}));")
    print("cass_" + str(k) + "bit c"+str(k)+"b1(.pout(poutr" +str(i)+"),.a(mdr" +str(i)+"),.pin(poutr" +str(l)+"),.cin(cr" +str(i)+"));\n")

#4-bit booth array multiplier
for o in range(4):
i = o + 4
print('module cass_'+str(i)+'bit(pout,a,pin,cin);')
print('\toutput ['+str(i-1)+':0] pout;')
print('\tinput [3:0] a;')
print('\tinput ['+str(i-2)+':0] pin;')
print('\tinput cin;')
print('\twire c1,c2,c3,',end='')
for j in range(i-4):
    k=j+4
    print('c'+str(k)+',',end='')
print('\b;')
print("\tcass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1""'""b0),.cin(cin));")
for l in range(i-2):
    m=l+2
    if m-1>3:
        n=3
    else:
        n=m-1
    print('\tcass ca'+str(m)+'(.pout(pout['+str(m-1)+']),.cout(c'+str(m)+'),.a(a['+str(n)+']),.pin(pin['+str(m-2)+']),.cin(c'+str(m-1)+'));')
m=i
if m-1>3:
    n=3
else:
    n=m-1
print('\tcass ca'+str(m)+'(.pout(pout['+str(m-1)+']),.cout(x),.a(a['+str(n)+']),.pin(pin['+str(m-2)+']),.cin(c'+str(m-1)+'));')
# 	cass ca2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
# 	cass ca3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
# 	cass ca4(.pout(pout[3]),.cout(c4),.a(a[3]),.pin(pin[2]),.cin(c3));
# 	cass ca5(.pout(pout[4]),.cout(c5),.a(a[3]),.pin(pin[3]),.cin(c4));
# 	cass ca6(.pout(pout[5]),.cout(c6),.a(a[3]),.pin(pin[4]),.cin(c5));
# 	cass ca7(.pout(pout[6]),.cout(x),.a(a[3]),.pin(pin[5]),.cin(c6));
print('endmodule\n\n')



#16-bit booth array multiplier
for o in range(16):
i = o + 16
print('module cass_'+str(i)+'bit(pout,a,pin,cin);')
print('\toutput ['+str(i-1)+':0] pout;')
print('\tinput [15:0] a;')
print('\tinput ['+str(i-2)+':0] pin;')
print('\tinput cin;')
print('\twire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,',end='')
for j in range(i-16):
    k=j+16
    print('c'+str(k)+',',end='')
print('\b;')
print("\tcass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1""'""b0),.cin(cin));")
for l in range(i-2):
    m=l+2
    if m-1>15:
        n=15
    else:
        n=m-1
    print('\tcass ca'+str(m)+'(.pout(pout['+str(m-1)+']),.cout(c'+str(m)+'),.a(a['+str(n)+']),.pin(pin['+str(m-2)+']),.cin(c'+str(m-1)+'));')
m=i
if m-1>15:
    n=15
else:
    n=m-1
print('\tcass ca'+str(m)+'(.pout(pout['+str(m-1)+']),.cout(x),.a(a['+str(n)+']),.pin(pin['+str(m-2)+']),.cin(c'+str(m-1)+'));')
print('endmodule\n\n')