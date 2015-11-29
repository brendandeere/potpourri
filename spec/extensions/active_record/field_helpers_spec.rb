require 'spec_helper'

RSpec.describe Potpourri::ActiveRecord::FieldHelpers do

  before do
    TestClass = Struct.new(:foo)
    TestClass.include described_class
  end

  describe '.id_field' do
    subject { TestClass.id_field :test, {} }
    it { is_expected.to be_a Potpourri::ActiveRecord::IdentifierField }
  end
end
