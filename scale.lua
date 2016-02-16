-- scale.lua -- 

-- Set Load init
print("Scale Info:")

scale_sck=2
scale_dt=3
offsetAod=0
weight=0
isTare=0

hx711.init(scale_sck,scale_dt)

print("SCK Set : ",string.format("D%s",scale_sck))
print("DT Set : ",string.format("D%s",scale_dt))

 -- Count Average Real Weight
function getAverageWeight()
    nowAodValue=0
    for i=1,10,1 do
        nowAodValue=nowAodValue+hx711.read(0)
    end
    nowAodValue=nowAodValue/10
    weight=(nowAodValue-offsetAod) * coefficient
    print("Weight : ",weight)
    return weight
end

 -- Count Real Weight
function getWeight()
    nowAodValue=0
    nowAodValue=hx711.read(0)
    weight=(nowAodValue-offsetAod) * coefficient
    print("Weight : ",weight)
    return weight
end

--歸零
function tare(t)
    isTare=1
    print("tare begin...")
    sum=0
    for i=1,t,1 do
        sum=sum+hx711.read(0)
    end
    offsetAod=sum/10
    isTare=0
    print("tare end")
end

tare(10)
print("offsetAodValue : ",offsetAod)
coefficient =0.0026383214838523
print("coefficient : ",coefficient,'\n')
