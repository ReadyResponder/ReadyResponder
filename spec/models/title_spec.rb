describe "Title" do
  before(:each) do
  end

  describe "creation" do
    it "requires a name" do
      sampletitle = build(:title, name: nil)
      expect(sampletitle).not_to be_valid
    end
  end
end