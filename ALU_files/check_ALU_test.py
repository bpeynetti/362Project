def twos_comp(val, bits):
    # """compute the 2's compliment of int value val"""
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)        # compute negative value
    return val                         # return positive value as is

    
    
ctrlDict = {}


ctrlDict[0] = 'add'
ctrlDict[1] = 'sub'
ctrlDict[2] = 'slt'
ctrlDict[3] = 'sle'
ctrlDict[4] = 'sgt'
ctrlDict[5] = 'sge'
ctrlDict[6] = 'and'
ctrlDict[7] = 'sra'
ctrlDict[8] = 'and'
ctrlDict[9] = 'sll'
ctrlDict[10] = 'srl'
ctrlDict[11] = 'seq'
ctrlDict[12] = 'sne'
ctrlDict[13] = 'and'
ctrlDict[14] = 'or'
ctrlDict[15] = 'xor'

  
def function(A,B,fn,out,zero,of):
    
    #shamt = can only shift by 5 bits
    #convert to hex
    #then convert to 
    # out = twos_comp(int(hex_string,16), 32)
    
    Astring = A
    Bstring = B
    
    Bbin = bin(int(B,16))[2:]
    Bbin = '0'*(32-len(Bbin)) + Bbin
    shamt = Bbin[27:]
    shamt = int(shamt,2)
    # print "shamt is ",shamt
    
    Abin = bin(int(A,16))[2:]
    Abin = '0'*(32-len(Abin)) + Abin
    # print Abin
    A = twos_comp(int(A,16),32)
    if (A<0):
        Abinary = bin(~(-A)+0x10000000)[2:]
        # print A
        # print Abinary
    B = twos_comp(int(B,16),32)
    outInt = twos_comp(int(out,16),32)
    ctrl = int(fn,2)
    # print A,B,ctrl
    
    fn = ctrlDict[ctrl]
    ofFlag = 0
    if (fn=='add'):
        result = A+B
        if (result<(-pow(2,31))):
            ofFlag=1
            # print "ERROR\n\n\n"
            # return True
    if (fn=='sub'):
        result =  A-B
        
        if (result<(-pow(2,31))):
            ofFlag=1
            # print "ERROR\n\n\n"
            # return True
        
        
        
        # print result
        # if (result<0):
        #     length = len(bin(result)[3:])
        #     # print len(bin(result)[3:])
        #     # print bin(result)
        # else:
        #     # print len(bin(result)[2:])
        #     # print bin(result)
    if (fn=='sll'):
        # take the bits from shamt to the end
        # and append zeros before that
        sllString = Abin[shamt:]+'0'*shamt
        result =  twos_comp(int(sllString,2),32)
        # print result
    if (fn == 'and'):
        result =  A&B
    if (fn == 'or'):
        result =  A|B
    if (fn == 'xor'):
        result =  A^B
    if (fn == 'seq'):
        result =  A==B
    if (fn=='sne'):
        result = not(A==B)
    if (fn == 'sle'):
        result =  A<=B
    if (fn =='slt'):
        result = A<B
    if (fn =='sgt'):
        result = A>B
    if (fn =='sge'):
        result = A>=B
    if (fn == 'srl'):
        srlString = '0'*shamt+Abin[:-shamt]
        # print "SLL:",srlString
        result =  twos_comp(int(srlString,2),32)
    if (fn == 'sra'):
        result = A >> shamt
    
    # print "result is ",result
    resultInt = result
    # print hex(resultInt)
    if (resultInt<0):
        result = hex(~(-1*resultInt) + 0x00000001)[3:]
    else:
        result = hex(result)[2:]
        
    # print bin(int(result,16))
    zeroflag = result==0
    #now make it into a 32-bit result
    # result = hex(result)[2:]
    result = '0'*(8-len(result))+result
    
    print fn,A,B,'(',shamt,')',#resultInt,#hex(resultInt),
    # print "Fn: ",fn," result: ",resultInt,




    if ((A>0 and B>0)and (fn=='add'))or((A>0 and B<0) and (fn=='sub')):
        # print "\n\nTTT"
        if (hex(resultInt)[2:]==out):
            print "ALL OK"
            return True
    # print "hi"
    # print "HI HI"
    # print fn,ofFlag,resultInt
    if (fn=='add' or fn=='sub') and (ofFlag==1) and resultInt<0:
        # print "testing"
        if (zeroflag)==(zero=='1'):
            if (twos_comp(int('f'+out,16),36)==resultInt):
                # print "ALL OK"
                return True
            else:
                print "Zero ok, Result wrong"
                return False
        else:
            if ('1'+out==resultBin):
                print "Zero BAD, Result ok"
                return False
    
    if (resultInt==outInt):
        if (zeroflag)==(zero=='1'):
            print "ALL OK"
            return True
        else:
            print "Result ok, Flag wrong"
            return False
    else:
        if (zeroflag)==(zero=='1'):
            print "Result bad, Zero right"
            return False
        else:
            print "Result bad, zero bad"
            return False
        return False
    return False
    
    

fileRead = open('alu_result2.txt','r')

lines = []
i=0
right=0
for line in fileRead:
    i=i+1
    newLine = line.split(',')
    
    print newLine,'\t\t',
    r = function(newLine[0],newLine[1],newLine[2],newLine[3],newLine[4],newLine[5])
    if (r==True):
        right=right+1

print "\n\n -- TOTAL: ",i
print " -- Correct: ",right
print " -- % right: ",100*right/i,"%"