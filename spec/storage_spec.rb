require 'spec_helper'

describe Hoarder::Storage, "#initialize" do
  let(:config) { {:provider => 'rackspace', :rackspace_username => 'testguy', :rackspace_api_key => 'iamakey'} }
  let(:connection) { mock(Fog::Storage) }

  before {
    Fog::Storage.stub(:new).and_return(connection)
  }

  context "when config file is missing" do
    before {
      FileTest.stub(:exist?).and_return(false)
    }
    specify {
      lambda { Hoarder::Storage.new('') }.should raise_error(RuntimeError, "Missing config file /hoarder.yml.")
    }
  end

  context "when config file is not missing" do
    before {
      FileTest.stub(:exist?).and_return(true)
      File.stub(:open).and_return('')
    }

    context "and opening file causes exception" do
      specify {
        lambda { Hoarder::Storage.new('') }.should raise_error(RuntimeError, "Unable to load config file /hoarder.yml.")
      }
    end

    context "and opening file does not cause an exception" do

      context "and config file is empty" do
        before {
          YAML.stub(:load).and_return({})
        }
        specify {
          lambda { Hoarder::Storage.new('') }.should raise_error(RuntimeError, "Unable to load config file /hoarder.yml.")
        }
      end

    end
  end
  
end
