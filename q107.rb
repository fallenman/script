
c=File.readlines('network.txt')

@d=c.map{|x| x.chomp!.gsub("-","-1").split(",").map{|y| y.to_i}}
sum=@d.flatten.reject{|x|x==-1}.inject(0){|a,b|a+=b}
@max=0
@res=0
@list=[]
def test_connection(network)
  index=[0]
  new_index=[0]
  while new_index!=[] && index.length < 40 do
    tmp_index=[]
    new_index.each do |n|
      network[n].each_with_index do |m,i|
        if m != -1 && !index.include?(i)
          index<<i
          tmp_index|=[i]
        end
      end
    end
    new_index=tmp_index
  end
  index.length == 40 ? true : false
end


while @d.flatten.reject{|x|x==-1}.length!=@d.length do
  @max=@d.map{|x|x if x.reject{|y|y==-1}.length>1}.reject{|x|x.nil?}.flatten.reject{|x|@list.include?(x)}.max
  if @max == -1
    p @res
    exit
  end
  tmp=@d.select{|x| x.grep(@max) != []}
  test=0
  tmp.each do |t|
    if t.reject{|x|x==-1}.length > 1 && @d[t.index(@max)].reject{|x|x==-1}.length > 1
      index0=@d.index(t)
      index1=t.index(@max)
      t[index1]=-1
      @d[index1][index0]=-1
      if test_connection(@d)
        @res+=@max
        test=1
        break
      else
        t[index1]=@max
        @d[index1][index0]=@max
      end
    end
  end
  @list|=[@max] if test==0
end
