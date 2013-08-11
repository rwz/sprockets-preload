require 'helpers/boot'

describe "Direct dependency" do
  before(:all) do
    Sprockets::Preload.precompiles += ["forced/forced.js"]
  end

  after(:all) do
    Sprockets::Preload.precompiles -= ["forced/forced.js"]
  end

  it "serves detouched" do
    Sprockets::Preload.environment['sprockets/preload/assets'].source.should == "test1\n;\ntest2\n;\n\n"
  end

  context "inlined", inline: true do
    it "keeps inlines" do
      Sprockets::Preload.environment['forced/forced'].source.should_not include("test1", "test2")
      Sprockets::Preload.environment['forced/forced'].source.should_not include("SprocketsPreload.inline = true")
    end
  end

  context "detouched", inline: false do
    it "keeps inlines" do
      Sprockets::Preload.environment['forced/forced'].source.should_not include("test1", "test2")
      Sprockets::Preload.environment['forced/forced'].source.should_not include("SprocketsPreload.inline = true")
    end
  end
end