require 'spec_helper'

RSpec.describe Potpourri::ReportConfigs do
  let(:test_class) { TestClass.new }

  before do
    TestClass = Struct.new(:foo) do
      include Potpourri::ReportConfigs
    end
  end

  describe '.fields' do
    subject { TestClass.fields fields }
    let(:fields) { [1, 2, 3] }

    it 'sets a class instance variable' do
      subject
      expect(test_class.class.instance_variable_get '@fields').to eq fields
    end
  end

  describe '.resource_class' do
    subject { TestClass.resource_class klass }
    let(:klass) { 'SomeClass' }

    it 'sets a class instance variable' do
      subject
      expect(test_class.class.instance_variable_get '@klass').to eq klass
    end
  end

  describe '#fields' do
    subject { test_class.fields }
    let(:fields) { [1, 2, 3] }

    before { TestClass.fields fields }
    it { is_expected.to eq fields }
  end

  describe '#resource_class' do
    subject { test_class.resource_class }
    let(:klass) { 'SomeClass' }

    before { TestClass.resource_class klass }
    it { is_expected.to eq klass }
  end
end
