describe "Title" do
  before(:each) do
  end

  describe "creation" do
    it "requires a name" do
      sampletitle = FactoryGirl.build(:title, name: nil)
      sampletitle.should_not be_valid
    end
  end
end