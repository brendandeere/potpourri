require 'spec_helper'

RSpec.describe Potpourri::FieldHelpers do
  before do
    TestClass = Struct.new(:foo)
    TestClass.include described_class
  end

  describe '.field' do
    subject { TestClass.field :test, {} }
    it { is_expected.to be_a Potpourri::Field }
  end

  describe '.importable_field' do
    subject { TestClass.importable_field :test, {} }
    it { is_expected.to be_a Potpourri::ImportableField }
  end

  describe '.exportable_field' do
    subject { TestClass.exportable_field :test, {} }
    it { is_expected.to be_a Potpourri::ExportableField }
  end
end
