
def hello
  puts :hello
end

public def ^
  puts :hello
end

public def ~
  puts :hello
end


self.instance_eval {
  hello
  ~()
  self.^()
}
