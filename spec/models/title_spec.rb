describe "Title" do
  before(:each) do
  end

  describe "creation" do
    it "requires a name" do
      sampletitle = FactoryGirl.create(:title)
      sampletitle.name = ""
      pending "Awaiting further enlightenment" do
	expect {sampletitle.save}.to raise_error()
      end
    end
  end
end