require 'spec_helper'

describe "Inspections" do
  describe "GET /inspections" do
    pending "shows a listing of past inspections" do
      get inspections_path
      response.status.should be(200)
    end
  end
end
