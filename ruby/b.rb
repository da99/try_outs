
describe "a: " do
  before { puts "--- before ---"}
  describe do
    it "a" do
      1.should == 1
    end
    it "b" do
      2.should == 2
    end
  end
end
